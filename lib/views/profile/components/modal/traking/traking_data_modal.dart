// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unused_field, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geotraking/core/components/formated_latlong.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/views/profile/components/modal/traking/components/tab_download_history_tracking.dart';
import 'package:info_popup/info_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrakingDataModal extends StatefulWidget {
  String? mobileId;
  final Function(List<LatLng>, List<Marker>, List<double>) onTrackVessel;
  final Function() onClearHistory;

  TrakingDataModal({
    super.key,
    this.mobileId,
    required this.onTrackVessel,
    required this.onClearHistory,
  });

  @override
  _TrakingDataModalState createState() => _TrakingDataModalState();
}

class _TrakingDataModalState extends State<TrakingDataModal> {
  int? _radioValue;
  int _maxValue = 100;
  final VesselService vesselService = VesselService();
  final _textController = TextEditingController();
  final _textFieldKey = GlobalKey();
  String _textFieldValue = '';

  final formatterLatlong = FormatedLatlong();

  bool _isRadioButtonSelected = false;

  List<LatLng> _polylinePointsTraking = [];
  List<Marker> _markersTraking = [];
  List<double> _headingsTraking = [];

  bool _showButtons = false;
  bool _loading = false;
  bool _showHistoryData = false;
  List<dynamic> _historyData = [];

  @override
  void initState() {
    super.initState();
    _loadDataFromSharedPreferences();
  }

  @override
  void didUpdateWidget(TrakingDataModal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mobileId == oldWidget.mobileId) {
      _loadDataFromSharedPreferences();
    } else {
      setState(() {});
    }
  }

  _loadDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final radioValue = prefs.getInt('radioValue');
    final textFieldValue = prefs.getString('textFieldValue');
    final mobileId = prefs.getString('mobileId');

    print('radio ${radioValue}');
    print('text ${textFieldValue}');
    print('mobile Id ${mobileId}');
    print('mobile Id widget ${widget.mobileId}');

    if (widget.mobileId != mobileId) {
      setState(() {
        _radioValue = null;
        _textFieldValue = '';
        _textController.text = '';
      });
    } else {
      setState(() {
        if (radioValue != null) {
          _radioValue = radioValue;
        }

        if (textFieldValue != null) {
          _textFieldValue = textFieldValue;
          _textController.text = textFieldValue;
        }

        if (mobileId != null) {
          widget.mobileId = mobileId;
        }
      });
    }
  }

  Future<void> _saveDataToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('radioValue', _radioValue!);
    prefs.setString('textFieldValue', _textController.text);
    prefs.setString('mobileId', widget.mobileId!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'History Traking',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 0,
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value as int;
                            _maxValue = 100;
                            _textController.text = '100';
                            _isRadioButtonSelected = true;
                          });
                          _saveDataToSharedPreferences();
                        },
                      ),
                      Text('Last Position'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value as int;
                            _maxValue = 6;
                            _textController.text = '6';
                            _isRadioButtonSelected = true;
                          });
                          _saveDataToSharedPreferences();
                        },
                      ),
                      Text('Last Hour'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value as int;
                            _maxValue = 7;
                            _textController.text = '7';
                            _isRadioButtonSelected = true;
                          });
                          _saveDataToSharedPreferences();
                        },
                      ),
                      Text('Last Day Position'),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: _textFieldKey,
                      controller: _textController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide(
                            color: _isRadioButtonSelected
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide(
                            color: _isRadioButtonSelected
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color:
                            _isRadioButtonSelected ? Colors.black : Colors.grey,
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: _maxValue.toString().length,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      enabled: _isRadioButtonSelected,
                      onChanged: (value) {
                        setState(() {
                          _isRadioButtonSelected = true;
                        });
                        _saveDataToSharedPreferences();
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade400),
                      child: _loading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Getting Data',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              'Track Vessel',
                              style: TextStyle(color: Colors.white),
                            ),
                      onPressed: () async {
                        setState(() {
                          _loading = true;
                        });
                        _polylinePointsTraking.clear();
                        _markersTraking.clear();

                        int limit = 0;
                        DateTime? fromDate;

                        switch (_radioValue) {
                          case 0:
                            limit = int.parse(_textController.text);
                            break;
                          case 1:
                            fromDate = DateTime.now().subtract(Duration(
                                hours: int.parse(_textController.text)));
                            break;
                          case 2:
                            fromDate = DateTime.now().subtract(Duration(
                                days: int.parse(_textController.text)));
                            break;
                          default:
                            break;
                        }

                        var result = await vesselService.getHistoryTrakingKapal(
                            widget.mobileId ?? '', limit, fromDate);

                        setState(() {
                          _historyData = result ?? [];
                          _showButtons = true;
                          _loading = false;
                          print(
                              'Loading: $_loading, Show Buttons: $_showButtons');

                          for (var data in _historyData) {
                            var latitude = double.parse(data['latitude']);
                            var longitude = double.parse(data['longitude']);

                            _polylinePointsTraking
                                .add(LatLng(latitude, longitude));
                            _headingsTraking.add(double.parse(data['heading']));

                            // Create a Marker with an InfoPopup
                            _markersTraking.add(
                              Marker(
                                point: LatLng(latitude, longitude),
                                width: 13,
                                height: 13,
                                child: InfoPopupWidget(
                                  child: Transform.rotate(
                                    angle: double.parse(data['heading']) *
                                        pi /
                                        180,
                                    child: Image.asset(
                                      'assets/images/arrow_traking.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  customContent: () => Container(
                                    padding: EdgeInsets.all(8),
                                    width: 290,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Latitude',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                ': ${formatterLatlong.formatLatitude(latitude)}',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Longitude',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                ': ${formatterLatlong.formatLongitude(longitude)}',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Heading',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                ': ${double.parse(data['heading']).toStringAsFixed(2)}°',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          widget.onTrackVessel(
                            _polylinePointsTraking,
                            _markersTraking,
                            _headingsTraking,
                          );
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54),
                      onPressed: () async {
                        setState(() {
                          _textController.clear();
                          _historyData.clear();
                          _showButtons = false;
                          _showHistoryData = false;
                          _radioValue = null;
                        });
                        widget.onClearHistory();
                        final prefs = await SharedPreferences.getInstance();
                        prefs.remove('radioValue');
                        prefs.remove('textFieldValue');
                        prefs.remove('mobileId');
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                      // child: Icon(Icons.refresh_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              _showButtons
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orangeAccent),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TabDownloadHistoryTraking(
                                        mobileId: widget.mobileId!,
                                        historyData: _historyData,
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.remove_red_eye_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
