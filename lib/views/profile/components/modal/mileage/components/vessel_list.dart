// // ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, use_build_context_synchronously

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:geotraking/core/services/auth/authenticate_service.dart';
// import 'package:geotraking/core/services/vessel_service.dart';
// import 'package:geotraking/views/profile/report/jaraktempuh/components/vessel_preview_tile.dart';

// class VesselList extends StatefulWidget {
//   const VesselList({Key? key}) : super(key: key);

//   @override
//   State<VesselList> createState() => _VesselListState();
// }

// class _VesselListState extends State<VesselList> {
//   final VesselService vesselService = VesselService();
//   String _searchQuery = '';
//   String? _errorMessage;

//   List<Map<String, dynamic>>? _vesselList;
//   List<Map<String, dynamic>> _pagedData = [];

//   final _key = GlobalKey<FormState>();
//   final TextEditingController _searchController = TextEditingController();

//   bool _isLoading = false;
//   int _isAdmin = 0;

//   Timer? _debounce;

//   int _currentPage = 0;
//   final int _itemsPerPage = 25;

//   @override
//   void initState() {
//     super.initState();
//     _checkLoggedIn();
//   }

//   _checkLoggedIn() async {
//     final authService = AuthService();
//     final user = await authService.getCurrentUser();

//     if (user != null) {
//       setState(() {
//         _isAdmin = user.isAdmin;
//       });
//       _fetchVessel();
//     }
//   }

//   Future _fetchVessel() async {
//     try {
//       final vesselList = _isAdmin == 1
//           ? await vesselService.getDataKapalGeosat()
//           : await vesselService.getDataKapal();

//       print(vesselList);
//       setState(() {
//         _vesselList = vesselList;
//         _pagedData = vesselList!;
//       });
//     } catch (e) {
//       print('Error fetching kapal: $e');
//       setState(() {
//         _errorMessage = e.toString();
//       });
//     }
//   }

//   Future<void> _refreshDataKapal() async {
//     await _fetchVessel();
//     _applyFilters();
//   }

//   void _searchVessel(String query) {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();

//     _debounce = Timer(const Duration(seconds: 2), () {
//       _applyFilters();
//     });
//   }

//   void _applyFilters() {
//     List<Map<String, dynamic>> filteredList = _vesselList!;

//     if (_searchQuery.isNotEmpty) {
//       filteredList = filteredList.where((element) {
//         return (element['idfull']
//                     ?.toLowerCase()
//                     ?.contains(_searchQuery.toLowerCase()) ??
//                 false) ||
//             (element['nama_kapal']
//                     ?.toLowerCase()
//                     ?.contains(_searchQuery.toLowerCase()) ??
//                 false);
//       }).toList();
//     }

//     setState(() {
//       _pagedData = filteredList;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: _refreshDataKapal,
//         child: SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _searchController,
//                         style: TextStyle(color: Colors.black),
//                         decoration: InputDecoration(
//                           labelText: 'Cari Id/Nama',
//                           labelStyle: TextStyle(color: Colors.black),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(40)),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(40)),
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(40)),
//                             borderSide:
//                                 BorderSide(color: Colors.black, width: 2.0),
//                           ),
//                         ),
//                         onChanged: (query) {
//                           setState(() {
//                             _searchQuery = query;
//                             _searchVessel(query);
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               _vesselList != null
//                   ? Column(
//                       children: [
//                         Text(
//                           _searchController.text.isEmpty
//                               ? '${_pagedData.length} Vessel Data'
//                               : _pagedData.isEmpty
//                                   ? 'Vessel not found.'
//                                   : '${_pagedData.length} Vessel found.',
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                         ListView.builder(
//                           itemCount: _pagedData.length,
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             String idOrMobileId = _isAdmin == 1
//                                 ? _pagedData[index]['id'] ?? '-'
//                                 : _pagedData[index]['mobile_id'] ?? '-';
//                             String tglAktifasiOrTimestamp = _isAdmin == 1
//                                 ? _pagedData[index]['tgl_aktifasi'] ?? '-'
//                                 : _pagedData[index]['timestamp'] ?? '-';

//                             return Padding(
//                               padding: const EdgeInsets.only(top: 2),
//                               child: VesselPreviewTile(
//                                 mobileId: idOrMobileId,
//                                 idfull: _pagedData[index]['idfull'] ?? '-',
//                                 namaKapal:
//                                     _pagedData[index]['nama_kapal'] ?? '-',
//                                 timestamp: tglAktifasiOrTimestamp,
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     )
//                   : Center(
//                       child: FutureBuilder(
//                         future: Future.delayed(const Duration(seconds: 3)),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.done) {
//                             return Container();
//                           } else {
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Getting Data',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyLarge
//                                       ?.copyWith(color: Colors.black),
//                                 ),
//                                 SizedBox(width: 8),
//                                 SizedBox(
//                                   width: 18,
//                                   height: 18,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.black,
//                                     strokeWidth: 2,
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }
//                         },
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/views/profile/components/modal/mileage/components/vessel_preview_tile.dart';

