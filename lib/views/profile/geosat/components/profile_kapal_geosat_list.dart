// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:geotraking/core/services/kapal_geosat_service.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/views/profile/components/profile_kapal_preview_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:geotraking/views/profile/geosat/components/profile_kapal_geosat_preview_tile.dart';

class ProfileKapalGeosatList extends StatefulWidget {
  const ProfileKapalGeosatList({Key? key}) : super(key: key);

  @override
  State<ProfileKapalGeosatList> createState() => _ProfileKapalGeosatListState();
}

class _ProfileKapalGeosatListState extends State<ProfileKapalGeosatList> {
  final VesselService vesselService = VesselService();
  String? _errorMessage;
  String _searchQuery = '';

  List<Map<String, dynamic>>? _kapalGeosatList;
  List<Map<String, dynamic>> _pagedData = [];

  final _key = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  bool _showAllChecked = true;
  bool _bluetrakerVMSChecked = false;
  bool _smartOneSolarChecked = false;
  bool _st6100rpmChecked = false;

  Timer? _debounce;

  int _currentPage = 0;
  final int _itemsPerPage = 25;

  String _selectedTimezonePreferences = 'UTC+7';
  String _selectedSpeedPreferences = 'Knots';
  String _selectedCoordinatePreferences = 'Degrees';

