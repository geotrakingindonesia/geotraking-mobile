// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, sort_child_properties_last, deprecated_member_use
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/components/map_config.dart';
// import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:geotraking/core/components/marker_image_widget.dart';
// import 'package:geotraking/core/constants/app_colors.dart';
// import 'package:geotraking/core/models/kapal_member.dart';
// import 'package:geotraking/core/services/kapal_member_service.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/views/profile/components/modal/airtime/airtime_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/mileage/mileage_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/weather/weather_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/traking/traking_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/vessel/vessel_data_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong2/latlong.dart';

class ProfileTrackingOnePage extends StatefulWidget {
  final String idFull;
  final String? mobileId;
  final String? timestamp;
  final String? heading;
  final String? lat;
  final String? lon;

  const ProfileTrackingOnePage({
    super.key,
    required this.idFull,
    this.mobileId,
    this.timestamp,
    this.heading,
    required this.lat,
    required this.lon,
  });
  @override
  _ProfileTrackingOnePageState createState() => _ProfileTrackingOnePageState();
}

// class _ProfileTrackingOnePageState extends State<ProfileTrackingOnePage> {
//   final KapalMemberService kapalMemberService = KapalMemberService();
//   final MapController mapController = MapController();
//   final String _selectedLanguage = 'English';
//   KapalMember? kapalMember;
//   List<LatLng> _polylinePointsTraking = [];
//   List<Marker> _markersTraking = [];
//   List<double> _headingsTraking = [];
//   List<Marker> _initialMarkers = [];
//   Timer? _timer;
//   int _currentIndex = 0;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     kapalMemberService.getDataKapal().then((value) {
//       setState(() {
//         kapalMember =
//             value.firstWhere((member) => member.idfull == widget.idFull);
//       });
//     });
//   }

//   void _onTrackVessel(List<LatLng> polylinePoints, List<Marker> markers,
//       List<double> headings) {
//     setState(() {
//       _polylinePointsTraking = polylinePoints;
//       _markersTraking = markers;
//       _headingsTraking = headings;
//       _initialMarkers = List.from(markers);
//     });
//   }

//   void _startMovingMarkers() {
//     _timer?.cancel();
//     _currentIndex = _polylinePointsTraking.length - 1;
//     _timer = Timer.periodic(Duration(seconds: 2), (timer) {
//       if (_polylinePointsTraking.isEmpty || _markersTraking.isEmpty) return;
//       setState(() {
//         _currentIndex = (_currentIndex - 1) % _polylinePointsTraking.length;
//         if (_currentIndex < 0) {
//           _currentIndex = _polylinePointsTraking.length - 1;
//         }
//         LatLng currentPosition = _polylinePointsTraking[_currentIndex];
//         List<Marker> updatedMarkers = [];
//         for (var i = 0; i < _markersTraking.length; i++) {
//           if (i == _currentIndex) {
//             updatedMarkers.add(
//               Marker(
//                 point: _polylinePointsTraking[i],
//                 width: 30,
//                 height: 30,
//                 child: MarkerImageWidget(
//                   timestamp: widget.timestamp,
//                   heading: _headingsTraking[i].toString(),
//                 ),
//               ),
//             );
//           } else {
//             updatedMarkers.add(_markersTraking[i]);
//           }
//         }
//         _markersTraking = updatedMarkers;
//         mapController.move(currentPosition, 10.0);
//       });
//     });

//     setState(() {
//       _isPlaying = true;
//     });

//     if (_polylinePointsTraking.isNotEmpty) {
//       mapController.move(_polylinePointsTraking[_currentIndex], 10.0);
//     }
//   }

