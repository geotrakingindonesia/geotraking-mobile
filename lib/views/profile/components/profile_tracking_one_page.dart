// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, sort_child_properties_last, deprecated_member_use
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:geotraking/core/components/marker_image_widget.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/views/profile/components/modal/airtime/airtime_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/mileage/mileage_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/traking/components/vessel_playback.dart';
import 'package:geotraking/views/profile/components/modal/weather/weather_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/traking/traking_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/vessel/vessel_data_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong2/latlong.dart';

import 'dart:math';
import 'dart:typed_data';
// import 'package:vector_math/vector_math.dart';

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

class _ProfileTrackingOnePageState extends State<ProfileTrackingOnePage>
    with SingleTickerProviderStateMixin {
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

  bool isPlaybackActive = false; // Track whether playback is active

  // Animation<double>? _animation;

  late AnimationController _controller;
  late Animation<double> _animation;

  final _mapMarkerSC = StreamController<List<Marker>>();
  late StreamSink<List<Marker>> _mapMarkerSink;
  Stream<List<Marker>> get mapMarkerStream => _mapMarkerSC.stream;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _loadLanguageFromSharedPreferences();
    _showVesselModal = true;
    _fetchAndShowVesselData();

    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // _mapMarkerSink = _mapMarkerSC.sink;
    // _loadLanguageFromSharedPreferences();
    // _fetchAndShowVesselData();

    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 1000),
    // );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
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
    // _mapMarkerSink.add(markers);
  }

  // void _startMovingMarkers() {
  //   if (_polylinePointsTraking.isEmpty) return;

  //   setState(() {
  //     _isPlaying = true;
  //     _isPaused = false;
  //   });

  //   _currentIndex = 0;
  //   moveToNextPoint();
  // }

  // void moveToNextPoint() {
  //   if (_currentIndex >= _polylinePointsTraking.length - 1) {
  //     _isPlaying = false;
  //     return;
  //   }

  //   final startPoint = _polylinePointsTraking[_currentIndex];
  //   final endPoint = _polylinePointsTraking[_currentIndex + 1];

  //   _animationController.duration = Duration(
  //     milliseconds: (calculateDistance(startPoint, endPoint) * 100).toInt(),
  //   );

  //   final tween = Tween<double>(begin: 0, end: 1).animate(_animationController);

  //   tween.addListener(() {
  //     // Update the marker position using the tween value
  //     updateMarkerPosition(tween.value, startPoint, endPoint);
  //   });

  //   // final tween = Tween<double>(begin: 0, end: 1).animate(_animationController)
  //   //   ..addListener(() {
  //   //     updateMarkerPosition(tween, startPoint, endPoint);
  //   //   });

  //   _animationController.forward(from: 0).whenComplete(() {
  //     _currentIndex++;
  //     moveToNextPoint();
  //   });
  // }

  // void updateMarkerPosition(double value, LatLng startPoint, LatLng endPoint) {
  //   final lat =
  //       startPoint.latitude + (endPoint.latitude - startPoint.latitude) * value;
  //   final lng = startPoint.longitude +
  //       (endPoint.longitude - startPoint.longitude) * value;
  //   final newPos = LatLng(lat, lng);

  //   final marker = Marker(
  //     point: newPos,
  //     width: 30,
  //     height: 30,
  //     child: Transform.rotate(
  //       angle: getBearing(startPoint, endPoint) * pi / 180,
  //       child: MarkerImageWidget(
  //           timestamp: widget.timestamp, heading: widget.heading),
  //     ),
  //   );

  //   _mapMarkerSink.add([marker]);
  //   mapController.move(newPos, mapController.camera.zoom);
  // }

  // double calculateDistance(LatLng start, LatLng end) {
  //   const Distance distance = Distance();
  //   return distance.as(LengthUnit.Kilometer, start, end);
  // }

  // double getBearing(LatLng start, LatLng end) {
  //   final lat = (start.latitude - end.latitude).abs();
  //   final lng = (start.longitude - end.longitude).abs();

  //   if (start.latitude < end.latitude && start.longitude < end.longitude) {
  //     return degrees(atan(lng / lat));
  //   } else if (start.latitude >= end.latitude &&
  //       start.longitude < end.longitude) {
  //     return (90 - degrees(atan(lng / lat))) + 90;
  //   } else if (start.latitude >= end.latitude &&
  //       start.longitude >= end.longitude) {
  //     return degrees(atan(lng / lat)) + 180;
  //   } else if (start.latitude < end.latitude &&
  //       start.longitude >= end.longitude) {
  //     return (90 - degrees(atan(lng / lat))) + 270;
  //   }
  //   return -1;
  // }

  // double degrees(double radians) {
  //   return radians * (180 / pi);
  // }

  // void stopAnimation() {
  //   _animationController.stop(); // Stop the animation
  //   // marker.clear(); // Optionally clear markers or reset positions
  //   setState(() {}); // Call setState to refresh UI
  // }

  // void _startMovingMarkers() {
  //   if (_polylinePointsTraking.isEmpty) return;

  //   setState(() {
  //     _isPlaying = true;
  //     _isPaused = false;
  //   });

  //   _currentIndex = 0;
  //   moveToNextPoint();
  // }

  // void _pauseMovingMarkers() {
  //   setState(() {
  //     _isPaused = true;
  //     _isPlaying = false;
  //   });
  //   _animationController.stop();
  // }

  // void _stopMovingMarkers() {
  //   setState(() {
  //     _isPlaying = false;
  //     _isPaused = false;
  //   });
  //   _animationController.stop();
  //   _currentIndex = 0;
  //   _markersTraking.clear();
  // }

  // void moveToNextPoint() {
  //   if (_currentIndex >= _polylinePointsTraking.length - 1) {
  //     _stopMovingMarkers();
  //     return;
  //   }

  //   final startPoint = _polylinePointsTraking[_currentIndex];
  //   final endPoint = _polylinePointsTraking[_currentIndex + 1];

  //   // Set duration based on distance
  //   _animationController.duration = Duration(
  //     milliseconds: (calculateDistance(startPoint, endPoint) * 100).toInt(),
  //   );

  //   _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
  //     ..addStatusListener((status) {
  //       if (status == AnimationStatus.completed && !_isPaused) {
  //         _currentIndex++;
  //         moveToNextPoint();
  //       }
  //     });

  //   _animationController.forward(from: 0);
  // }

  // void updateMarkerPosition(double value) {
  //   if (_currentIndex >= _polylinePointsTraking.length - 1) return;

  //   final startPoint = _polylinePointsTraking[_currentIndex];
  //   final endPoint = _polylinePointsTraking[_currentIndex + 1];

  //   final lat =
  //       startPoint.latitude + (endPoint.latitude - startPoint.latitude) * value;
  //   final lng = startPoint.longitude +
  //       (endPoint.longitude - startPoint.longitude) * value;
  //   final newPos = LatLng(lat, lng);

  //   setState(() {
  //     _markersTraking = [
  //       Marker(
  //         point: newPos,
  //         width: 30,
  //         height: 30,
  //         child: Transform.rotate(
  //           angle: getBearing(startPoint, endPoint) * pi / 180,
  //           child: Image.asset(
  //             'assets/images/kapal-hijau.png',
  //             width: 50,
  //             height: 50,
  //           ),
  //         ),
  //       ),
  //     ];
  //   });

  //   mapController.move(newPos, mapController.camera.zoom);
  // }

  // double calculateDistance(LatLng start, LatLng end) {
  //   const Distance distance = Distance();
  //   return distance.as(LengthUnit.Kilometer, start, end);
  // }

  // double getBearing(LatLng start, LatLng end) {
  //   final lat = (start.latitude - end.latitude).abs();
  //   final lng = (start.longitude - end.longitude).abs();

  //   if (start.latitude < end.latitude && start.longitude < end.longitude) {
  //     return degrees(math.atan(lng / lat));
  //   } else if (start.latitude >= end.latitude &&
  //       start.longitude < end.longitude) {
  //     return (90 - degrees(math.atan(lng / lat))) + 90;
  //   } else if (start.latitude >= end.latitude &&
  //       start.longitude >= end.longitude) {
  //     return degrees(math.atan(lng / lat)) + 180;
  //   } else if (start.latitude < end.latitude &&
  //       start.longitude >= end.longitude) {
  //     return (90 - degrees(math.atan(lng / lat))) + 270;
  //   }
  //   return -1;
  // }

  // void _startMovingMarkers() {
  //   _timer?.cancel();
  //   if (_isPaused) {
  //     _isPaused = false;
  //   } else {
  //     _currentIndex = _polylinePointsTraking.length - 1;
  //   }

  //   if (_polylinePointsTraking.isNotEmpty) {
  //     LatLng initialPosition = _polylinePointsTraking[_currentIndex];
  //     mapController.move(initialPosition, 10.0);

  //     List<Marker> initialMarkers = [];
  //     for (var i = 0; i < _polylinePointsTraking.length; i++) {
  //       if (i == _currentIndex) {
  //         initialMarkers.add(
  //           Marker(
  //             point: _polylinePointsTraking[i],
  //             width: 30,
  //             height: 30,
  //             child: MarkerImageWidget(
  //               timestamp: widget.timestamp,
  //               heading: _headingsTraking[i].toString(),
  //             ),
  //           ),
  //         );
  //       } else {
  //         initialMarkers.add(_markersTraking[i]);
  //       }
  //     }
  //     _markersTraking = initialMarkers;
  //   }

  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (_polylinePointsTraking.isEmpty || _markersTraking.isEmpty) return;
  //     setState(() {
  //       _currentIndex = (_currentIndex - 1) % _polylinePointsTraking.length;
  //       if (_currentIndex < 0) {
  //         _currentIndex = _polylinePointsTraking.length - 1;
  //       }
  //       LatLng currentPosition = _polylinePointsTraking[_currentIndex];
  //       List<Marker> updatedMarkers = [];
  //       for (var i = 0; i < _markersTraking.length; i++) {
  //         if (i == _currentIndex) {
  //           updatedMarkers.add(
  //             Marker(
  //               point: _polylinePointsTraking[i],
  //               width: 30,
  //               height: 30,
  //               child: MarkerImageWidget(
  //                 timestamp: widget.timestamp,
  //                 heading: _headingsTraking[i].toString(),
  //               ),
  //             ),
  //           );
  //         } else {
  //           updatedMarkers.add(_markersTraking[i]);
  //         }
  //       }
  //       _markersTraking = updatedMarkers;
  //       mapController.move(currentPosition, 10.0);
  //     });
  //   });

  //   setState(() {
  //     _isPlaying = true;
  //   });
  // }

  // void _pauseMovingMarkers() {
  //   _timer?.cancel();
  //   setState(() {
  //     _isPaused = true;
  //     _isPlaying = true;
  //   });
  // }

  // void _stopMovingMarkers() {
  //   _timer?.cancel();
  //   setState(() {
  //     _isPlaying = false;
  //     _isPaused = false;
  //     _markersTraking = List.from(_initialMarkers);
  //   });
  // }

  // void _startMovingMarkers() {
  //   if (_polylinePointsTraking.isEmpty)
  //     return; // Prevents processing if the list is empty
  //   if (_isPaused) {
  //     _isPaused = false;
  //   } else {
  //     _currentIndex = 0; // Start from the first point
  //   }

  //   // Move to the first point
  //   LatLng initialPosition = _polylinePointsTraking[_currentIndex];
  //   mapController.move(initialPosition, 10.0);
  //   _moveMarker(initialPosition);

  //   setState(() {
  //     _isPlaying = true;
  //   });
  // }

  // void _moveMarker(LatLng initialPosition) {
  //   if (_currentIndex + 1 >= _polylinePointsTraking.length) {
  //     _stopMovingMarkers(); // Stop if we've reached the end
  //     return;
  //   }

  //   LatLng targetPosition =
  //       _polylinePointsTraking[_currentIndex + 1]; // Next point
  //   _controller.forward().whenComplete(() {
  //     // Ensure index is valid before moving to the next point
  //     if (_currentIndex < _polylinePointsTraking.length - 1) {
  //       setState(() {
  //         _currentIndex++;
  //       });
  //       _moveMarker(
  //           targetPosition); // Recursively call to move to the next point
  //     } else {
  //       _stopMovingMarkers(); // Stop when reaching the end
  //     }
  //   });

  //   _animation.addListener(() {
  //     double t = _animation.value;
  //     LatLng newPosition = LatLng(
  //         lerpDouble(initialPosition.latitude, targetPosition.latitude, t)!,
  //         lerpDouble(initialPosition.longitude, targetPosition.longitude, t)!);

  //     setState(() {
  //       _markersTraking[_currentIndex] = Marker(
  //         point: newPosition,
  //         width: 30,
  //         height: 30,
  //         child: MarkerImageWidget(
  //           timestamp: widget.timestamp,
  //           heading: widget.heading, // Use current heading if applicable
  //         ),
  //       );

  //       mapController.move(newPosition, 10.0);
  //     });
  //   });

  //   _controller.forward().whenComplete(() {
  //     _controller.reset(); // Reset for the next movement
  //   });
  // }

  // void _pauseMovingMarkers() {
  //   _controller.stop();
  //   setState(() {
  //     _isPaused = true;
  //     _isPlaying = true;
  //   });
  // }

  // void _stopMovingMarkers() {
  //   _controller.stop();
  //   setState(() {
  //     _isPlaying = false;
  //     _isPaused = false;
  //     _markersTraking =
  //         List.from(_initialMarkers); // Reset to initial markers if necessary
  //     _currentIndex = 0; // Reset the index to prevent further access
  //   });
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  void _startPlayback() {
    setState(() {
      isPlaybackActive = true; // Set playback active
    });
  }

  void _stopPlayback() {
    setState(() {
      isPlaybackActive = false; // Set playback inactive
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
                isPlaybackActive
                    ? VesselPlayback(
                        polylinePoints: _polylinePointsTraking,
                        markers: _markersTraking,
                        // initialLat:
                        //     double.parse(widget.lat!), // Starting latitude
                        // initialLon:
                        //     double.parse(widget.lon!), // Starting longitude
                      )
                    : FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: LatLng(double.parse(widget.lat!),
                              double.parse(widget.lon!)),
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
                              isPlaybackActive ? Icons.stop : Icons.play_arrow,
                              // isPlaybackActive ? Icons.stop : Icons.play_arrow,
                              color:
                                  isPlaybackActive ? Colors.red : Colors.white,
                            ),
                            tooltip: isPlaybackActive
                                ? 'Stop Playback'
                                : 'Start Playback',
                            onPressed: isPlaybackActive
                                ? _stopPlayback
                                : _startPlayback,
                          ),
                        ),
                      // FloatingActionButton(
                      //   onPressed:
                      //       isPlaybackActive ? _stopPlayback : _startPlayback,
                      //   child: Icon(
                      //       isPlaybackActive ? Icons.stop : Icons.play_arrow),
                      //   tooltip: isPlaybackActive
                      //       ? 'Stop Playback'
                      //       : 'Start Playback',
                      // ),

                      // FloatingActionButton(
                      //   onPressed: isPlaybackActive ? null : _startPlayback,
                      //   child: Icon(Icons.play_arrow),
                      //   tooltip: 'Start Playback',
                      // ),
                      // SizedBox(width: 10),
                      // if (_polylinePointsTraking.isNotEmpty)
                      //   FloatingActionButton(
                      //     onPressed: isPlaybackActive ? _stopPlayback : null,
                      //     child: Icon(Icons.stop),
                      //     tooltip: 'Stop Playback',
                      //   ),

                      // if (_polylinePointsTraking.isNotEmpty)
                      //   Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.black38,
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     child: IconButton(
                      //       icon: Icon(
                      //         isPlaybackActive ? Icons.stop : Icons.play_arrow,
                      //         // isPlaybackActive ? Icons.stop : Icons.play_arrow,
                      //         color:
                      //             isPlaybackActive ? Colors.red : Colors.white,
                      //       ),
                      //       tooltip: isPlaybackActive
                      //           ? 'Stop Playback'
                      //           : 'Start Playback',
                      //       onPressed: () {
                      //         isPlaybackActive ? _stopPlayback : _startPlayback;

                      //         // if (isPlaybackActive) {
                      //         //   _stopPlayback();
                      //         // } else {
                      //         //   _startPlayback();
                      //         // }
                      //         // setState(() {
                      //         // isPlaybackActive = !isPlaybackActive;
                      //         // });
                      //       },
                      //     ),
                      //   ),

                      // // if (_isPlaying) SizedBox(height: 2),
                      // // if (_isPlaying)
                      // //   Container(
                      // //     decoration: BoxDecoration(
                      // //       color: Colors.black38,
                      // //       borderRadius: BorderRadius.circular(5),
                      // //     ),
                      // //     child: IconButton(
                      // //       icon: Icon(
                      // //           _isPaused ? Icons.play_arrow : Icons.pause),
                      // //       color: _isPaused ? Colors.white : Colors.blue,
                      // //       // onPressed: () {
                      // //       //   if (_isPaused) {
                      // //       //     // _startMovingMarkers();
                      // //       //   } else {
                      // //       //     // _pauseMovingMarkers();
                      // //       //   }
                      // //       // },
                      // //       // onPressed: isPlaybackActive ? _stopPlayback : null,
                      // //     ),
                      // //   ),
                    ],
                  ),
                ),
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
                                  padding: const EdgeInsets.all(15 * 0.8),
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
                                  padding: const EdgeInsets.all(15 * 0.8),
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
                                  padding: const EdgeInsets.all(15 * 0.8),
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
                                  padding: const EdgeInsets.all(15 * 0.8),
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
                                  padding: const EdgeInsets.all(15 * 0.8),
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
}
