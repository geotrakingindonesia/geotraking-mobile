// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/views/profile/components/profile_kapal_preview_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileKapalList extends StatefulWidget {
  const ProfileKapalList({Key? key}) : super(key: key);

  @override
  State<ProfileKapalList> createState() => _ProfileKapalListState();
}

class _ProfileKapalListState extends State<ProfileKapalList> {
  final VesselService vesselService = VesselService();
  String _searchQuery = '';
  String? _errorMessage;

  List<Map<String, dynamic>>? _kapalMemberList;
  List<Map<String, dynamic>> _pagedData = [];

  final _key = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  bool _showAllChecked = true;
  bool _bluetrakerVMSChecked = false;
  bool _smartOneSolarChecked = false;
  bool _st6100rpmChecked = false;

  String _selectedTimezone = 'UTC+7';

  @override
  void initState() {
    super.initState();
    _fetchKapalMember();
    _loadTimeZonePreferencesFromSharedPreferences();
  }

  _loadTimeZonePreferencesFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final timeZonePreferences = prefs.getString('SetTimezonePreferences');
    if (timeZonePreferences != null) {
      setState(() {
        _selectedTimezone = timeZonePreferences;
      });
    }
  }

  Future _fetchKapalMember() async {
    try {
      final kapalMemberList = await vesselService.getDataKapal(_selectedTimezone);
      print(kapalMemberList);
      setState(() {
        _kapalMemberList = kapalMemberList;
        _pagedData = kapalMemberList!;
      });
    } catch (e) {
      print('Error fetching kapal: $e');
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _refreshDataKapal() async {
    await _fetchKapalMember();
    _applyFilters();
  }

  void _searchKapalMember(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilters();
    });
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filteredList = _kapalMemberList!;

    if (!_showAllChecked) {
      filteredList = _kapalMemberList!.where((element) {
        final type = element['type']?.toLowerCase() ?? '';
        if (_bluetrakerVMSChecked && type.contains('bluetraker')) return true;
        if (_smartOneSolarChecked && type.contains('smartone')) return true;
        if (_st6100rpmChecked && type.contains('st6100rpm')) return true;
        return false;
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((element) {
        return (element['idfull']
                    ?.toLowerCase()
                    ?.contains(_searchQuery.toLowerCase()) ??
                false) ||
            (element['nama_kapal']
                    ?.toLowerCase()
                    ?.contains(_searchQuery.toLowerCase()) ??
                false) ||
            (element['sn']
                    ?.toLowerCase()
                    ?.contains(_searchQuery.toLowerCase()) ??
                false) ||
            (element['imei']
                    ?.toLowerCase()
                    ?.contains(_searchQuery.toLowerCase()) ??
                false);
      }).toList();
    }

    setState(() {
      _pagedData = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshDataKapal,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Cari Id/Nama/SN/IMEI',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                          _searchKapalMember(query);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 127, 183, 126),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.filter_alt_rounded,
                          color: Color.fromARGB(255, 210, 227, 200)),
                      onPressed: () {
                        final RenderBox button =
                            context.findRenderObject() as RenderBox;
                        final RenderBox overlay = Overlay.of(context)
                            .context
                            .findRenderObject() as RenderBox;

                        final RelativeRect position = RelativeRect.fromRect(
                          Rect.fromPoints(
                            button.localToGlobal(Offset(button.size.width, 0),
                                ancestor: overlay),
                            button.localToGlobal(
                                Offset(button.size.width, button.size.height),
                                ancestor: overlay),
                          ),
                          Offset.zero & overlay.size,
                        );

                        showMenu(
                          color: Color.fromARGB(255, 210, 227, 200),
                          context: context,
                          position: position,
                          items: [
                            PopupMenuItem<String>(
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return CheckboxListTile(
                                    title: Text('Show All'),
                                    value: _showAllChecked,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _showAllChecked = newValue!;
                                        _bluetrakerVMSChecked = false;
                                        _smartOneSolarChecked = false;
                                        _st6100rpmChecked = false;
                                      });
                                      _applyFilters();
                                      Navigator.pop(context);
                                    },
                                    activeColor: Colors.green,
                                  );
                                },
                              ),
                            ),
                            PopupMenuItem<String>(
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return CheckboxListTile(
                                    title: Text('Bluetraker VMS'),
                                    value: _bluetrakerVMSChecked,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _bluetrakerVMSChecked = newValue!;
                                        _showAllChecked = false;
                                        _smartOneSolarChecked = false;
                                        _st6100rpmChecked = false;
                                      });
                                      _applyFilters();
                                      Navigator.pop(context);
                                    },
                                    activeColor: Colors.green,
                                  );
                                },
                              ),
                            ),
                            PopupMenuItem<String>(
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return CheckboxListTile(
                                    title: Text('SmartOne Solar'),
                                    value: _smartOneSolarChecked,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _smartOneSolarChecked = newValue!;
                                        _showAllChecked = false;
                                        _bluetrakerVMSChecked = false;
                                        _st6100rpmChecked = false;
                                      });
                                      _applyFilters();
                                      Navigator.pop(context);
                                    },
                                    activeColor: Colors.green,
                                  );
                                },
                              ),
                            ),
                            PopupMenuItem<String>(
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return CheckboxListTile(
                                    title: Text('ST6100RPM'),
                                    value: _st6100rpmChecked,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _st6100rpmChecked = newValue!;
                                        _showAllChecked = false;
                                        _bluetrakerVMSChecked = false;
                                        _smartOneSolarChecked = false;
                                      });
                                      _applyFilters();
                                      Navigator.pop(context);
                                    },
                                    activeColor: Colors.green,
                                  );
                                },
                              ),
                            ),
                          ],
                          elevation: 8.0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            _kapalMemberList != null
                ? Column(
                    children: [
                      Text(
                        _searchController.text.isEmpty
                            ? (_showAllChecked
                                ? '${_pagedData.length} Vessel Data'
                                : _pagedData.isEmpty
                                    ? 'Vessel ${_bluetrakerVMSChecked ? 'Bluetraker VMS' : _smartOneSolarChecked ? 'SmartOne Solar' : _st6100rpmChecked ? 'ST6100RPM' : ''} not found.'
                                    : '${_pagedData.length} Vessel ${_bluetrakerVMSChecked ? 'Bluetraker VMS' : _smartOneSolarChecked ? 'SmartOne Solar' : _st6100rpmChecked ? 'ST6100RPM' : ''} type found.')
                            : _pagedData.isEmpty
                                ? 'Vessel not found.'
                                : '${_pagedData.length} Vessel found.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      ListView.builder(
                        itemCount: _pagedData.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: ProfileKapalPreviewTile(
                              isAdmin: '0',
                              mobileId: _pagedData[index]['mobile_id'] ?? '-',
                              idfull: _pagedData[index]['idfull'] ?? '-',
                              namaKapal: _pagedData[index]['nama_kapal'] ?? '-',
                              kategori: _pagedData[index]['kategori'] ?? '-',
                              type: _pagedData[index]['type'] ?? '-',
                              custamer: _pagedData[index]['custamer'] ?? '-',
                              sn: _pagedData[index]['sn'] ?? '-',
                              imei: _pagedData[index]['imei'] ?? '-',
                              powerStatus:
                                  _pagedData[index]['powerstatus'] ?? '-',
                              externalVoltage:
                                  _pagedData[index]['externalvoltage'] ?? '-',
                              heading: _pagedData[index]['heading'] ?? '0',
                              speed: _pagedData[index]['speed'] ?? '0',
                              speedKmh: _pagedData[index]['speed_kmh'] ?? '0',
                              speedKn: _pagedData[index]['speed_kn'] ?? '0',
                              lat: _pagedData[index]['lat'] ?? '0',
                              lon: _pagedData[index]['lon'] ?? '0',
                              timestamp: _pagedData[index]['timestamp'] ?? '',
                              broadcast: _pagedData[index]['broadcast'] ?? '',
                              atpStart: _pagedData[index]['atp_start'] ?? '',
                              atpEnd: _pagedData[index]['atp_end'] ?? '',
                              rpm1: _pagedData[index]['rpm1'] ?? '0',
                              rpm2: _pagedData[index]['rpm2'] ?? '0',
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : Center(
                    child: FutureBuilder(
                      future: Future.delayed(const Duration(seconds: 3)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container();
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Getting Data',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.black),
                              ),
                              SizedBox(width: 8),
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