class VesselList extends StatefulWidget {
  const VesselList({Key? key}) : super(key: key);

  @override
  State<VesselList> createState() => _VesselListState();
}

class _VesselListState extends State<VesselList> {
  final VesselService vesselService = VesselService();
  String _searchQuery = '';
  String? _errorMessage;

  List<Map<String, dynamic>>? _vesselList;
  List<Map<String, dynamic>> _pagedData = [];

  final _key = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  int _isAdmin = 0;

  Timer? _debounce;

  int _currentPage = 0;
  final int _itemsPerPage = 25;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  _checkLoggedIn() async {
    final authService = AuthService();
    final user = await authService.getCurrentUser();

    if (user != null) {
      setState(() {
        _isAdmin = user.isAdmin;
      });
      _fetchVessel();
    }
  }

  Future _fetchVessel() async {
    try {
      final vesselList = _isAdmin == 1
          ? await vesselService.getDataKapalGeosat()
          : await vesselService.getDataKapal();

      print(vesselList);
      setState(() {
        _vesselList = vesselList;
        _applyPagination();
      });
    } catch (e) {
      print('Error fetching kapal: $e');
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _refreshDataKapal() async {
    await _fetchVessel();
    _applyFilters();
  }

  void _searchVessel(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 2), () {
      _applyFilters();
    });
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filteredList = _vesselList!;

    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((element) {
        return (element['idfull']
                    ?.toLowerCase()
                    ?.contains(_searchQuery.toLowerCase()) ??
                false) ||
            (element['nama_kapal']
                    ?.toLowerCase()
                    ?.contains(_searchQuery.toLowerCase()) ??
                false);
      }).toList();
    }

    setState(() {
      _vesselList = filteredList;
      _currentPage = 0;
      _applyPagination();
    });
  }

  void _applyPagination() {
    if (_vesselList == null || _vesselList!.isEmpty) return;

    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;

    setState(() {
      _pagedData = _vesselList!.sublist(
        startIndex,
        endIndex > _vesselList!.length ? _vesselList!.length : endIndex,
      );
    });
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _applyPagination();
      });
    }
  }

  void _goToNextPage() {
    if ((_currentPage + 1) * _itemsPerPage < _vesselList!.length) {
      setState(() {
        _currentPage++;
        _applyPagination();
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
                          labelText: 'Cari Id/Nama',
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
                            _searchVessel(query);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _vesselList != null
                  ? Column(
                      children: [
                        Text(
                          _searchController.text.isEmpty
                              ? '${_vesselList!.length} Vessel Data'
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
                            String idOrMobileId = _isAdmin == 1
                                ? _pagedData[index]['id'] ?? '-'
                                : _pagedData[index]['mobile_id'] ?? '-';
                            String tglAktifasiOrTimestamp = _isAdmin == 1
                                ? _pagedData[index]['tgl_aktifasi'] ?? '-'
                                : _pagedData[index]['timestamp'] ?? '-';

                            return Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: VesselPreviewTile(
                                mobileId: idOrMobileId,
                                idfull: _pagedData[index]['idfull'] ?? '-',
                                namaKapal:
                                    _pagedData[index]['nama_kapal'] ?? '-',
                                timestamp: tglAktifasiOrTimestamp,
                                speed: _pagedData[index]['speed'] ?? '-',
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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: (_vesselList != null &&
                    _vesselList!.isNotEmpty &&
                    _currentPage > 0)
                ? _goToPreviousPage
                : null,
            child: Text(
              'Previous',
              style: TextStyle(
                color: (_vesselList != null &&
                        _vesselList!.isNotEmpty &&
                        _currentPage > 0)
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
          ),
          Text('Page ${_currentPage + 1}'),
          TextButton(
            onPressed: (_vesselList != null &&
                    _vesselList!.isNotEmpty &&
                    (_currentPage + 1) * _itemsPerPage < _vesselList!.length)
                ? _goToNextPage
                : null,
            child: Text(
              'Next',
              style: TextStyle(
                color: (_vesselList != null &&
                        _vesselList!.isNotEmpty &&
                        (_currentPage + 1) * _itemsPerPage <
                            _vesselList!.length)
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