  @override
  void initState() {
    super.initState();
    _fetchKapalGeosat();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedSpeedPreferences =
          prefs.getString('SetSpeedPreferences') ?? 'Knots';
      _selectedCoordinatePreferences =
          prefs.getString('SetCoordinatePreferences') ?? 'Degrees';
      _selectedTimezonePreferences =
          prefs.getString('SetTimezonePreferences') ?? 'UTC+7';
    });
  }

  Future _fetchKapalGeosat() async {
    try {
      final kapalGeosatList = await vesselService.getDataKapalGeosat();
      setState(() {
        _kapalGeosatList = kapalGeosatList;
        // _pagedData = kapalGeosatList!;
        _applyFilters(); // Apply filters after fetching data
        // _pagingController.refresh(); // Refresh the paging controller
      });
    } catch (e) {
      print('Error fetching kapal: $e');
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _refreshDataKapal() async {
    await _fetchKapalGeosat();
    _applyFilters();
  }

  void _onSearchQueryChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 2), () {
      _applyFilters();
    });
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filteredList = _kapalGeosatList!;

    if (!_showAllChecked) {
      filteredList = _kapalGeosatList!.where((element) {
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

    // Pagination logic: get the subset of items for the current page
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex < filteredList.length) {
      _pagedData = filteredList.sublist(startIndex,
          endIndex > filteredList.length ? filteredList.length : endIndex);
    } else {
      _pagedData = [];
    }

    setState(() {
      _pagedData = _pagedData;
      // _pagedData = filteredList;
    });
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
      _applyFilters();
    });
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _applyFilters();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
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
                          });
                          _onSearchQueryChanged(query);
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
              _kapalGeosatList != null
                  ? Column(
                      children: [
                        Text(
                          _searchController.text.isEmpty
                              ? (_showAllChecked
                                  ? '${_kapalGeosatList?.length ?? 0} Vessel Data'
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
                            String getSpeedValue(Map<String, dynamic> data,
                                String selectedSpeed) {
                              switch (selectedSpeed) {
                                case 'Knots':
                                  return (data['speed_kn'] ?? 0).toString();
                                case 'Km/h':
                                  return (data['speed_kmh'] ?? 0).toString();
                                case 'm/s':
                                  return (data['speed_ms'] ?? 0).toString();
                                case 'mp/h':
                                  return (data['speed_mph'] ?? 0).toString();
                                default:
                                  return '0';
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: ProfileKapalPreviewTile(
                                selectedTimeZonePreferences:
                                    _selectedTimezonePreferences,
                                selectedSpeedPreferences:
                                    _selectedSpeedPreferences,
                                selectedCoordinatePreferences:
                                    _selectedCoordinatePreferences,
                                mobileId: _pagedData[index]['id'] ?? '-',
                                idfull: _pagedData[index]['idfull'] ?? '-',
                                namaKapal:
                                    _pagedData[index]['nama_kapal'] ?? '-',
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
                                // speed: _pagedData[index]['speed'] ?? '0',
                                speed: getSpeedValue(_pagedData[index],
                                    _selectedSpeedPreferences),
                                speedKmh: _pagedData[index]['speed_kmh'] ?? '0',
                                speedKn: _pagedData[index]['speed_kn'] ?? '0',
                                lat: _pagedData[index]['lat'] ?? '0',
                                lon: _pagedData[index]['lon'] ?? '0',
                                timestamp: _pagedData[index]['tgl_aktifasi']
                                        ?.toString() ??
                                    '-',
                                broadcast: _pagedData[index]['broadcast']
                                        ?.toString() ??
                                    '-',
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
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _previousPage,
              icon: Icon(Icons.arrow_back),
            ),
            Text('Page ${_currentPage + 1}'),
            IconButton(
              onPressed: _nextPage,
              icon: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
    // return RefreshIndicator(
    //   onRefresh: _refreshDataKapal,
    //   child: SingleChildScrollView(
    //     physics: AlwaysScrollableScrollPhysics(),
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(16.0),
    //           child: Row(
    //             children: [
    //               Expanded(
    //                 child: TextField(
    //                   controller: _searchController,
    //                   style: TextStyle(color: Colors.black),
    //                   decoration: InputDecoration(
    //                     labelText: 'Cari Id/Nama/SN/IMEI',
    //                     labelStyle: TextStyle(color: Colors.black),
    //                     border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.all(Radius.circular(40)),
    //                     ),
    //                     enabledBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.all(Radius.circular(40)),
    //                       borderSide: BorderSide(color: Colors.black),
    //                     ),
    //                     focusedBorder: OutlineInputBorder(
    //                       borderRadius: BorderRadius.all(Radius.circular(40)),
    //                       borderSide:
    //                           BorderSide(color: Colors.black, width: 2.0),
    //                     ),
    //                   ),
    //                   onChanged: (query) {
    //                     setState(() {
    //                       _searchQuery = query;
    //                     });
    //                     _onSearchQueryChanged(query);
    //                   },
    //                 ),
    //               ),
    //               SizedBox(width: 10),
    //               Container(
    //                 decoration: BoxDecoration(
    //                   color: Color.fromARGB(255, 127, 183, 126),
    //                   shape: BoxShape.circle,
    //                 ),
    //                 child: IconButton(
    //                   icon: Icon(Icons.filter_alt_rounded,
    //                       color: Color.fromARGB(255, 210, 227, 200)),
    //                   onPressed: () {
    //                     final RenderBox button =
    //                         context.findRenderObject() as RenderBox;
    //                     final RenderBox overlay = Overlay.of(context)
    //                         .context
    //                         .findRenderObject() as RenderBox;

    //                     final RelativeRect position = RelativeRect.fromRect(
    //                       Rect.fromPoints(
    //                         button.localToGlobal(Offset(button.size.width, 0),
    //                             ancestor: overlay),
    //                         button.localToGlobal(
    //                             Offset(button.size.width, button.size.height),
    //                             ancestor: overlay),
    //                       ),
    //                       Offset.zero & overlay.size,
    //                     );

    //                     showMenu(
    //                       color: Color.fromARGB(255, 210, 227, 200),
    //                       context: context,
    //                       position: position,
    //                       items: [
    //                         PopupMenuItem<String>(
    //                           child: StatefulBuilder(
    //                             builder: (context, setState) {
    //                               return CheckboxListTile(
    //                                 title: Text('Show All'),
    //                                 value: _showAllChecked,
    //                                 onChanged: (bool? newValue) {
    //                                   setState(() {
    //                                     _showAllChecked = newValue!;
    //                                     _bluetrakerVMSChecked = false;
    //                                     _smartOneSolarChecked = false;
    //                                     _st6100rpmChecked = false;
    //                                   });
    //                                   _applyFilters();
    //                                   Navigator.pop(context);
    //                                 },
    //                                 activeColor: Colors.green,
    //                               );
    //                             },
    //                           ),
    //                         ),
    //                         PopupMenuItem<String>(
    //                           child: StatefulBuilder(
    //                             builder: (context, setState) {
    //                               return CheckboxListTile(
    //                                 title: Text('Bluetraker VMS'),
    //                                 value: _bluetrakerVMSChecked,
    //                                 onChanged: (bool? newValue) {
    //                                   setState(() {
    //                                     _bluetrakerVMSChecked = newValue!;
    //                                     _showAllChecked = false;
    //                                     _smartOneSolarChecked = false;
    //                                     _st6100rpmChecked = false;
    //                                   });
    //                                   _applyFilters();
    //                                   Navigator.pop(context);
    //                                 },
    //                                 activeColor: Colors.green,
    //                               );
    //                             },
    //                           ),
    //                         ),
    //                         PopupMenuItem<String>(
    //                           child: StatefulBuilder(
    //                             builder: (context, setState) {
    //                               return CheckboxListTile(
    //                                 title: Text('SmartOne Solar'),
    //                                 value: _smartOneSolarChecked,
    //                                 onChanged: (bool? newValue) {
    //                                   setState(() {
    //                                     _smartOneSolarChecked = newValue!;
    //                                     _showAllChecked = false;
    //                                     _bluetrakerVMSChecked = false;
    //                                     _st6100rpmChecked = false;
    //                                   });
    //                                   _applyFilters();
    //                                   Navigator.pop(context);
    //                                 },
    //                                 activeColor: Colors.green,
    //                               );
    //                             },
    //                           ),
    //                         ),
    //                         PopupMenuItem<String>(
    //                           child: StatefulBuilder(
    //                             builder: (context, setState) {
    //                               return CheckboxListTile(
    //                                 title: Text('ST6100RPM'),
    //                                 value: _st6100rpmChecked,
    //                                 onChanged: (bool? newValue) {
    //                                   setState(() {
    //                                     _st6100rpmChecked = newValue!;
    //                                     _showAllChecked = false;
    //                                     _bluetrakerVMSChecked = false;
    //                                     _smartOneSolarChecked = false;
    //                                   });
    //                                   _applyFilters();
    //                                   Navigator.pop(context);
    //                                 },
    //                                 activeColor: Colors.green,
    //                               );
    //                             },
    //                           ),
    //                         ),
    //                       ],
    //                       elevation: 8.0,
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         _kapalGeosatList != null
    //             ? Column(
    //                 children: [
    //                   Text(
    //                     _searchController.text.isEmpty
    //                         ? (_showAllChecked
    //                             ? '${_pagedData.length} Vessel Data'
    //                             : _pagedData.isEmpty
    //                                 ? 'Vessel ${_bluetrakerVMSChecked ? 'Bluetraker VMS' : _smartOneSolarChecked ? 'SmartOne Solar' : _st6100rpmChecked ? 'ST6100RPM' : ''} not found.'
    //                                 : '${_pagedData.length} Vessel ${_bluetrakerVMSChecked ? 'Bluetraker VMS' : _smartOneSolarChecked ? 'SmartOne Solar' : _st6100rpmChecked ? 'ST6100RPM' : ''} type found.')
    //                         : _pagedData.isEmpty
    //                             ? 'Vessel not found.'
    //                             : '${_pagedData.length} Vessel found.',
    //                     style: Theme.of(context).textTheme.bodyLarge,
    //                   ),
    //                   ListView.builder(
    //                     itemCount: _pagedData.length,
    //                     shrinkWrap: true,
    //                     physics: NeverScrollableScrollPhysics(),
    //                     itemBuilder: (context, index) {
    //                       return Padding(
    //                         padding: const EdgeInsets.only(top: 2),
    //                         child: ProfileKapalPreviewTile(
    //                           mobileId: _pagedData[index]['id'] ?? '-',
    //                           idfull: _pagedData[index]['idfull'] ?? '-',
    //                           namaKapal: _pagedData[index]['nama_kapal'] ?? '-',
    //                           kategori: _pagedData[index]['kategori'] ?? '-',
    //                           type: _pagedData[index]['type'] ?? '-',
    //                           custamer: _pagedData[index]['custamer'] ?? '-',
    //                           sn: _pagedData[index]['sn'] ?? '-',
    //                           imei: _pagedData[index]['imei'] ?? '-',
    //                           powerStatus:
    //                               _pagedData[index]['powerstatus'] ?? '-',
    //                           externalVoltage:
    //                               _pagedData[index]['externalvoltage'] ?? '-',
    //                           heading: _pagedData[index]['heading'] ?? '0',
    //                           speed: _pagedData[index]['speed'] ?? '0',
    //                           speedKmh: _pagedData[index]['speed_kmh'] ?? '0',
    //                           speedKn: _pagedData[index]['speed_kn'] ?? '0',
    //                           lat: _pagedData[index]['lat'] ?? '0',
    //                           lon: _pagedData[index]['lon'] ?? '0',
    //                           timestamp: _pagedData[index]['tgl_aktifasi']
    //                                   ?.toString() ??
    //                               '-',
    //                           broadcast:
    //                               _pagedData[index]['broadcast']?.toString() ??
    //                                   '-',
    //                           atpStart: _pagedData[index]['atp_start'] ?? '',
    //                           atpEnd: _pagedData[index]['atp_end'] ?? '',
    //                           rpm1: _pagedData[index]['rpm1'] ?? '0',
    //                           rpm2: _pagedData[index]['rpm2'] ?? '0',
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                   // test untuk pagination
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       ElevatedButton(
    //                         onPressed: _previousPage,
    //                         child: Text('Previous'),
    //                       ),
    //                       ElevatedButton(
    //                         onPressed: _nextPage,
    //                         child: Text('Next'),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               )
    //             : Center(
    //                 child: FutureBuilder(
    //                   future: Future.delayed(const Duration(seconds: 3)),
    //                   builder: (context, snapshot) {
    //                     if (snapshot.connectionState == ConnectionState.done) {
    //                       return Container();
    //                     } else {
    //                       return Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Text(
    //                             'Getting Data',
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyLarge
    //                                 ?.copyWith(color: Colors.black),
    //                           ),
    //                           SizedBox(width: 8),
    //                           SizedBox(
    //                             width: 18,
    //                             height: 18,
    //                             child: CircularProgressIndicator(
    //                               color: Colors.black,
    //                               strokeWidth: 2,
    //                             ),
    //                           ),
    //                         ],
    //                       );
    //                     }
    //                   },
    //                 ),
    //               ),
    //       ],
    //     ),
    //   ),
    // );
    // return FutureBuilder(
    //   future: _fetchKapalGeosatFuture,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: [
    //             Expanded(
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     'Getting Data',
    //                     style: Theme.of(context)
    //                         .textTheme
    //                         .bodyMedium
    //                         ?.copyWith(color: Colors.black),
    //                   ),
    //                   SizedBox(width: 8),
    //                   SizedBox(
    //                     width: 16,
    //                     height: 16,
    //                     child: CircularProgressIndicator(
    //                       color: Colors.black,
    //                       strokeWidth: 2,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}');
    //     } else {
    //       return SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: TextField(
    //                 decoration: InputDecoration(
    //                   labelText: 'Cari Id Kapal, Nama kapal, SN/IMEI',
    //                   border: OutlineInputBorder(),
    //                 ),
    //                 onChanged: (query) {
    //                   setState(() {
    //                     _searchQuery = query;
    //                     _searchKapalGeosat(query);
    //                   });
    //                 },
    //               ),
    //             ),
    //             Column(
    //               children: [
    //                 Text(
    //                   _searchQuery.isEmpty
    //                       ? '${_kapalGeosatList!.length} Vessel Data'
    //                       : _pagedData.isEmpty
    //                           ? 'Vessel Not Found.'
    //                           : '${_pagedData.length} Vessel Found.',
    //                   style: Theme.of(context).textTheme.bodyLarge,
    //                 ),
    //                 ListView.builder(
    //                   itemCount: _pagedData.length,
    //                   shrinkWrap: true,
    //                   physics: NeverScrollableScrollPhysics(),
    //                   itemBuilder: (context, index) {
    //                     return Padding(
    //                       padding: const EdgeInsets.only(top: 2),
    // child: ProfileKapalGeosatPreviewTile(
    // mobileId: _pagedData[index]['id'] ?? '-',
    // idfull: _pagedData[index]['idfull'] ?? '-',
    // namaKapal: _pagedData[index]['nama_kapal'] ?? '-',
    // kategori: _pagedData[index]['kategori'] ?? '-',
    // type: _pagedData[index]['type'] ?? '-',
    // custamer: _pagedData[index]['custamer'] ?? '-',
    // sn: _pagedData[index]['sn'] ?? '-',
    // imei: _pagedData[index]['imei'] ?? '-',
    // powerStatus:
    //     _pagedData[index]['powerstatus'] ?? '-',
    // externalVoltage:
    //     _pagedData[index]['externalvoltage'] ?? '-',
    // heading: _pagedData[index]['heading'] ?? '0',
    // speed: _pagedData[index]['speed'] ?? '0',
    // speedKmh: _pagedData[index]['speed_kmh'] ?? '0',
    // speedKn: _pagedData[index]['speed_kn'] ?? '0',
    // lat: _pagedData[index]['lat'] ?? '0',
    // lon: _pagedData[index]['lon'] ?? '0',
    // timestamp: _pagedData[index]['tgl_aktifasi'] ?? '',
    // broadcast: _pagedData[index]['broadcast'] ?? '',
    // atpStart: _pagedData[index]['atp_start'] ?? '',
    // atpEnd: _pagedData[index]['atp_end'] ?? '',
    //                       child: ProfileKapalGeosatPreviewTile(
    //                         mobileId: _pagedData[index]['id'] ?? '-',
    //                         idfull: _pagedData[index]['idfull'] ?? '-',
    //                         namaKapal: _pagedData[index]['nama_kapal'] ?? '-',
    //                         kategori: _pagedData[index]['kategori'] ?? '-',
    //                         type: _pagedData[index]['type'] ?? '-',
    //                         custamer: _pagedData[index]['custamer'] ?? '-',
    //                         sn: _pagedData[index]['sn'] ?? '-',
    //                         imei: _pagedData[index]['imei'] ?? '-',
    //                         powerStatus:
    //                             _pagedData[index]['powerstatus'] ?? '-',
    //                         externalVoltage:
    //                             _pagedData[index]['externalvoltage'] ?? '-',
    //                         heading: _pagedData[index]['heading'] ?? '0',
    //                         speed: _pagedData[index]['speed'] ?? '0',
    //                         speedKmh: _pagedData[index]['speed_kmh'].toString() ?? '0',
    //                         speedKn: _pagedData[index]['speed_kn'].toString() ?? '0',
    //                         lat: _pagedData[index]['lat'] ?? '0',
    //                         lon: _pagedData[index]['lon'] ?? '0',
    //                         timestamp: _pagedData[index]['tgl_aktifasi']
    //                                 // ?.toIso8601String() ??
    //                                 ?.toString() ??
    //                             '-',
    //                         broadcast: _pagedData[index]['broadcast']
    //                                 // ?.toIso8601String() ??
    //                                 ?.toString() ??
    //                             '-',
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               ],
    //             )
    //           ],
    //         ),
    //       );
    //       // return Column(
    //       //   children: [
    //       //     Padding(
    //       //       padding: const EdgeInsets.all(16.0),
    //       //       child: TextField(
    //       //         decoration: InputDecoration(
    //       //           labelText: 'Cari Id Kapal, Nama kapal, SN/IMEI',
    //       //           border: OutlineInputBorder(),
    //       //         ),
    //       //         onChanged: (query) {
    //       //           setState(() {
    //       //             _searchQuery = query;
    //       //             _searchKapalGeosat(query);
    //       //           });
    //       //         },
    //       //       ),
    //       //     ),
    //       //     Expanded(
    //       //       child: ListView.builder(
    //       //         itemCount: _pagedData.length,
    //       //         itemBuilder: (context, index) {
    //       //           return Padding(
    //       //             padding: const EdgeInsets.only(top: 2),
    //       //             child: ProfileKapalGeosatPreviewTile(
    //       //               // idfull: _pagedData[index]['idfull'] ?? '-',
    //       //               // sn: _pagedData[index]['sn'] ?? '-',
    //       //               // imei: _pagedData[index]['imei'] ?? '-',
    //       //               // namaKapal: _pagedData[index]['nama_kapal'] ?? '-',
    //       //               // kategori: _pagedData[index]['kategori'] ?? '-',
    //       //               // type: _pagedData[index]['type'] ?? '-',
    //       //               // lat: _pagedData[index]['lat'] ?? '-',
    //       //               // lon: _pagedData[index]['lon'] ?? '-',
    //       //               // customer: _pagedData[index]['custamer'] ?? '-',
    //       //               // // timestamp: _pagedData[index]['tgl_aktifasi'] ?? '-',
    //       //               // timestamp: _pagedData[index]['tgl_aktifasi']
    //       //               //         ?.toIso8601String() ??
    //       //               //     '-',
    //       //               // atpStart:
    //       //               //     DateTime.parse(_pagedData[index]['atp_start']),
    //       //               // atpEnd: DateTime.parse(_pagedData[index]['atp_end']),
    //       //               // atpStart: _pagedData[index]['atp_start'],
    //       //               // atpEnd: _pagedData[index]['atp_end'],

    //       //               mobileId: _pagedData[index]['id'] ?? '-',
    //       //               idfull: _pagedData[index]['idfull'] ?? '-',
    //       //               namaKapal: _pagedData[index]['nama_kapal'] ?? '-',
    //       //               kategori: _pagedData[index]['kategori'] ?? '-',
    //       //               type: _pagedData[index]['type'] ?? '-',
    //       //               custamer: _pagedData[index]['custamer'] ?? '-',
    //       //               sn: _pagedData[index]['sn'] ?? '-',
    //       //               imei: _pagedData[index]['imei'] ?? '-',
    //       //               powerStatus: _pagedData[index]['powerstatus'] ?? '-',
    //       //               externalVoltage:
    //       //                   _pagedData[index]['externalvoltage'] ?? '-',
    //       //               heading: _pagedData[index]['heading'] ?? '0',
    //       //               speed: _pagedData[index]['speed'] ?? '0',
    //       //               lat: _pagedData[index]['lat'] ?? '0',
    //       //               lon: _pagedData[index]['lon'] ?? '0',
    //       //               timestamp: _pagedData[index]['tgl_aktifasi']
    //       //                       ?.toIso8601String() ??
    //       //                   '-',
    //       //               // timestamp: kapalMember.timestamp!.toString(),
    //       //             ),
    //       //           );
    //       //         },
    //       //       ),
    //       //     ),
    //       //     // Row(
    //       //     //   mainAxisAlignment: MainAxisAlignment.center,
    //       //     //   children: [
    //       //     //     ElevatedButton(
    //       //     //       onPressed: _currentPage > 1
    //       //     //           ? () {
    //       //     //               setState(() {
    //       //     //                 _currentPage--;
    //       //     //               });
    //       //     //               _paginate(_currentPage);
    //       //     //             }
    //       //     //           : null,
    //       //     //       child: Text('Previous'),
    //       //     //     ),
    //       //     //     SizedBox(width: 10),
    //       //     //     Text(
    //       //     //         'Page $_currentPage of ${(_kapalGeosatList!.length / _itemsPerPage).ceil()}'),
    //       //     //     SizedBox(width: 10),
    //       //     //     ElevatedButton(
    //       //     //       onPressed: _currentPage <
    //       //     //               (_kapalGeosatList!.length / _itemsPerPage).ceil()
    //       //     //           ? () {
    //       //     //               setState(() {
    //       //     //                 _currentPage++;
    //       //     //               });
    //       //     //               _paginate(_currentPage);
    //       //     //             }
    //       //     //           : null,
    //       //     //       child: Text('Next'),
    //       //     //     ),
    //       //     //   ],
    //       //     // ),
    //       //   ],
    //       // );
    //     }
    //   },
    // );
  }
}
