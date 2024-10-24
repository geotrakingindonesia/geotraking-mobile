import 'package:flutter/material.dart';
import 'package:geotraking/core/components/card_vessel_color.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/views/profile/report/jaraktempuh/components/detail_page.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class VesselPreviewTile extends StatefulWidget {
  const VesselPreviewTile({
    Key? key,
    this.mobileId,
    this.idfull,
    this.namaKapal,
    this.timestamp,
    this.speed,
  }) : super(key: key);

  final String? mobileId;
  final String? idfull;
  final String? namaKapal;
  final String? timestamp;
  final String? speed;

  @override
  _VesselPreviewTile createState() => _VesselPreviewTile();
}

class _VesselPreviewTile extends State<VesselPreviewTile> {
  final VesselService vesselService = VesselService();
  DateTime? _startDate;
  DateTime? _endDate;
  List<Map<String, dynamic>>? _historyData;
  bool _isLoading = false;

  // Future<void> _getData() async {
  //   if (_startDate != null && _endDate != null) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     _historyData = await vesselService.getJarakTempuhHistoryTraking(
  //       widget.mobileId!,
  //       _startDate,
  //       _endDate,
  //     );

  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _getData() async {
  //   if (_startDate != null && _endDate != null) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     try {
  //       _historyData = await vesselService
  //           .getJarakTempuhHistoryTraking(
  //         widget.mobileId!,
  //         _startDate,
  //         _endDate,
  //       )
  //           .timeout(Duration(seconds: 30), onTimeout: () {
  //         _resetForm();
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               'Upss, server sedang sibuk. Coba beberapa saat lagi.',
  //             ),
  //             backgroundColor: Colors.redAccent,
  //           ),
  //         );
  //         return [];
  //       });
  //     } catch (e) {
  //       print('Error fetching data: $e');
  //     } finally {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  Future<void> _getData() async {
    if (_startDate != null && _endDate != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        _historyData = await vesselService
            .getJarakTempuhHistoryTraking(
          widget.mobileId!,
          _startDate,
          _endDate,
        )
            .timeout(Duration(seconds: 30), onTimeout: () {
          _resetForm();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Upss, server sedang sibuk. Coba beberapa saat lagi.',
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
          return null;
        });

        if (_historyData == null) {
          _resetForm();
        }
      } catch (e) {
        print('Error fetching data: $e');
        _resetForm();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _resetForm() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _historyData = null;
    });
  }

  void _showDateRangePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Date Range'),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: SfDateRangePicker(
              todayHighlightColor: Colors.black,
              backgroundColor: Colors.transparent,
              rangeSelectionColor: Colors.blue[100],
              endRangeSelectionColor: Colors.blue,
              startRangeSelectionColor: Colors.blue,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  _startDate = args.value.startDate;
                  _endDate = args.value.endDate;

                  if (_startDate != null && _endDate != null) {
                    if (_endDate!.isBefore(_startDate!)) {
                      _endDate = null;
                    } else if (_endDate!.isAfter(DateTime.now())) {
                      _endDate = DateTime.now();
                    } else if (_endDate!
                        .isAfter(_startDate!.add(Duration(days: 30)))) {
                      _endDate = _startDate!.add(Duration(days: 30));
                    }
                    setState(() {});
                  }
                }
              },
              minDate: DateTime.now().subtract(Duration(days: 30)),
              maxDate: DateTime.now(),
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                _startDate,
                _endDate,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (_startDate != null && _endDate != null) {
                  _getData();
                }
              },
            ),
            TextButton(
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                _resetForm();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: cardVesselColor(widget.timestamp!),
      color: reportVesselColor(widget.speed!),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${widget.namaKapal ?? '-'}',
              style: TextStyle(color: cardTextColor(widget.timestamp!)),
            ),
            subtitle: Row(
              children: [
                Text(
                  'ID: ${widget.idfull ?? '-'}',
                  style: TextStyle(
                    color: cardHeadlineTextColor(widget.timestamp!),
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: _isLoading
                  ? CircularProgressIndicator(
                      color: cardTextColor(widget.timestamp!))
                  : Icon(Icons.date_range_rounded),
              color: cardTextColor(widget.timestamp!),
              onPressed: () {
                _showDateRangePicker(context);
              },
            ),
          ),
          if (_historyData != null) ...[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white60),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              data: _historyData,
                              startDate: _startDate,
                              endDate: _endDate,
                              vesselName: widget.namaKapal,
                              mobileId: widget.idfull,
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
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54),
                      onPressed: _resetForm,
                      child: Icon(Icons.refresh_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