//   void _stopMovingMarkers() {
//     _timer?.cancel();
//     setState(() {
//       _isPlaying = false;
//       _markersTraking = List.from(_initialMarkers);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldWithBoxBackground,
//       appBar: AppBar(
//         title: Text(Localization.getTrackKapalKu(_selectedLanguage) +
//             ' (${widget.idFull})'),
//         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: Colors.black,
//             ),
//         leading: const AppBackButton(),
//       ),
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: mapController,
//             options: MapOptions(
//               initialCenter: LatLng(widget.lat, widget.lon),
//               initialZoom: 8,
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 userAgentPackageName: 'com.example.app',
//               ),
//               MarkerLayer(markers: [
//                 Marker(
//                   point: LatLng(widget.lat, widget.lon),
//                   width: 30,
//                   height: 30,
//                   child: MarkerImageWidget(
//                       timestamp: widget.timestamp, heading: widget.heading),
//                 ),
//               ]),
//               PolylineLayer(
//                 polylines: [
//                   Polyline(
//                     points: _polylinePointsTraking,
//                     color: Colors.blue,
//                     strokeWidth: 2,
//                   ),
//                 ],
//               ),
//               MarkerLayer(
//                 markers: _markersTraking,
//               ),
//             ],
//           ),
//           MapTool(mapController: mapController),
//           if (_polylinePointsTraking.isNotEmpty)
//             // Positioned(
//             //   bottom: 20,
//             //   right: 20,
//             //   child: Row(
//             //     mainAxisSize: MainAxisSize.min,
//             //     children: [
//             //       // Pause button
//             //       if (_isPlaying) ...[
//             //         IconButton(
//             //           icon: Icon(Icons.pause),
//             //           color: Colors.blueAccent,
//             //           onPressed: () {
//             //             // _pauseMovingMarkers();
//             //           },
//             //         ),
//             //         SizedBox(width: 10),
//             //       ],
//             //       // Stop button
//             //       IconButton(
//             //         icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
//             //         color: _isPlaying ? Colors.red : Colors.blueAccent,
//             //         onPressed: () {
//             //           if (_isPlaying) {
//             //             _stopMovingMarkers();
//             //           } else {
//             //             _startMovingMarkers();
//             //           }
//             //         },
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             Positioned(
//               bottom: 16,
//               right: 16,
//               child: Container(
//                 padding: EdgeInsets.all(1),
//                 decoration: BoxDecoration(
//                   color: Colors.black38,
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: Colors.grey,
//                     width: 1,
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
//                       color: _isPlaying ? Colors.red : Colors.white,
//                       onPressed: () {
//                         if (_isPlaying) {
//                           _stopMovingMarkers();
//                         } else {
//                           _startMovingMarkers();
//                         }
//                       },
//                     ),
//                     if (_isPlaying)
//                       IconButton(
//                         icon: Icon(Icons.pause),
//                         color: Colors.white,
//                         onPressed: () {
//                           // _pauseMovingMarkers();
//                         },
//                       ),
//                   ],
//                 ),
//               ),
//             ),

//           // Positioned(
//           //   bottom: 20,
//           //   right: 20,
//           //   child: FloatingActionButton(
//           //     onPressed:
//           //         _isPlaying ? _stopMovingMarkers : _startMovingMarkers,
//           //     child: Icon(
//           //       _isPlaying ? Icons.stop : Icons.play_arrow,
//           //       color: Colors.white,
//           //     ),
//           //     backgroundColor: _isPlaying ? Colors.red : Colors.blueAccent,
//           //   ),
//           // ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.directions_boat),
//             label: 'Vessel',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.location_searching),
//             label: 'Tracking',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.timer),
//             label: 'Airtime',
//           ),
//         ],
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         onTap: (index) async {
//           if (index == 1) {
//             await showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               builder: (context) {
//                 double keyboardHeight =
//                     MediaQuery.of(context).viewInsets.bottom;
//                 double paddingBottom =
//                     keyboardHeight > 0 ? keyboardHeight + 10 : 10;

//                 return Padding(
//                   padding: EdgeInsets.only(bottom: paddingBottom),
//                   child: TrakingDataModal(
//                     mobileId: widget.mobileId ?? '',
//                     onTrackVessel: _onTrackVessel,
//                     onClearHistory: () {
//                       setState(() {
//                         _polylinePointsTraking.clear();
//                         _markersTraking.clear();
//                       });
//                     },
//                   ),
//                 );
//               },
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width,
//                 maxHeight: MediaQuery.of(context).size.height / 2,
//               ),
//             );
//           } else {
//             await showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               builder: (context) {
//                 return index == 0
//                     ? VesselDataModal(kapalMember: kapalMember!)
//                     : AirtimeDataModal(
//                         future:
//                             kapalMemberService.getAirtimeKapal(widget.idFull),
//                       );
//               },
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width,
//                 maxHeight: MediaQuery.of(context).size.height / 3,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: AppColors.scaffoldWithBoxBackground,
//     appBar: AppBar(
//       title: Text(Localization.getTrackKapalKu(_selectedLanguage) +
//           ' (${widget.idFull})'),
//       titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//             color: Colors.black,
//           ),
//       leading: const AppBackButton(),
//     ),
//     body: Stack(
//       children: [
//         FlutterMap(
//           mapController: mapController,
//           options: MapOptions(
//             initialCenter:
//                 LatLng(double.parse(widget.lat!), double.parse(widget.lon!)),
//             initialZoom: 8,
//             interactiveFlags: InteractiveFlag.pinchZoom |
//                 InteractiveFlag.drag |
//                 InteractiveFlag.doubleTapZoom,
//           ),
//           children: [
//             TileLayer(
//               urlTemplate: MapConfig.getUrlTemplate(_selectedMapProvider),
//               userAgentPackageName: 'com.example.app',
//             ),
//             MarkerLayer(markers: [
//               Marker(
//                 point: LatLng(
//                     double.parse(widget.lat!), double.parse(widget.lon!)),
//                 width: 30,
//                 height: 30,
//                 child: MarkerImageWidget(
//                     timestamp: widget.timestamp, heading: widget.heading),
//               ),
//             ]),
//             PolylineLayer(
//               polylines: [
//                 Polyline(
//                   points: _polylinePointsTraking,
//                   color: Colors.blue,
//                   strokeWidth: 2,
//                 ),
//               ],
//             ),
//             MarkerLayer(
//               markers: _markersTraking,
//             ),
//           ],
//         ),
//         MapTool(
//           mapController: mapController,
//           selectedMapProvider: _selectedMapProvider,
//           onMapProviderChanged: (value) {
//             setState(() {
//               _selectedMapProvider = value;
//             });
//           },
//         ),
//         Positioned(
//           bottom: 16,
//           right: 16,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (_polylinePointsTraking.isNotEmpty)
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.black38,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: IconButton(
//                     icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
//                     color: _isPlaying ? Colors.red : Colors.white,
//                     onPressed: () {
//                       if (_isPlaying) {
//                         _stopMovingMarkers();
//                       } else {
//                         _startMovingMarkers();
//                       }
//                     },
//                   ),
//                 ),
//               if (_isPlaying) SizedBox(height: 2),
//               if (_isPlaying)
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.black38,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: IconButton(
//                     icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
//                     color: _isPaused ? Colors.white : Colors.blue,
//                     onPressed: () {
//                       if (_isPaused) {
//                         _startMovingMarkers();
//                       } else {
//                         _pauseMovingMarkers();
//                       }
//                     },
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     ),
//     bottomNavigationBar: BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.directions_boat),
//           label: 'Vessel',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.location_searching),
//           label: 'Tracking',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.timer),
//           label: 'Airtime',
//         ),
//       ],
//       selectedItemColor: Colors.black,
//       unselectedItemColor: Colors.black,
//       onTap: (index) async {
//         if (index == 1) {
//           await showModalBottomSheet(
//             context: context,
//             isScrollControlled: true,
//             builder: (context) {
//               double keyboardHeight =
//                   MediaQuery.of(context).viewInsets.bottom;
//               double paddingBottom =
//                   keyboardHeight > 0 ? keyboardHeight + 10 : 10;
//               return Padding(
//                 padding: EdgeInsets.only(bottom: paddingBottom),
//                 child: TrakingDataModal(
//                   mobileId: widget.mobileId ?? '',
//                   onTrackVessel: _onTrackVessel,
//                   onClearHistory: () {
//                     setState(() {
//                       _polylinePointsTraking.clear();
//                       _markersTraking.clear();
//                     });
//                   },
//                 ),
//               );
//             },
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.of(context).size.width,
//               maxHeight: MediaQuery.of(context).size.height / 2,
//             ),
//           );
//         } else {
//           if (index == 0) {
//             await _fetchAndShowVesselData();
//           } else {
//             await showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               builder: (context) {
//                 return AirtimeDataModal(
//                   future: vesselService.getAirtimeKapal(widget.idFull),
//                 );
//               },
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width,
//                 maxHeight: MediaQuery.of(context).size.height / 3,
//               ),
//             );
//           }
//         }
//       },
//     ),
//   );
// }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }

class _ProfileTrackingOnePageState extends State<ProfileTrackingOnePage> {
  final VesselService vesselService = VesselService();
  final MapController mapController = MapController();
  String _selectedLanguage = 'English';
  List<LatLng> _polylinePointsTraking = [];
  List<Marker> _markersTraking = [];
  List<double> _headingsTraking = [];
  List<Marker> _initialMarkers = [];
  Timer? _timer;
  int _currentIndex = 0;
  bool _showAirtimeModal = false;
  bool _showVesselModal = false;
  bool _showTrackingModal = false;

  bool _showWeatherModal = false;
  bool _showMileageModal = false;

  bool _isPlaying = false;
  bool _isPaused = false;
  String _selectedMapProvider = 'OpenStreetMap';
  Map<String, dynamic>? _vesselData;

  @override
  void initState() {
    super.initState();
    _loadLanguageFromSharedPreferences();
    _showVesselModal = true;
    _fetchAndShowVesselData();
  }

  _loadLanguageFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('language');
    if (language != null) {
      setState(() {
        _selectedLanguage = language;
      });
    }
  }

  void _onTrackVessel(List<LatLng> polylinePoints, List<Marker> markers,
      List<double> headings) {
    setState(() {
      _polylinePointsTraking = polylinePoints;
      _markersTraking = markers;
      _headingsTraking = headings;
      _initialMarkers = List.from(markers);
    });
  }

  void _startMovingMarkers() {
    _timer?.cancel();
    if (_isPaused) {
      _isPaused = false;
    } else {
      _currentIndex = _polylinePointsTraking.length - 1;
    }

    if (_polylinePointsTraking.isNotEmpty) {
      LatLng initialPosition = _polylinePointsTraking[_currentIndex];
      mapController.move(initialPosition, 10.0);

      List<Marker> initialMarkers = [];
      for (var i = 0; i < _polylinePointsTraking.length; i++) {
        if (i == _currentIndex) {
          initialMarkers.add(
            Marker(
              point: _polylinePointsTraking[i],
              width: 30,
              height: 30,
              child: MarkerImageWidget(
                timestamp: widget.timestamp,
                heading: _headingsTraking[i].toString(),
              ),
            ),
          );
        } else {
          initialMarkers.add(_markersTraking[i]);
        }
      }
      _markersTraking = initialMarkers;
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_polylinePointsTraking.isEmpty || _markersTraking.isEmpty) return;
      setState(() {
        _currentIndex = (_currentIndex - 1) % _polylinePointsTraking.length;
        if (_currentIndex < 0) {
          _currentIndex = _polylinePointsTraking.length - 1;
        }
        LatLng currentPosition = _polylinePointsTraking[_currentIndex];
        List<Marker> updatedMarkers = [];
        for (var i = 0; i < _markersTraking.length; i++) {
          if (i == _currentIndex) {
            updatedMarkers.add(
              Marker(
                point: _polylinePointsTraking[i],
                width: 30,
                height: 30,
                child: MarkerImageWidget(
                  timestamp: widget.timestamp,
                  heading: _headingsTraking[i].toString(),
                ),
              ),
            );
          } else {
            updatedMarkers.add(_markersTraking[i]);
          }
        }
        _markersTraking = updatedMarkers;
        mapController.move(currentPosition, 10.0);
      });
    });

    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseMovingMarkers() {
    _timer?.cancel();
    setState(() {
      _isPaused = true;
      _isPlaying = true;
    });
  }

  void _stopMovingMarkers() {
    _timer?.cancel();
    setState(() {
      _isPlaying = false;
      _isPaused = false;
      _markersTraking = List.from(_initialMarkers);
    });
  }

  Future<void> _fetchAndShowVesselData() async {
    final vesselDataList = await vesselService.getDataKapal();
    final vesselData = vesselDataList!
        .firstWhere((data) => data['mobile_id'] == widget.mobileId);

    setState(() {
      _vesselData = vesselData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
            Localization.getKapalKu(_selectedLanguage) + ' (${widget.idFull})'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                        double.parse(widget.lat!), double.parse(widget.lon!)),
                    initialZoom: 12,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.pinchZoom |
                          InteractiveFlag.drag |
                          InteractiveFlag.doubleTapZoom,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          MapConfig.getUrlTemplate(_selectedMapProvider),
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(markers: [
                      Marker(
                        point: LatLng(double.parse(widget.lat!),
                            double.parse(widget.lon!)),
                        width: 30,
                        height: 30,
                        child: MarkerImageWidget(
                            timestamp: widget.timestamp,
                            heading: widget.heading),
                      ),
                    ]),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: _polylinePointsTraking,
                          color: Colors.blue,
                          strokeWidth: 2,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: _markersTraking,
                    ),
                  ],
                ),
                MapTool(
                  mapController: mapController,
                  selectedMapProvider: _selectedMapProvider,
                  onMapProviderChanged: (value) {
                    setState(() {
                      _selectedMapProvider = value;
                    });
                  },
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_polylinePointsTraking.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            icon: Icon(
                                _isPlaying ? Icons.stop : Icons.play_arrow),
                            color: _isPlaying ? Colors.red : Colors.white,
                            onPressed: () {
                              if (_isPlaying) {
                                _stopMovingMarkers();
                              } else {
                                _startMovingMarkers();
                              }
                            },
                          ),
                        ),
                      if (_isPlaying) SizedBox(height: 2),
                      if (_isPlaying)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            icon: Icon(
                                _isPaused ? Icons.play_arrow : Icons.pause),
                            color: _isPaused ? Colors.white : Colors.blue,
                            onPressed: () {
                              if (_isPaused) {
                                _startMovingMarkers();
                              } else {
                                _pauseMovingMarkers();
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child: Container(
                //     height: MediaQuery.of(context).size.height / 3,
                //     padding:
                //         const EdgeInsets.only(top: 20, left: 20, right: 20),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: const BorderRadius.only(
                //         topLeft: Radius.circular(40),
                //         topRight: Radius.circular(40),
                //       ),
                //     ),
                //     child: SingleChildScrollView(
                //       child: Column(
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               Spacer(),
                //               ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                   padding: const EdgeInsets.all(15 * 1.2),
                //                   backgroundColor: Colors.redAccent,
                //                 ),
                //                 onPressed: () {
                //                   setState(() {
                //                     _showVesselModal = !_showVesselModal;
                //                     _showAirtimeModal = false;
                //                     _showTrackingModal = false;
                //                   });
                //                   _fetchAndShowVesselData();
                //                 },
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     Text(
                //                       'Vessel',
                //                       style: TextStyle(
                //                         color: _showVesselModal
                //                             ? Colors.black
                //                             : Colors.white,
                //                       ),
                //                     ),
                //                     SizedBox(width: 4),
                //                     Icon(
                //                       Icons.directions_boat,
                //                       color: _showVesselModal
                //                           ? Colors.black
                //                           : Colors.white,
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               SizedBox(width: 5),
                //               ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                   padding: const EdgeInsets.all(15 * 1.2),
                //                   backgroundColor: Colors.orangeAccent,
                //                 ),
                //                 onPressed: () {
                //                   setState(() {
                //                     _showTrackingModal = !_showTrackingModal;
                //                     _showVesselModal = false;
                //                     _showAirtimeModal = false;
                //                   });
                //                 },
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     Text(
                //                       'Tracking',
                //                       style: TextStyle(
                //                         color: _showTrackingModal
                //                             ? Colors.black
                //                             : Colors.white,
                //                       ),
                //                     ),
                //                     SizedBox(width: 4),
                //                     Icon(
                //                       Icons.location_searching,
                //                       color: _showTrackingModal
                //                           ? Colors.black
                //                           : Colors.white,
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               SizedBox(width: 5),
                //               ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                   padding: const EdgeInsets.all(15 * 1.2),
                //                   backgroundColor: Colors.blueAccent,
                //                 ),
                //                 onPressed: () {
                //                   setState(() {
                //                     _showAirtimeModal = !_showAirtimeModal;
                //                     _showTrackingModal = false;
                //                     _showVesselModal = false;
                //                   });
                //                 },
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     Text(
                //                       'Airtime',
                //                       style: TextStyle(
                //                         color: _showAirtimeModal
                //                             ? Colors.black
                //                             : Colors.white,
                //                       ),
                //                     ),
                //                     SizedBox(width: 4),
                //                     Icon(
                //                       Icons.timer,
                //                       color: _showAirtimeModal
                //                           ? Colors.black
                //                           : Colors.white,
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               Spacer(),
                //             ],
                //           ),
                //           Divider(thickness: 1, color: Colors.black54),
                //           if (_showVesselModal)
                //             VesselDataModal(
                //               vesselData: _vesselData,
                //             ),
                //           if (_showTrackingModal)
                //             TrakingDataModal(
                //               mobileId: widget.mobileId ?? '',
                //               onTrackVessel: _onTrackVessel,
                //               onClearHistory: () {
                //                 setState(() {
                //                   _polylinePointsTraking.clear();
                //                   _markersTraking.clear();
                //                 });
                //               },
                //             ),
                //           if (_showAirtimeModal)
                //             AirtimeDataModal(
                //               future:
                //                   vesselService.getAirtimeKapal(widget.idFull),
                //             ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection:
                              Axis.horizontal, // Scroll hanya pada tombol
                          child: Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15 * 1.2),
                                  backgroundColor: Colors.redAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showVesselModal = !_showVesselModal;
                                    _showAirtimeModal = false;
                                    _showTrackingModal = false;
                                    _showWeatherModal = false;
                                    _showMileageModal = false;
                                  });
                                  _fetchAndShowVesselData();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Vessel',
                                      style: TextStyle(
                                        color: _showVesselModal
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.directions_boat,
                                      color: _showVesselModal
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15 * 1.2),
                                  backgroundColor: Colors.orangeAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showTrackingModal = !_showTrackingModal;
                                    _showVesselModal = false;
                                    _showAirtimeModal = false;
                                    _showWeatherModal = false;
                                    _showMileageModal = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Tracking',
                                      style: TextStyle(
                                        color: _showTrackingModal
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.location_searching,
                                      color: _showTrackingModal
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15 * 1.2),
                                  backgroundColor: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showAirtimeModal = !_showAirtimeModal;
                                    _showTrackingModal = false;
                                    _showVesselModal = false;
                                    _showWeatherModal = false;
                                    _showMileageModal = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Airtime',
                                      style: TextStyle(
                                        color: _showAirtimeModal
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.timer,
                                      color: _showAirtimeModal
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15 * 1.2),
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showWeatherModal = !_showWeatherModal;
                                    _showAirtimeModal = false;
                                    _showTrackingModal = false;
                                    _showVesselModal = false;
                                    _showMileageModal = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Weather',
                                      style: TextStyle(
                                        color: _showWeatherModal
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.cloud,
                                      color: _showWeatherModal
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15 * 1.2),
                                  backgroundColor: Colors.pink,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showMileageModal = !_showMileageModal;
                                    _showAirtimeModal = false;
                                    _showTrackingModal = false;
                                    _showVesselModal = false;
                                    _showWeatherModal = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Mileage',
                                      style: TextStyle(
                                        color: _showMileageModal
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.track_changes,
                                      color: _showMileageModal
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.black54),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if (_showVesselModal)
                                  VesselDataModal(
                                    vesselData: _vesselData,
                                  ),
                                if (_showTrackingModal)
                                  TrakingDataModal(
                                    mobileId: widget.mobileId ?? '',
                                    onTrackVessel: _onTrackVessel,
                                    onClearHistory: () {
                                      setState(() {
                                        _polylinePointsTraking.clear();
                                        _markersTraking.clear();
                                      });
                                    },
                                  ),
                                if (_showAirtimeModal)
                                  AirtimeDataModal(
                                    future: vesselService
                                        .getAirtimeKapal(widget.idFull),
                                  ),
                                if (_showWeatherModal)
                                  WeatherDataModal(
                                    vesselData: _vesselData,
                                  ),
                                if (_showMileageModal)
                                  MileageDataModal(
                                    mobileId: widget.mobileId ?? '',
                                    namaKapal: _vesselData!['nama_kapal'],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
