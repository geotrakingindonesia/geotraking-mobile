// // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // import 'package:flutter_map/flutter_map.dart';
// // // // // // // // // import 'package:latlong2/latlong.dart';

// // // // // // // // // class VesselPlayback extends StatefulWidget {
// // // // // // // // //   final List<LatLng> polylinePoints; // Your polyline points
// // // // // // // // //   final List<Marker> markers; // Your markers
// // // // // // // // //   final double initialLat; // Initial latitude for the vessel
// // // // // // // // //   final double initialLon; // Initial longitude for the vessel

// // // // // // // // //   const VesselPlayback({
// // // // // // // // //     Key? key,
// // // // // // // // //     required this.polylinePoints,
// // // // // // // // //     required this.markers,
// // // // // // // // //     required this.initialLat,
// // // // // // // // //     required this.initialLon,
// // // // // // // // //   }) : super(key: key);

// // // // // // // // //   @override
// // // // // // // // //   _VesselPlaybackState createState() => _VesselPlaybackState();
// // // // // // // // // }

// // // // // // // // // class _VesselPlaybackState extends State<VesselPlayback>
// // // // // // // // //     with SingleTickerProviderStateMixin {
// // // // // // // // //   late AnimationController _controller;
// // // // // // // // //   late Animation<double> _animation;
// // // // // // // // //   late List<LatLng> _polylinePoints; // To hold the polyline points
// // // // // // // // //   bool isPlaying = false; // Track playback state

// // // // // // // // //   @override
// // // // // // // // //   void initState() {
// // // // // // // // //     super.initState();
// // // // // // // // //     _polylinePoints = widget.polylinePoints;
// // // // // // // // //     _controller = AnimationController(
// // // // // // // // //       duration: Duration(seconds: 10), // Set your desired duration
// // // // // // // // //       vsync: this,
// // // // // // // // //     );

// // // // // // // // //     // Tween for smooth movement along the polyline
// // // // // // // // //     _animation = Tween<double>(begin: 0.0, end: _polylinePoints.length - 1)
// // // // // // // // //         .animate(CurvedAnimation(
// // // // // // // // //       parent: _controller,
// // // // // // // // //       curve: Curves.linear,
// // // // // // // // //     ));

// // // // // // // // //     // Listen for animation status changes
// // // // // // // // //     _controller.addStatusListener((status) {
// // // // // // // // //       if (status == AnimationStatus.completed) {
// // // // // // // // //         setState(() {
// // // // // // // // //           isPlaying = false; // Stop playback when completed
// // // // // // // // //         });
// // // // // // // // //       }
// // // // // // // // //     });
// // // // // // // // //   }

// // // // // // // // //   void _startPlayback() {
// // // // // // // // //     if (!isPlaying) {
// // // // // // // // //       _controller.forward(); // Start the playback
// // // // // // // // //       setState(() {
// // // // // // // // //         isPlaying = true; // Update playback state
// // // // // // // // //       });
// // // // // // // // //     }
// // // // // // // // //   }

// // // // // // // // //   void _stopPlayback() {
// // // // // // // // //     if (isPlaying) {
// // // // // // // // //       _controller.stop(); // Stop the playback
// // // // // // // // //       setState(() {
// // // // // // // // //         isPlaying = false; // Update playback state
// // // // // // // // //       });
// // // // // // // // //     }
// // // // // // // // //   }

// // // // // // // // //   @override
// // // // // // // // //   void dispose() {
// // // // // // // // //     _controller.dispose();
// // // // // // // // //     super.dispose();
// // // // // // // // //   }

// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return Scaffold(
// // // // // // // // //       body: Stack(
// // // // // // // // //         children: [
// // // // // // // // //           FlutterMap(
// // // // // // // // //             options: MapOptions(
// // // // // // // // //               initialCenter: LatLng(widget.initialLat, widget.initialLon),
// // // // // // // // //               initialZoom: 20,
// // // // // // // // //             ),
// // // // // // // // //             children: [
// // // // // // // // //               TileLayer(
// // // // // // // // //                 urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
// // // // // // // // //               ),
// // // // // // // // //               PolylineLayer(
// // // // // // // // //                 polylines: [
// // // // // // // // //                   Polyline(
// // // // // // // // //                     points: _polylinePoints,
// // // // // // // // //                     color: Colors.blue,
// // // // // // // // //                     strokeWidth: 2,
// // // // // // // // //                   ),
// // // // // // // // //                 ],
// // // // // // // // //               ),
// // // // // // // // //               MarkerLayer(
// // // // // // // // //                 markers: widget.markers,
// // // // // // // // //               ),
// // // // // // // // //               // Marker for the vessel
// // // // // // // // //               MarkerLayer(
// // // // // // // // //                 markers: [
// // // // // // // // //                   Marker(
// // // // // // // // //                     point: _getCurrentVesselPosition(),
// // // // // // // // //                     width: 30,
// // // // // // // // //                     height: 30,
// // // // // // // // //                     child: Icon(Icons.directions_boat, color: Colors.red),
// // // // // // // // //                   ),
// // // // // // // // //                 ],
// // // // // // // // //               ),
// // // // // // // // //             ],
// // // // // // // // //           ),
// // // // // // // // //           // Positioned(
// // // // // // // // //           //   bottom: 20,
// // // // // // // // //           //   right: 20,
// // // // // // // // //           //   child: Row(
// // // // // // // // //           //     mainAxisAlignment: MainAxisAlignment.end,
// // // // // // // // //           //     children: [
// // // // // // // // //           //       FloatingActionButton(
// // // // // // // // //           //         onPressed: isPlaying ? null : _startPlayback,
// // // // // // // // //           //         child: Icon(Icons.play_arrow),
// // // // // // // // //           //         tooltip: 'Start Playback',
// // // // // // // // //           //       ),
// // // // // // // // //           //       SizedBox(width: 10), // Spacing between buttons
// // // // // // // // //           //       FloatingActionButton(
// // // // // // // // //           //         onPressed: isPlaying ? _stopPlayback : null,
// // // // // // // // //           //         child: Icon(Icons.stop),
// // // // // // // // //           //         tooltip: 'Stop Playback',
// // // // // // // // //           //       ),
// // // // // // // // //           //     ],
// // // // // // // // //           //   ),
// // // // // // // // //           // ),
// // // // // // // // //         ],
// // // // // // // // //       ),
// // // // // // // // //     );
// // // // // // // // //   }

// // // // // // // // //   LatLng _getCurrentVesselPosition() {
// // // // // // // // //     int startIndex = _animation.value.toInt();
// // // // // // // // //     int endIndex = startIndex + 1;

// // // // // // // // //     if (endIndex >= _polylinePoints.length) {
// // // // // // // // //       return _polylinePoints.last; // Return the last position
// // // // // // // // //     }

// // // // // // // // //     double t = _animation.value - startIndex;
// // // // // // // // //     LatLng start = _polylinePoints[startIndex];
// // // // // // // // //     LatLng end = _polylinePoints[endIndex];

// // // // // // // // //     // Interpolate between the start and end positions
// // // // // // // // //     double lat = start.latitude + (end.latitude - start.latitude) * t;
// // // // // // // // //     double lon = start.longitude + (end.longitude - start.longitude) * t;

// // // // // // // // //     return LatLng(lat, lon);
// // // // // // // // //   }
// // // // // // // // // }

// // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // import 'package:flutter_map/flutter_map.dart';
// // // // // // // // import 'package:latlong2/latlong.dart';

// // // // // // // // class VesselPlayback extends StatefulWidget {
// // // // // // // //   final List<LatLng> polylinePoints; // Your polyline points
// // // // // // // //   final List<Marker> markers; // Your markers
// // // // // // // //   final double initialLat; // Initial latitude for the vessel
// // // // // // // //   final double initialLon; // Initial longitude for the vessel

// // // // // // // //   const VesselPlayback({
// // // // // // // //     Key? key,
// // // // // // // //     required this.polylinePoints,
// // // // // // // //     required this.markers,
// // // // // // // //     required this.initialLat,
// // // // // // // //     required this.initialLon,
// // // // // // // //   }) : super(key: key);

// // // // // // // //   @override
// // // // // // // //   _VesselPlaybackState createState() => _VesselPlaybackState();
// // // // // // // // }

// // // // // // // // class _VesselPlaybackState extends State<VesselPlayback>
// // // // // // // //     with SingleTickerProviderStateMixin {
// // // // // // // //   late AnimationController _controller;
// // // // // // // //   late Animation<double> _animation;
// // // // // // // //   late List<LatLng> _polylinePoints; // To hold the polyline points
// // // // // // // //   bool isPlaying = false; // Track playback state

// // // // // // // //   @override
// // // // // // // //   void initState() {
// // // // // // // //     super.initState();
// // // // // // // //     _polylinePoints = widget.polylinePoints;
// // // // // // // //     _controller = AnimationController(
// // // // // // // //       duration: Duration(seconds: 10), // Set your desired duration
// // // // // // // //       vsync: this,
// // // // // // // //     );

// // // // // // // //     // Tween for smooth movement along the polyline
// // // // // // // //     _animation = Tween<double>(begin: 0.0, end: _polylinePoints.length - 1)
// // // // // // // //         .animate(CurvedAnimation(
// // // // // // // //       parent: _controller,
// // // // // // // //       curve: Curves.linear,
// // // // // // // //     ));

// // // // // // // //     // Listen for animation status changes
// // // // // // // //     _controller.addStatusListener((status) {
// // // // // // // //       if (status == AnimationStatus.completed) {
// // // // // // // //         setState(() {
// // // // // // // //           isPlaying = false; // Stop playback when completed
// // // // // // // //         });
// // // // // // // //       }
// // // // // // // //     });

// // // // // // // //     // Start playback automatically when the widget is initialized
// // // // // // // //     _startPlayback();
// // // // // // // //   }

// // // // // // // //   void _startPlayback() {
// // // // // // // //     if (!isPlaying) {
// // // // // // // //       _controller.forward(); // Start the playback
// // // // // // // //       setState(() {
// // // // // // // //         isPlaying = true; // Update playback state
// // // // // // // //       });
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   void dispose() {
// // // // // // // //     _controller.dispose();
// // // // // // // //     super.dispose();
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //       body: Stack(
// // // // // // // //         children: [
// // // // // // // //           FlutterMap(
// // // // // // // //             options: MapOptions(
// // // // // // // //               initialCenter: LatLng(widget.initialLat, widget.initialLon),
// // // // // // // //               initialZoom: 20,
// // // // // // // //             ),
// // // // // // // //             children: [
// // // // // // // //               TileLayer(
// // // // // // // //                 urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
// // // // // // // //               ),
// // // // // // // //               PolylineLayer(
// // // // // // // //                 polylines: [
// // // // // // // //                   Polyline(
// // // // // // // //                     points: _polylinePoints,
// // // // // // // //                     color: Colors.blue,
// // // // // // // //                     strokeWidth: 2,
// // // // // // // //                   ),
// // // // // // // //                 ],
// // // // // // // //               ),
// // // // // // // //               MarkerLayer(
// // // // // // // //                 markers: widget.markers,
// // // // // // // //               ),
// // // // // // // //               // Marker for the vessel
// // // // // // // //               MarkerLayer(
// // // // // // // //                 markers: [
// // // // // // // //                   Marker(
// // // // // // // //                     point: _getCurrentVesselPosition(),
// // // // // // // //                     width: 30,
// // // // // // // //                     height: 30,
// // // // // // // //                     child: Icon(Icons.directions_boat, color: Colors.red),
// // // // // // // //                   ),
// // // // // // // //                 ],
// // // // // // // //               ),
// // // // // // // //             ],
// // // // // // // //           ),
// // // // // // // //         ],
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   LatLng _getCurrentVesselPosition() {
// // // // // // // //     int startIndex = _animation.value.toInt();
// // // // // // // //     int endIndex = startIndex + 1;

// // // // // // // //     if (endIndex >= _polylinePoints.length) {
// // // // // // // //       return _polylinePoints.last; // Return the last position
// // // // // // // //     }

// // // // // // // //     double t = _animation.value - startIndex;
// // // // // // // //     LatLng start = _polylinePoints[startIndex];
// // // // // // // //     LatLng end = _polylinePoints[endIndex];

// // // // // // // //     // Interpolate between the start and end positions
// // // // // // // //     double lat = start.latitude + (end.latitude - start.latitude) * t;
// // // // // // // //     double lon = start.longitude + (end.longitude - start.longitude) * t;

// // // // // // // //     return LatLng(lat, lon);
// // // // // // // //   }
// // // // // // // // }

// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:flutter_map/flutter_map.dart';
// // // // // // // import 'package:latlong2/latlong.dart';
// // // // // // // import 'dart:async';
// // // // // // // import 'dart:math';

// // // // // // // class VesselPlayback extends StatefulWidget {
// // // // // // //   final List<LatLng> polylinePoints; // Your polyline points
// // // // // // //   final List<Marker> markers; // Your markers
// // // // // // //   final double initialLat; // Initial latitude for the vessel
// // // // // // //   final double initialLon; // Initial longitude for the vessel

// // // // // // //   const VesselPlayback({
// // // // // // //     Key? key,
// // // // // // //     required this.polylinePoints,
// // // // // // //     required this.markers,
// // // // // // //     required this.initialLat,
// // // // // // //     required this.initialLon,
// // // // // // //   }) : super(key: key);

// // // // // // //   @override
// // // // // // //   _VesselPlaybackState createState() => _VesselPlaybackState();
// // // // // // // }

// // // // // // // class _VesselPlaybackState extends State<VesselPlayback>
// // // // // // //     with SingleTickerProviderStateMixin {
// // // // // // //   late AnimationController _controller;
// // // // // // //   late Animation<double> _animation;
// // // // // // //   late List<LatLng> _polylinePoints; // To hold the polyline points
// // // // // // //   bool isPlaying = false; // Track playback state
// // // // // // //   late MapController _mapController;

// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //     _polylinePoints = widget.polylinePoints;
// // // // // // //     _mapController = MapController();

// // // // // // //     _controller = AnimationController(
// // // // // // //       duration: Duration(seconds: 10), // Set your desired duration
// // // // // // //       vsync: this,
// // // // // // //     );

// // // // // // //     // Tween for smooth movement along the polyline
// // // // // // //     _animation = Tween<double>(begin: 0.0, end: _polylinePoints.length - 1)
// // // // // // //         .animate(CurvedAnimation(
// // // // // // //       parent: _controller,
// // // // // // //       curve: Curves.linear,
// // // // // // //     ));

// // // // // // //     // Listen for animation status changes
// // // // // // //     _controller.addStatusListener((status) {
// // // // // // //       if (status == AnimationStatus.completed) {
// // // // // // //         setState(() {
// // // // // // //           isPlaying = false; // Stop playback when completed
// // // // // // //         });
// // // // // // //       }
// // // // // // //     });

// // // // // // //     // Start playback automatically when the widget is initialized
// // // // // // //     _startPlayback();
// // // // // // //   }

// // // // // // //   void _startPlayback() {
// // // // // // //     if (!isPlaying) {
// // // // // // //       _controller.forward(); // Start the playback
// // // // // // //       setState(() {
// // // // // // //         isPlaying = true; // Update playback state
// // // // // // //       });
// // // // // // //     }
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   void dispose() {
// // // // // // //     _controller.dispose();
// // // // // // //     super.dispose();
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       body: Stack(
// // // // // // //         children: [
// // // // // // //           FlutterMap(
// // // // // // //             mapController: _mapController,
// // // // // // //             options: MapOptions(
// // // // // // //               initialCenter: LatLng(widget.initialLat, widget.initialLon),
// // // // // // //               initialZoom: 14,
// // // // // // //             ),
// // // // // // //             children: [
// // // // // // //               TileLayer(
// // // // // // //                 urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
// // // // // // //               ),
// // // // // // //               PolylineLayer(
// // // // // // //                 polylines: [
// // // // // // //                   Polyline(
// // // // // // //                     points: _polylinePoints,
// // // // // // //                     color: Colors.blue,
// // // // // // //                     strokeWidth: 2,
// // // // // // //                   ),
// // // // // // //                 ],
// // // // // // //               ),
// // // // // // //               MarkerLayer(
// // // // // // //                 markers: widget.markers,
// // // // // // //               ),
// // // // // // //               // Marker for the vessel
// // // // // // //               MarkerLayer(
// // // // // // //                 markers: [
// // // // // // //                   Marker(
// // // // // // //                     point: _getCurrentVesselPosition(),
// // // // // // //                     width: 60,
// // // // // // //                     height: 60,
// // // // // // //                     child: Transform.rotate(
// // // // // // //                       angle: _getBearing() * pi / 180,
// // // // // // //                       child: Image.asset(
// // // // // // //                         'assets/images/kapal-hijau.png', // Your marker image
// // // // // // //                         width: 50,
// // // // // // //                         height: 50,
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                 ],
// // // // // // //               ),
// // // // // // //             ],
// // // // // // //           ),
// // // // // // //         ],
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   LatLng _getCurrentVesselPosition() {
// // // // // // //     int startIndex = _animation.value.toInt();
// // // // // // //     int endIndex = startIndex + 1;

// // // // // // //     if (endIndex >= _polylinePoints.length) {
// // // // // // //       return _polylinePoints.last; // Return the last position
// // // // // // //     }

// // // // // // //     double t = _animation.value - startIndex;
// // // // // // //     LatLng start = _polylinePoints[startIndex];
// // // // // // //     LatLng end = _polylinePoints[endIndex];

// // // // // // //     // Interpolate between the start and end positions
// // // // // // //     double lat = start.latitude + (end.latitude - start.latitude) * t;
// // // // // // //     double lon = start.longitude + (end.longitude - start.longitude) * t;

// // // // // // //     // Move the map to the current position
// // // // // // //     _mapController.move(LatLng(lat, lon), _mapController.camera.zoom);

// // // // // // //     return LatLng(lat, lon);
// // // // // // //   }

// // // // // // //   double degrees(double radians) {
// // // // // // //     return radians * (180 / pi);
// // // // // // //   }

// // // // // // //   double _getBearing() {
// // // // // // //     int startIndex = _animation.value.toInt();
// // // // // // //     int endIndex = startIndex + 1;

// // // // // // //     if (endIndex >= _polylinePoints.length) {
// // // // // // //       return 0; // No bearing if we are at the last point
// // // // // // //     }

// // // // // // //     LatLng start = _polylinePoints[startIndex];
// // // // // // //     LatLng end = _polylinePoints[endIndex];

// // // // // // //     double lat = (end.latitude - start.latitude).abs();
// // // // // // //     double lng = (end.longitude - start.longitude).abs();

// // // // // // //     if (start.latitude < end.latitude && start.longitude < end.longitude) {
// // // // // // //       return degrees(atan(lng / lat));
// // // // // // //     } else if (start.latitude >= end.latitude && start.longitude < end.longitude) {
// // // // // // //       return (90 - degrees(atan(lng / lat))) + 90;
// // // // // // //     } else if (start.latitude >= end.latitude && start.longitude >= end.longitude) {
// // // // // // //       return degrees(atan(lng / lat)) + 180;
// // // // // // //     } else if (start.latitude < end.latitude && start.longitude >= end.longitude) {
// // // // // // //       return (90 - degrees(atan(lng / lat))) + 270;
// // // // // // //     }
// // // // // // //     return -1;
// // // // // // //   }
// // // // // // // }

// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:flutter_map/flutter_map.dart';
// // // // // // import 'package:latlong2/latlong.dart';

// // // // // // class VesselPlayback extends StatefulWidget {
// // // // // //   final List<LatLng> polylinePoints; // Your polyline points
// // // // // //   final List<Marker> markers; // Your markers
// // // // // //   final double initialLat; // Initial latitude for the vessel
// // // // // //   final double initialLon; // Initial longitude for the vessel

// // // // // //   const VesselPlayback({
// // // // // //     Key? key,
// // // // // //     required this.polylinePoints,
// // // // // //     required this.markers,
// // // // // //     required this.initialLat,
// // // // // //     required this.initialLon,
// // // // // //   }) : super(key: key);

// // // // // //   @override
// // // // // //   _VesselPlaybackState createState() => _VesselPlaybackState();
// // // // // // }

// // // // // // class _VesselPlaybackState extends State<VesselPlayback>
// // // // // //     with SingleTickerProviderStateMixin {
// // // // // //   late AnimationController _controller;
// // // // // //   late Animation<double> _animation;
// // // // // //   late List<LatLng> _polylinePoints; // To hold the polyline points
// // // // // //   late MapController _mapController; // Map controller
// // // // // //   bool isPlaying = false; // Track playback state

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     _polylinePoints = widget.polylinePoints;
// // // // // //     _controller = AnimationController(
// // // // // //       duration: Duration(seconds: 3), // Set your desired duration
// // // // // //       vsync: this,
// // // // // //     );

// // // // // //     // Tween for smooth movement along the polyline
// // // // // //     _animation = Tween<double>(begin: 0.0, end: _polylinePoints.length - 1)
// // // // // //         .animate(CurvedAnimation(
// // // // // //       parent: _controller,
// // // // // //       curve: Curves.linear,
// // // // // //     ));

// // // // // //     // Listen for animation status changes
// // // // // //     _controller.addStatusListener((status) {
// // // // // //       if (status == AnimationStatus.completed) {
// // // // // //         setState(() {
// // // // // //           isPlaying = false; // Stop playback when completed
// // // // // //         });
// // // // // //       }
// // // // // //     });

// // // // // //     // Start playback automatically when the widget is initialized
// // // // // //     _startPlayback();

// // // // // //     // Initialize MapController
// // // // // //     _mapController = MapController();
// // // // // //   }

// // // // // //   void _startPlayback() {
// // // // // //     if (!isPlaying) {
// // // // // //       _controller.forward(); // Start the playback
// // // // // //       setState(() {
// // // // // //         isPlaying = true; // Update playback state
// // // // // //       });
// // // // // //     }
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _controller.dispose();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       body: Stack(
// // // // // //         children: [
// // // // // //           FlutterMap(
// // // // // //             mapController: _mapController, // Set the map controller
// // // // // //             options: MapOptions(
// // // // // //               initialCenter: LatLng(widget.initialLat, widget.initialLon),
// // // // // //               initialZoom: 20,
// // // // // //             ),
// // // // // //             children: [
// // // // // //               TileLayer(
// // // // // //                 urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
// // // // // //               ),
// // // // // //               PolylineLayer(
// // // // // //                 polylines: [
// // // // // //                   Polyline(
// // // // // //                     points: _polylinePoints,
// // // // // //                     color: Colors.blue,
// // // // // //                     strokeWidth: 2,
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //               MarkerLayer(
// // // // // //                 markers: widget.markers,
// // // // // //               ),
// // // // // //               // Marker for the vessel
// // // // // //               MarkerLayer(
// // // // // //                 markers: [
// // // // // //                   Marker(
// // // // // //                     point: _getCurrentVesselPosition(),
// // // // // //                     width: 30,
// // // // // //                     height: 30,
// // // // // //                     child: Icon(Icons.directions_boat, color: Colors.red),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   LatLng _getCurrentVesselPosition() {
// // // // // //     int startIndex = _animation.value.toInt();
// // // // // //     int endIndex = startIndex + 1;

// // // // // //     if (endIndex >= _polylinePoints.length) {
// // // // // //       return _polylinePoints.last; // Return the last position
// // // // // //     }

// // // // // //     double t = _animation.value - startIndex;
// // // // // //     LatLng start = _polylinePoints[startIndex];
// // // // // //     LatLng end = _polylinePoints[endIndex];

// // // // // //     // Interpolate between the start and end positions
// // // // // //     double lat = start.latitude + (end.latitude - start.latitude) * t;
// // // // // //     double lon = start.longitude + (end.longitude - start.longitude) * t;

// // // // // //     return LatLng(lat, lon);
// // // // // //   }
// // // // // // }

// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:flutter_map/flutter_map.dart';
// // // // // // import 'package:latlong2/latlong.dart';

// // // // // // class VesselPlayback extends StatefulWidget {
// // // // // //   final List<LatLng> polylinePoints; // Your polyline points
// // // // // //   final List<Marker> markers; // Your markers
// // // // // //   final double initialLat; // Initial latitude for the vessel
// // // // // //   final double initialLon; // Initial longitude for the vessel

// // // // // //   const VesselPlayback({
// // // // // //     Key? key,
// // // // // //     required this.polylinePoints,
// // // // // //     required this.markers,
// // // // // //     required this.initialLat,
// // // // // //     required this.initialLon,
// // // // // //   }) : super(key: key);

// // // // // //   @override
// // // // // //   _VesselPlaybackState createState() => _VesselPlaybackState();
// // // // // // }

// // // // // // class _VesselPlaybackState extends State<VesselPlayback>
// // // // // //     with SingleTickerProviderStateMixin {
// // // // // //   late AnimationController _controller;
// // // // // //   late Animation<double> _animation;
// // // // // //   late List<LatLng> _polylinePoints;
// // // // // //   late MapController _mapController;
// // // // // //   bool isPlaying = false;

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     _polylinePoints = widget.polylinePoints;
// // // // // //     _mapController = MapController();

// // // // // //     _controller = AnimationController(
// // // // // //       duration: Duration(seconds: 3), // Set to 3 seconds
// // // // // //       vsync: this,
// // // // // //     );

// // // // // //     _animation = Tween<double>(begin: 0.0, end: _polylinePoints.length - 1)
// // // // // //         .animate(CurvedAnimation(
// // // // // //       parent: _controller,
// // // // // //       curve: Curves.linear,
// // // // // //     ));

// // // // // //     // Listen for animation updates
// // // // // //     _controller.addListener(() {
// // // // // //       setState(() {}); // Trigger rebuild to update the vessel position
// // // // // //     });

// // // // // //     // Start playback automatically when the widget is initialized
// // // // // //     _startPlayback();
// // // // // //   }

// // // // // //   void _startPlayback() {
// // // // // //     if (!isPlaying) {
// // // // // //       _controller.forward(); // Start the playback
// // // // // //       setState(() {
// // // // // //         isPlaying = true; // Update playback state
// // // // // //       });
// // // // // //     }
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _controller.dispose();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       body: Stack(
// // // // // //         children: [
// // // // // //           FlutterMap(
// // // // // //             mapController: _mapController,
// // // // // //             options: MapOptions(
// // // // // //               initialCenter: LatLng(widget.initialLat, widget.initialLon),
// // // // // //               initialZoom: 20,
// // // // // //             ),
// // // // // //             children: [
// // // // // //               TileLayer(
// // // // // //                 urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
// // // // // //               ),
// // // // // //               PolylineLayer(
// // // // // //                 polylines: [
// // // // // //                   Polyline(
// // // // // //                     points: _polylinePoints,
// // // // // //                     color: Colors.blue,
// // // // // //                     strokeWidth: 2,
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //               MarkerLayer(
// // // // // //                 markers: widget.markers,
// // // // // //               ),
// // // // // //               // Marker for the vessel
// // // // // //               MarkerLayer(
// // // // // //                 markers: [
// // // // // //                   Marker(
// // // // // //                     point: _getCurrentVesselPosition(),
// // // // // //                     width: 30,
// // // // // //                     height: 30,
// // // // // //                     child: Icon(Icons.directions_boat, color: Colors.red),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   LatLng _getCurrentVesselPosition() {
// // // // // //     int startIndex = _animation.value.toInt();
// // // // // //     int endIndex = startIndex + 1;

// // // // // //     if (endIndex >= _polylinePoints.length) {
// // // // // //       return _polylinePoints.last; // Return the last position
// // // // // //     }

// // // // // //     double t = _animation.value - startIndex;
// // // // // //     LatLng start = _polylinePoints[startIndex];
// // // // // //     LatLng end = _polylinePoints[endIndex];

// // // // // //     // Interpolate between the start and end positions
// // // // // //     double lat = start.latitude + (end.latitude - start.latitude) * t;
// // // // // //     double lon = start.longitude + (end.longitude - start.longitude) * t;

// // // // // //     return LatLng(lat, lon);
// // // // // //   }
// // // // // // }

// // // // // import 'dart:async';
// // // // // import 'dart:math';
// // // // // import 'dart:typed_data';
// // // // // import 'dart:ui' as ui;

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter/services.dart';
// // // // // import 'package:flutter_map/flutter_map.dart';
// // // // // import 'package:latlong2/latlong.dart' as latlong;
// // // // // import 'package:vector_math/vector_math.dart';

// // // // // class VesselPlayback extends StatefulWidget {
// // // // //   final double initialLat;
// // // // //   final double initialLon;
// // // // //   final List<Marker> markers;

// // // // //   const VesselPlayback(
// // // // //       {Key? key, required this.initialLat, required this.initialLon, required this.markers})
// // // // //       : super(key: key);

// // // // //   @override
// // // // //   _VesselPlaybackState createState() => _VesselPlaybackState();
// // // // // }

// // // // // class _VesselPlaybackState extends State<VesselPlayback>
// // // // //     with TickerProviderStateMixin {
// // // // //   final List<Marker> _markers = <Marker>[];
// // // // //   Animation<double>? _animation;

// // // // //   final _mapMarkerSC = StreamController<List<Marker>>();
// // // // //   late MapController _mapController;

// // // // //   StreamSink<List<Marker>> get _mapMarkerSink => _mapMarkerSC.sink;

// // // // //   Stream<List<Marker>> get mapMarkerStream => _mapMarkerSC.stream;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _mapController = MapController();

// // // // //     // Mulai animasi setelah 1 detik
// // // // //     Future.delayed(const Duration(seconds: 1)).then((value) {
// // // // //       animateVessel(
// // // // //         37.42796133580664,
// // // // //         -122.085749655962,
// // // // //         37.428714,
// // // // //         -122.078301,
// // // // //         _mapMarkerSink,
// // // // //         this,
// // // // //       );
// // // // //     });
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final currentLocationCamera =
// // // // //         latlong.LatLng(widget.initialLat, widget.initialLon);

// // // // //     final flutterMap = StreamBuilder<List<Marker>>(
// // // // //         stream: mapMarkerStream,
// // // // //         builder: (context, snapshot) {
// // // // //           return FlutterMap(
// // // // //             mapController: _mapController,
// // // // //             options: MapOptions(
// // // // //               initialCenter: currentLocationCamera,
// // // // //               initialZoom: 14.0,
// // // // //               interactionOptions: const InteractionOptions(
// // // // //                 flags: InteractiveFlag.pinchZoom |
// // // // //                     InteractiveFlag.drag |
// // // // //                     InteractiveFlag.doubleTapZoom,
// // // // //               ),
// // // // //             ),
// // // // //             children: [
// // // // //               TileLayer(
// // // // //                 urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
// // // // //                 userAgentPackageName: 'com.example.app',
// // // // //               ),
// // // // //               MarkerLayer(
// // // // //                 markers: snapshot.data ?? [],
// // // // //               ),
// // // // //             ],
// // // // //           );
// // // // //         });

// // // // //     return Scaffold(
// // // // //       body: Stack(
// // // // //         children: [
// // // // //           flutterMap,
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Future<Uint8List> getBytesFromAsset(String path, int width) async {
// // // // //     ByteData data = await rootBundle.load(path);
// // // // //     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
// // // // //         targetWidth: width);
// // // // //     ui.FrameInfo fi = await codec.getNextFrame();
// // // // //     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
// // // // //         .buffer
// // // // //         .asUint8List();
// // // // //   }

// // // // //   animateVessel(
// // // // //     double fromLat,
// // // // //     double fromLong,
// // // // //     double toLat,
// // // // //     double toLong,
// // // // //     StreamSink<List<Marker>> mapMarkerSink,
// // // // //     TickerProvider provider,
// // // // //   ) async {
// // // // //     final double bearing = getBearing(
// // // // //       latlong.LatLng(fromLat, fromLong),
// // // // //       latlong.LatLng(toLat, toLong),
// // // // //     );

// // // // //     _markers.clear();

// // // // //     var vesselMarker = Marker(
// // // // //       width: 60.0,
// // // // //       height: 60.0,
// // // // //       point: latlong.LatLng(fromLat, fromLong),
// // // // //       child: Transform.rotate(
// // // // //         angle: bearing * pi / 180,
// // // // //         child: Image.asset(
// // // // //           'assets/images/kapal-hijau.png',
// // // // //           width: 50,
// // // // //           height: 50,
// // // // //         ),
// // // // //       ),
// // // // //     );

// // // // //     // Tambahkan marker awal
// // // // //     _markers.add(vesselMarker);
// // // // //     mapMarkerSink.add(_markers);

// // // // //     final animationController = AnimationController(
// // // // //       duration: const Duration(seconds: 5),
// // // // //       vsync: provider,
// // // // //     );

// // // // //     Tween<double> tween = Tween(begin: 0, end: 1);
// // // // //     _animation = tween.animate(animationController)
// // // // //       ..addListener(() {
// // // // //         final v = _animation!.value;
// // // // //         double lng = v * toLong + (1 - v) * fromLong;
// // // // //         double lat = v * toLat + (1 - v) * fromLat;
// // // // //         latlong.LatLng newPos = latlong.LatLng(lat, lng);

// // // // //         _markers.clear();
// // // // //         vesselMarker = Marker(
// // // // //           width: 60.0,
// // // // //           height: 60.0,
// // // // //           point: newPos,
// // // // //           child: Transform.rotate(
// // // // //             angle: bearing * pi / 180,
// // // // //             child: Image.asset(
// // // // //               'assets/images/kapal-hijau.png',
// // // // //               width: 50,
// // // // //               height: 50,
// // // // //             ),
// // // // //           ),
// // // // //         );

// // // // //         _markers.add(vesselMarker);
// // // // //         mapMarkerSink.add(_markers);

// // // // //         _mapController.move(newPos, _mapController.camera.zoom);
// // // // //       });

// // // // //     animationController.forward();
// // // // //   }

// // // // //   double getBearing(latlong.LatLng begin, latlong.LatLng end) {
// // // // //     double lat = (begin.latitude - end.latitude).abs();
// // // // //     double lng = (begin.longitude - end.longitude).abs();

// // // // //     if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
// // // // //       return degrees(atan(lng / lat));
// // // // //     } else if (begin.latitude >= end.latitude &&
// // // // //         begin.longitude < end.longitude) {
// // // // //       return (90 - degrees(atan(lng / lat))) + 90;
// // // // //     } else if (begin.latitude >= end.latitude &&
// // // // //         begin.longitude >= end.longitude) {
// // // // //       return degrees(atan(lng / lat)) + 180;
// // // // //     } else if (begin.latitude < end.latitude &&
// // // // //         begin.longitude >= end.longitude) {
// // // // //       return (90 - degrees(atan(lng / lat))) + 270;
// // // // //     }
// // // // //     return -1;
// // // // //   }
// // // // // }

// // // // import 'dart:async';
// // // // import 'dart:math';
// // // // import 'dart:typed_data';
// // // // import 'dart:ui' as ui;

// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter/services.dart';
// // // // import 'package:flutter_map/flutter_map.dart';
// // // // import 'package:latlong2/latlong.dart' as latlong;
// // // // import 'package:latlong2/latlong.dart';
// // // // import 'package:vector_math/vector_math.dart';

// // // // class VesselPlayback extends StatefulWidget {
// // // //   final double initialLat;
// // // //   final double initialLon;
// // // //   final List<LatLng> polylinePoints;
// // // //   final List<Marker> markers;

// // // //   const VesselPlayback(
// // // //       {Key? key,
// // // //       required this.initialLat,
// // // //       required this.initialLon,
// // // //       required this.markers,
// // // //       required this.polylinePoints})
// // // //       : super(key: key);

// // // //   @override
// // // //   _VesselPlaybackState createState() => _VesselPlaybackState();
// // // // }

// // // // class _VesselPlaybackState extends State<VesselPlayback>
// // // //     with TickerProviderStateMixin {
// // // //   Animation<double>? _animation;
// // // //   final _mapMarkerSC = StreamController<List<Marker>>();
// // // //   late MapController _mapController;

// // // //   StreamSink<List<Marker>> get _mapMarkerSink => _mapMarkerSC.sink;
// // // //   Stream<List<Marker>> get mapMarkerStream => _mapMarkerSC.stream;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _mapController = MapController();

// // // //     // Start animating through the marker list after a 1-second delay
// // // //     Future.delayed(const Duration(seconds: 0)).then((_) {
// // // //       animateThroughMarkers(widget.markers, _mapMarkerSink, this);
// // // //     });
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final currentLocationCamera =
// // // //         latlong.LatLng(widget.initialLat, widget.initialLon);

// // // //     final flutterMap = StreamBuilder<List<Marker>>(
// // // //         stream: mapMarkerStream,
// // // //         builder: (context, snapshot) {
// // // //           return FlutterMap(
// // // //             mapController: _mapController,
// // // //             options: MapOptions(
// // // //               initialCenter: currentLocationCamera,
// // // //               initialZoom: 14.0,
// // // //               interactionOptions: const InteractionOptions(
// // // //                 flags: InteractiveFlag.pinchZoom |
// // // //                     InteractiveFlag.drag |
// // // //                     InteractiveFlag.doubleTapZoom,
// // // //               ),
// // // //             ),
// // // //             children: [
// // // //               TileLayer(
// // // //                 urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
// // // //                 userAgentPackageName: 'com.example.app',
// // // //               ),
// // // //               PolylineLayer(
// // // //                 polylines: [
// // // //                   Polyline(
// // // //                     points: widget.polylinePoints,
// // // //                     strokeWidth: 2,
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               MarkerLayer(
// // // //                 markers: snapshot.data ?? widget.markers,
// // // //               ),
// // // //             ],
// // // //           );
// // // //         });

// // // //     return Scaffold(
// // // //       body: Stack(
// // // //         children: [
// // // //           flutterMap,
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Future<Uint8List> getBytesFromAsset(String path, int width) async {
// // // //     ByteData data = await rootBundle.load(path);
// // // //     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
// // // //         targetWidth: width);
// // // //     ui.FrameInfo fi = await codec.getNextFrame();
// // // //     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
// // // //         .buffer
// // // //         .asUint8List();
// // // //   }

// // // //   // Function to animate through each marker in the list
// // // //   void animateThroughMarkers(
// // // //     List<Marker> markers,
// // // //     StreamSink<List<Marker>> mapMarkerSink,
// // // //     TickerProvider provider,
// // // //   ) async {
// // // //     for (int i = 0; i < markers.length - 1; i++) {
// // // //       final fromMarker = markers[i];
// // // //       final toMarker = markers[i + 1];

// // // //       final fromLat = fromMarker.point.latitude;
// // // //       final fromLong = fromMarker.point.longitude;
// // // //       final toLat = toMarker.point.latitude;
// // // //       final toLong = toMarker.point.longitude;

// // // //       await animateVessel(
// // // //         fromLat,
// // // //         fromLong,
// // // //         toLat,
// // // //         toLong,
// // // //         mapMarkerSink,
// // // //         provider,
// // // //       );
// // // //     }
// // // //   }

// // // //   Future<void> animateVessel(
// // // //     double fromLat,
// // // //     double fromLong,
// // // //     double toLat,
// // // //     double toLong,
// // // //     StreamSink<List<Marker>> mapMarkerSink,
// // // //     TickerProvider provider,
// // // //   ) async {
// // // //     final double bearing = getBearing(
// // // //       latlong.LatLng(fromLat, fromLong),
// // // //       latlong.LatLng(toLat, toLong),
// // // //     );

// // // //     widget.markers.clear();

// // // //     var vesselMarker = Marker(
// // // //       width: 60.0,
// // // //       height: 60.0,
// // // //       point: latlong.LatLng(fromLat, fromLong),
// // // //       child: Transform.rotate(
// // // //         angle: bearing * pi / 180,
// // // //         child: Image.asset(
// // // //           'assets/images/kapal-hijau.png',
// // // //           width: 50,
// // // //           height: 50,
// // // //         ),
// // // //       ),
// // // //     );

// // // //     widget.markers.add(vesselMarker);
// // // //     mapMarkerSink.add(widget.markers);

// // // //     final animationController = AnimationController(
// // // //       duration: const Duration(seconds: 5),
// // // //       vsync: provider,
// // // //     );

// // // //     Tween<double> tween = Tween(begin: 0, end: 1);
// // // //     _animation = tween.animate(animationController)
// // // //       ..addListener(() {
// // // //         final v = _animation!.value;
// // // //         double lng = v * toLong + (1 - v) * fromLong;
// // // //         double lat = v * toLat + (1 - v) * fromLat;
// // // //         latlong.LatLng newPos = latlong.LatLng(lat, lng);

// // // //         widget.markers.clear();
// // // //         vesselMarker = Marker(
// // // //           width: 60.0,
// // // //           height: 60.0,
// // // //           point: newPos,
// // // //           child: Transform.rotate(
// // // //             angle: bearing * pi / 180,
// // // //             child: Image.asset(
// // // //               'assets/images/kapal-hijau.png',
// // // //               width: 50,
// // // //               height: 50,
// // // //             ),
// // // //           ),
// // // //         );

// // // //         widget.markers.add(vesselMarker);
// // // //         mapMarkerSink.add(widget.markers);

// // // //         _mapController.move(newPos, _mapController.camera.zoom);
// // // //       });

// // // //     await animationController.forward();
// // // //     animationController.dispose();
// // // //   }

// // // //   double getBearing(latlong.LatLng begin, latlong.LatLng end) {
// // // //     double lat = (begin.latitude - end.latitude).abs();
// // // //     double lng = (begin.longitude - end.longitude).abs();

// // // //     if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
// // // //       return degrees(atan(lng / lat));
// // // //     } else if (begin.latitude >= end.latitude &&
// // // //         begin.longitude < end.longitude) {
// // // //       return (90 - degrees(atan(lng / lat))) + 90;
// // // //     } else if (begin.latitude >= end.latitude &&
// // // //         begin.longitude >= end.longitude) {
// // // //       return degrees(atan(lng / lat)) + 180;
// // // //     } else if (begin.latitude < end.latitude &&
// // // //         begin.longitude >= end.longitude) {
// // // //       return (90 - degrees(atan(lng / lat))) + 270;
// // // //     }
// // // //     return -1;
// // // //   }
// // // // }

// // // import 'dart:async';
// // // import 'dart:math';
// // // import 'dart:typed_data';
// // // import 'dart:ui' as ui;

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/services.dart';
// // // import 'package:flutter_map/flutter_map.dart';
// // // import 'package:latlong2/latlong.dart' as latlong;
// // // import 'package:vector_math/vector_math.dart';

// // // class VesselPlayback extends StatefulWidget {
// // //   final double initialLat;
// // //   final double initialLon;
// // //   final List<latlong.LatLng> polylinePoints;
// // //   final List<Marker> markers;

// // //   const VesselPlayback({
// // //     Key? key,
// // //     required this.initialLat,
// // //     required this.initialLon,
// // //     required this.markers,
// // //     required this.polylinePoints,
// // //   }) : super(key: key);

// // //   @override
// // //   _VesselPlaybackState createState() => _VesselPlaybackState();
// // // }

// // // class _VesselPlaybackState extends State<VesselPlayback>
// // //     with TickerProviderStateMixin {
// // //   Animation<double>? _animation;
// // //   final _mapMarkerSC = StreamController<List<Marker>>();
// // //   late MapController _mapController;

// // //   StreamSink<List<Marker>> get _mapMarkerSink => _mapMarkerSC.sink;
// // //   Stream<List<Marker>> get mapMarkerStream => _mapMarkerSC.stream;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _mapController = MapController();

// // //     Future.delayed(const Duration(seconds: 1)).then((_) {
// // //       print('DATA LATLONG yg akan di delay:');
// // //       for (var marker in widget.markers) {
// // //         print(
// // //             'Marker at position: (${marker.point.latitude}, ${marker.point.longitude})');
// // //       }
// // //       print(widget.markers);
// // //       animateThroughMarkers(widget.markers, _mapMarkerSink, this);
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final currentLocationCamera =
// // //         latlong.LatLng(widget.initialLat, widget.initialLon);

// // //     final flutterMap = StreamBuilder<List<Marker>>(
// // //         stream: mapMarkerStream,
// // //         builder: (context, snapshot) {
// // //           return FlutterMap(
// // //             mapController: _mapController,
// // //             options: MapOptions(
// // //               initialCenter: currentLocationCamera,
// // //               initialZoom: 14.0,
// // //               interactionOptions: const InteractionOptions(
// // //                 flags: InteractiveFlag.pinchZoom |
// // //                     InteractiveFlag.drag |
// // //                     InteractiveFlag.doubleTapZoom,
// // //               ),
// // //             ),
// // //             children: [
// // //               TileLayer(
// // //                 urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
// // //                 userAgentPackageName: 'com.example.app',
// // //               ),
// // //               PolylineLayer(
// // //                 polylines: [
// // //                   Polyline(
// // //                     points: widget.polylinePoints,
// // //                     strokeWidth: 2,
// // //                   ),
// // //                 ],
// // //               ),
// // //               MarkerLayer(
// // //                 markers: snapshot.data ?? widget.markers,
// // //               ),
// // //             ],
// // //           );
// // //         });

// // //     return Scaffold(
// // //       body: Stack(
// // //         children: [
// // //           flutterMap,
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Future<Uint8List> getBytesFromAsset(String path, int width) async {
// // //     ByteData data = await rootBundle.load(path);
// // //     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
// // //         targetWidth: width);
// // //     ui.FrameInfo fi = await codec.getNextFrame();
// // //     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
// // //         .buffer
// // //         .asUint8List();
// // //   }

// // //   // Function to animate through each marker in the list sequentially
// // //   // Future<void> animateThroughMarkers(
// // //   //   List<Marker> markers,
// // //   //   StreamSink<List<Marker>> mapMarkerSink,
// // //   //   TickerProvider provider,
// // //   // ) async {
// // //   //   for (int i = 0; i < markers.length - 1; i++) {
// // //   //     final fromMarker = markers[i];
// // //   //     final toMarker = markers[i + 1];

// // //   //     final fromLat = fromMarker.point.latitude;
// // //   //     final fromLong = fromMarker.point.longitude;
// // //   //     final toLat = toMarker.point.latitude;
// // //   //     final toLong = toMarker.point.longitude;

// // //   //     await animateVessel(
// // //   //       fromLat,
// // //   //       fromLong,
// // //   //       toLat,
// // //   //       toLong,
// // //   //       mapMarkerSink,
// // //   //       provider,
// // //   //     );
// // //   //   }
// // //   // }

// // //   // Future<void> animateThroughMarkers(
// // //   //   List<Marker> markers,
// // //   //   StreamSink<List<Marker>> mapMarkerSink,
// // //   //   TickerProvider provider,
// // //   // ) async {
// // //   //   if (markers.isEmpty) return;

// // //   //   // Start from the initial marker position
// // //   //   final initialMarker = markers.first;

// // //   //   double fromLat = initialMarker.point.latitude;
// // //   //   double fromLong = initialMarker.point.longitude;

// // //   //   // Loop through each target position and animate the vessel marker from `fromLat, fromLong`
// // //   //   // to each subsequent marker in the list.
// // //   //   for (int i = 1; i < markers.length; i++) {
// // //   //     final toMarker = markers[i];
// // //   //     double toLat = toMarker.point.latitude;
// // //   //     double toLong = toMarker.point.longitude;

// // //   //     // Animate vessel from `fromLat, fromLong` to `toLat, toLong`
// // //   //     await animateVessel(
// // //   //       fromLat,
// // //   //       fromLong,
// // //   //       toLat,
// // //   //       toLong,
// // //   //       mapMarkerSink,
// // //   //       provider,
// // //   //     );

// // //   //     // Update `fromLat, fromLong` for the next iteration
// // //   //     fromLat = toLat;
// // //   //     fromLong = toLong;
// // //   //   }
// // //   // }

// // //   // Future<void> animateThroughMarkers(
// // //   //   List<Marker> markers,
// // //   //   StreamSink<List<Marker>> mapMarkerSink,
// // //   //   TickerProvider provider,
// // //   // ) async {
// // //   //   if (markers.isEmpty) return;

// // //   //   // Start from the last marker position
// // //   //   double fromLat = markers.last.point.latitude;
// // //   //   double fromLong = markers.last.point.longitude;

// // //   //   // Loop through each target position in reverse order
// // //   //   for (int i = markers.length - 2; i >= 0; i--) {
// // //   //     final toMarker = markers[i];
// // //   //     double toLat = toMarker.point.latitude;
// // //   //     double toLong = toMarker.point.longitude;

// // //   //     // Animate vessel from `fromLat, fromLong` to `toLat, toLong`
// // //   //     await animateVessel(
// // //   //       fromLat,
// // //   //       fromLong,
// // //   //       toLat,
// // //   //       toLong,
// // //   //       mapMarkerSink,
// // //   //       provider,
// // //   //     );

// // //   //     // Update `fromLat, fromLong` for the next iteration
// // //   //     fromLat = toLat;
// // //   //     fromLong = toLong;
// // //   //   }
// // //   // }

// // //   // Future<void> animateThroughMarkers(
// // //   //   List<Marker> markers,
// // //   //   StreamSink<List<Marker>> mapMarkerSink,
// // //   //   TickerProvider provider,
// // //   // ) async {
// // //   //   if (markers.isEmpty) return;

// // //   //   for (int i = 0; i < markers.length - 1; i++) {
// // //   //     final fromMarker = markers[i];
// // //   //     final toMarker = markers[i + 1];
// // //   //     double fromLat = fromMarker.point.latitude;
// // //   //     double fromLong = fromMarker.point.longitude;
// // //   //     double toLat = toMarker.point.latitude;
// // //   //     double toLong = toMarker.point.longitude;

// // //   //     await animateVessel(
// // //   //       fromLat,
// // //   //       fromLong,
// // //   //       toLat,
// // //   //       toLong,
// // //   //       mapMarkerSink,
// // //   //       provider,
// // //   //     );
// // //   //   }
// // //   // }

// // //   // // Updated animateVessel function to move between two points and await each segment
// // //   // Future<void> animateVessel(
// // //   //   double fromLat,
// // //   //   double fromLong,
// // //   //   double toLat,
// // //   //   double toLong,
// // //   //   StreamSink<List<Marker>> mapMarkerSink,
// // //   //   TickerProvider provider,
// // //   // ) async {
// // //   //   final double bearing = getBearing(
// // //   //     latlong.LatLng(fromLat, fromLong),
// // //   //     latlong.LatLng(toLat, toLong),
// // //   //   );

// // //   //   widget.markers.clear();

// // //   //   var carMarker = Marker(
// // //   //     width: 60.0,
// // //   //     height: 60.0,
// // //   //     point: latlong.LatLng(fromLat, fromLong),
// // //   //     child: Transform.rotate(
// // //   //       angle: bearing * pi / 180,
// // //   //       child: Image.asset(
// // //   //         'assets/images/kapal-hijau.png',
// // //   //         width: 50,
// // //   //         height: 50,
// // //   //       ),
// // //   //     ),
// // //   //   );

// // //   //   widget.markers.add(carMarker);
// // //   //   mapMarkerSink.add(widget.markers);

// // //   //   final animationController = AnimationController(
// // //   //     duration: const Duration(seconds: 5),
// // //   //     vsync: provider,
// // //   //   );

// // //   //   Tween<double> tween = Tween(begin: 0, end: 1);
// // //   //   _animation = tween.animate(animationController)
// // //   //     ..addListener(() {
// // //   //       final v = _animation!.value;
// // //   //       double lng = v * toLong + (1 - v) * fromLong;
// // //   //       double lat = v * toLat + (1 - v) * fromLat;
// // //   //       latlong.LatLng newPos = latlong.LatLng(lat, lng);

// // //   //       widget.markers.clear();
// // //   //       carMarker = Marker(
// // //   //         width: 60.0,
// // //   //         height: 60.0,
// // //   //         point: newPos,
// // //   //         child: Transform.rotate(
// // //   //           angle: bearing * pi / 180,
// // //   //           child: Image.asset(
// // //   //             'assets/images/kapal-hijau.png',
// // //   //             width: 50,
// // //   //             height: 50,
// // //   //           ),
// // //   //         ),
// // //   //       );

// // //   //       widget.markers.add(carMarker);
// // //   //       mapMarkerSink.add(widget.markers);

// // //   //       _mapController.move(newPos, _mapController.camera.zoom);
// // //   //     });

// // //   //   await animationController.forward();
// // //   //   animationController.dispose();
// // //   // }

// // // // Future<void> animateThroughMarkers(
// // // //   List<Marker> markers,
// // // //   StreamSink<List<Marker>> mapMarkerSink,
// // // //   TickerProvider provider,
// // // // ) async {
// // // //   if (markers.isEmpty) return;

// // // //   // Set starting point as the first marker in the list
// // // //   double fromLat = markers[0].point.latitude;
// // // //   double fromLong = markers[0].point.longitude;

// // // //   print('test');
// // // //   print(markers.length);
// // // //   // Loop through each target marker, starting from the second marker
// // // //   for (int i = 1; i < markers.length; i++) {
// // // //     final toMarker = markers[i];
// // // //     double toLat = toMarker.point.latitude;
// // // //     double toLong = toMarker.point.longitude;

// // // //     // Animate vessel from the current position to the next target position
// // // //     await animateVessel(
// // // //       fromLat,
// // // //       fromLong,
// // // //       toLat,
// // // //       toLong,
// // // //       mapMarkerSink,
// // // //       provider,
// // // //     );

// // // //     // Update the starting point for the next segment
// // // //     fromLat = toLat;
// // // //     fromLong = toLong;
// // // //   }
// // // // }

// // // // Future<void> animateVessel(
// // // //   double fromLat,
// // // //   double fromLong,
// // // //   double toLat,
// // // //   double toLong,
// // // //   StreamSink<List<Marker>> mapMarkerSink,
// // // //   TickerProvider provider,
// // // // ) async {
// // // //   final double bearing = getBearing(
// // // //     latlong.LatLng(fromLat, fromLong),
// // // //     latlong.LatLng(toLat, toLong),
// // // //   );

// // // //   widget.markers.clear();

// // // //   var vesselMarker = Marker(
// // // //     width: 60.0,
// // // //     height: 60.0,
// // // //     point: latlong.LatLng(fromLat, fromLong),
// // // //     child: Transform.rotate(
// // // //       angle: bearing * pi / 180,
// // // //       child: Image.asset(
// // // //         'assets/images/kapal-hijau.png',
// // // //         width: 50,
// // // //         height: 50,
// // // //       ),
// // // //     ),
// // // //   );

// // // //   widget.markers.add(vesselMarker);
// // // //   mapMarkerSink.add(widget.markers);

// // // //   final animationController = AnimationController(
// // // //     duration: const Duration(seconds: 5),
// // // //     vsync: provider,
// // // //   );

// // // //   Tween<double> tween = Tween(begin: 0, end: 1);
// // // //   _animation = tween.animate(animationController)
// // // //     ..addListener(() {
// // // //       final v = _animation!.value;
// // // //       double lng = v * toLong + (1 - v) * fromLong;
// // // //       double lat = v * toLat + (1 - v) * fromLat;
// // // //       latlong.LatLng newPos = latlong.LatLng(lat, lng);

// // // //       widget.markers.clear();
// // // //       vesselMarker = Marker(
// // // //         width: 60.0,
// // // //         height: 60.0,
// // // //         point: newPos,
// // // //         child: Transform.rotate(
// // // //           angle: bearing * pi / 180,
// // // //           child: Image.asset(
// // // //             'assets/images/kapal-hijau.png',
// // // //             width: 50,
// // // //             height: 50,
// // // //           ),
// // // //         ),
// // // //       );

// // // //       widget.markers.add(vesselMarker);
// // // //       mapMarkerSink.add(widget.markers);

// // // //       _mapController.move(newPos, _mapController.camera.zoom);
// // // //     });

// // // //   await animationController.forward();
// // // //   animationController.dispose();
// // // // }

// // // // Future<void> animateThroughMarkers(
// // // //   List<Marker> markers,
// // // //   StreamSink<List<Marker>> mapMarkerSink,
// // // //   TickerProvider provider,
// // // // ) async {
// // // //   if (markers.isEmpty) return;

// // // //   // Starting point as the first marker in the list
// // // //   double fromLat = markers[0].point.latitude;
// // // //   double fromLong = markers[0].point.longitude;

// // // //   print('Total markers: ${markers.length}');

// // // //   // Loop through each target marker, starting from the second marker
// // // //   for (int i = 1; i < markers.length; i++) {
// // // //     final toMarker = markers[i];
// // // //     double toLat = toMarker.point.latitude;
// // // //     double toLong = toMarker.point.longitude;

// // // //     print('Animating from point ($fromLat, $fromLong) to ($toLat, $toLong)');

// // // //     // Animate vessel from the current position to the next target position
// // // //     await animateVessel(
// // // //       fromLat,
// // // //       fromLong,
// // // //       toLat,
// // // //       toLong,
// // // //       mapMarkerSink,
// // // //       provider,
// // // //     );

// // // //     // Update starting point to the last destination
// // // //     fromLat = toLat;
// // // //     fromLong = toLong;
// // // //   }
// // // // }

// // // // Future<void> animateVessel(
// // // //   double fromLat,
// // // //   double fromLong,
// // // //   double toLat,
// // // //   double toLong,
// // // //   StreamSink<List<Marker>> mapMarkerSink,
// // // //   TickerProvider provider,
// // // // ) async {
// // // //   final double bearing = getBearing(
// // // //     latlong.LatLng(fromLat, fromLong),
// // // //     latlong.LatLng(toLat, toLong),
// // // //   );

// // // //   widget.markers.clear();

// // // //   var carMarker = Marker(
// // // //     width: 60.0,
// // // //     height: 60.0,
// // // //     point: latlong.LatLng(fromLat, fromLong),
// // // //     child: Transform.rotate(
// // // //       angle: bearing * pi / 180,
// // // //       child: Image.asset(
// // // //         'assets/images/kapal-hijau.png',
// // // //         width: 50,
// // // //         height: 50,
// // // //       ),
// // // //     ),
// // // //   );

// // // //   widget.markers.add(carMarker);
// // // //   mapMarkerSink.add(widget.markers);

// // // //   final animationController = AnimationController(
// // // //     duration: const Duration(seconds: 3),
// // // //     vsync: provider,
// // // //   );

// // // //   Tween<double> tween = Tween(begin: 0, end: 1);
// // // //   _animation = tween.animate(animationController)
// // // //     ..addListener(() {
// // // //       final v = _animation!.value;
// // // //       double lng = v * toLong + (1 - v) * fromLong;
// // // //       double lat = v * toLat + (1 - v) * fromLat;
// // // //       latlong.LatLng newPos = latlong.LatLng(lat, lng);

// // // //       widget.markers.clear();
// // // //       carMarker = Marker(
// // // //         width: 60.0,
// // // //         height: 60.0,
// // // //         point: newPos,
// // // //         child: Transform.rotate(
// // // //           angle: bearing * pi / 180,
// // // //           child: Image.asset(
// // // //             'assets/images/kapal-hijau.png',
// // // //             width: 50,
// // // //             height: 50,
// // // //           ),
// // // //         ),
// // // //       );

// // // //       widget.markers.add(carMarker);
// // // //       mapMarkerSink.add(widget.markers);

// // // //       _mapController.move(newPos, _mapController.camera.zoom);
// // // //     });

// // // //   // Await the completion of the animation
// // // //   await animationController.forward();
// // // //   print("Animation complete from ($fromLat, $fromLong) to ($toLat, $toLong)");

// // // //   animationController.dispose();
// // // // }

// // //   // Future<void> animateThroughMarkers(
// // //   //   List<Marker> markers,
// // //   //   StreamSink<List<Marker>> mapMarkerSink,
// // //   //   TickerProvider provider,
// // //   // ) async {
// // //   //   if (markers.isEmpty) return;

// // //   //   // Set starting point as the first marker in the list
// // //   //   double fromLat = markers[0].point.latitude;
// // //   //   double fromLong = markers[0].point.longitude;

// // //   //   print('DATA LATLONG:');
// // //   //   for (var marker in widget.markers) {
// // //   //     print(
// // //   //         'Marker at position: (${marker.point.latitude}, ${marker.point.longitude})');
// // //   //   }

// // //   //   print('Total markers: ${markers.length}');

// // //   //   // Loop through each target marker, starting from the second marker
// // //   //   for (int i = 1; i < markers.length; i++) {
// // //   //     final toMarker = markers[i];
// // //   //     double toLat = toMarker.point.latitude;
// // //   //     double toLong = toMarker.point.longitude;

// // //   //     print('Animating from point ($fromLat, $fromLong) to ($toLat, $toLong)');

// // //   //     // Animate vessel from the current position to the next target position
// // //   //     await animateVessel(
// // //   //       fromLat,
// // //   //       fromLong,
// // //   //       toLat,
// // //   //       toLong,
// // //   //       mapMarkerSink,
// // //   //       provider,
// // //   //     );

// // //   //     // Update starting point to the last destination
// // //   //     fromLat = toLat;
// // //   //     fromLong = toLong;
// // //   //   }

// // //   //   print('Animation completed for all markers!');
// // //   // }

// // //   // Future<void> animateVessel(
// // //   //   double fromLat,
// // //   //   double fromLong,
// // //   //   double toLat,
// // //   //   double toLong,
// // //   //   StreamSink<List<Marker>> mapMarkerSink,
// // //   //   TickerProvider provider,
// // //   // ) async {
// // //   //   final double bearing = getBearing(
// // //   //     latlong.LatLng(fromLat, fromLong),
// // //   //     latlong.LatLng(toLat, toLong),
// // //   //   );

// // //   //   widget.markers.clear();

// // //   //   var carMarker = Marker(
// // //   //     width: 60.0,
// // //   //     height: 60.0,
// // //   //     point: latlong.LatLng(fromLat, fromLong),
// // //   //     child: Transform.rotate(
// // //   //       angle: bearing * pi / 180,
// // //   //       child: Image.asset(
// // //   //         'assets/images/kapal-hijau.png',
// // //   //         width: 50,
// // //   //         height: 50,
// // //   //       ),
// // //   //     ),
// // //   //   );

// // //   //   widget.markers.add(carMarker);
// // //   //   mapMarkerSink.add(widget.markers);

// // //   //   final animationController = AnimationController(
// // //   //     duration: const Duration(seconds: 5),
// // //   //     vsync: provider,
// // //   //   );

// // //   //   Tween<double> tween = Tween(begin: 0, end: 1);
// // //   //   _animation = tween.animate(animationController)
// // //   //     ..addListener(() {
// // //   //       final v = _animation!.value;
// // //   //       double lng = v * toLong + (1 - v) * fromLong;
// // //   //       double lat = v * toLat + (1 - v) * fromLat;
// // //   //       latlong.LatLng newPos = latlong.LatLng(lat, lng);

// // //   //       widget.markers.clear();
// // //   //       carMarker = Marker(
// // //   //         width: 60.0,
// // //   //         height: 60.0,
// // //   //         point: newPos,
// // //   //         child: Transform.rotate(
// // //   //           angle: bearing * pi / 180,
// // //   //           child: Image.asset(
// // //   //             'assets/images/kapal-hijau.png',
// // //   //             width: 50,
// // //   //             height: 50,
// // //   //           ),
// // //   //         ),
// // //   //       );

// // //   //       widget.markers.add(carMarker);
// // //   //       mapMarkerSink.add(widget.markers);

// // //   //       _mapController.move(newPos, _mapController.camera.zoom);
// // //   //     });

// // //   //   // Await the completion of the animation
// // //   //   await animationController.forward();
// // //   //   print("Animation complete from ($fromLat, $fromLong) to ($toLat, $toLong)");

// // //   //   animationController.dispose();
// // //   // }

// // //   // Future<void> animateThroughMarkers(
// // //   //   List<Marker> markers,
// // //   //   StreamSink<List<Marker>> mapMarkerSink,
// // //   //   TickerProvider provider,
// // //   // ) async {
// // //   //   if (markers.isEmpty) return;

// // //   //   // Set starting point as the first marker in the list
// // //   //   double fromLat = markers[0].point.latitude;
// // //   //   double fromLong = markers[0].point.longitude;

// // //   //   print('TESTING:');

// // //   //   print('DATA LATLONG:');
// // //   //   for (var marker in markers) {
// // //   //     print(
// // //   //         'Marker at position: (${marker.point.latitude}, ${marker.point.longitude})');
// // //   //   }

// // //   //   print('Total markers: ${markers.length}');

// // //   //   // Loop through each target marker, starting from the second marker
// // //   //   for (int i = 1; i < markers.length; i++) {
// // //   //     final toMarker = markers[i];
// // //   //     // double fromLat = markers[i].point.latitude;
// // //   //     // double fromLong = markers[i].point.longitude;
// // //   //     double toLat = toMarker.point.latitude;
// // //   //     double toLong = toMarker.point.longitude;

// // //   //     print('Animating from point ($fromLat, $fromLong) to ($toLat, $toLong)');

// // //   //     // Animate vessel from the current position to the next target position
// // //   //     await animateVessel(
// // //   //       fromLat,
// // //   //       fromLong,
// // //   //       toLat,
// // //   //       toLong,
// // //   //       mapMarkerSink,
// // //   //       provider,
// // //   //     );
// // //   //     // Update starting point to the last destination
// // //   //     fromLat = toLat;
// // //   //     fromLong = toLong;

// // //   //     print('test point ($fromLat, $fromLong) to ($toLat, $toLong)');

// // //   //   }

// // //   //   print('Animation completed for all markers!');
// // //   // }

// // //   // Future<void> animateThroughMarkers(
// // //   //   List<Marker> markers,
// // //   //   StreamSink<List<Marker>> mapMarkerSink,
// // //   //   TickerProvider provider,
// // //   // ) async {
// // //   //   if (markers.isEmpty) return;

// // //   //   double fromLat = markers[0].point.latitude;
// // //   //   double fromLong = markers[0].point.longitude;

// // //   //   print('DATA LATLONG:');
// // //   //   for (var marker in markers) {
// // //   //     print(
// // //   //         'Marker at position: (${marker.point.latitude}, ${marker.point.longitude})');
// // //   //   }

// // //   //   print('Total markers: ${markers.length}');

// // //   //   // Loop through each target marker, starting from the second marker
// // //   //   for (int i = 1; i < markers.length; i++) {
// // //   //     final toMarker = markers[i];
// // //   //     double toLat = toMarker.point.latitude;
// // //   //     double toLong = toMarker.point.longitude;

// // //   //     print('Animating from point ($fromLat, $fromLong) to ($toLat, $toLong)');

// // //   //     // Animate vessel from the current position to the next target position
// // //   //     await animateVessel(
// // //   //       fromLat,
// // //   //       fromLong,
// // //   //       toLat,
// // //   //       toLong,
// // //   //       mapMarkerSink,
// // //   //       provider,
// // //   //     );

// // //   //     print('test point ($fromLat, $fromLong) to ($toLat, $toLong)');
// // //   //   }
// // //   //   print('Animation completed for all markers!');
// // //   // }

// // //   Future<void> animateThroughMarkers(
// // //     List<Marker> markers,
// // //     StreamSink<List<Marker>> mapMarkerSink,
// // //     TickerProvider provider,
// // //   ) async {
// // //     if (markers.isEmpty) return;

// // //     for (var marker in markers) {
// // //       print(
// // //           'Marker at position: (${marker.point.latitude}, ${marker.point.longitude})');
// // //     }

// // //     print('Total markers: ${markers.length}');

// // //     // Start animation from the first marker's position
// // //     double fromLat = markers[0].point.latitude;
// // //     double fromLong = markers[0].point.longitude;

// // //     // Loop through each target marker, moving from one to the next
// // //     for (int i = 1; i < markers.length; i++) {
// // //       try {
// // //         final toMarker = markers[i];
// // //         double toLat = toMarker.point.latitude;
// // //         double toLong = toMarker.point.longitude;

// // //         print(
// // //             'Animating from point ($fromLat, $fromLong) to ($toLat, $toLong)');

// // //         // Animate vessel from current position to the next target position
// // //         await animateVessel(
// // //           fromLat,
// // //           fromLong,
// // //           toLat,
// // //           toLong,
// // //           mapMarkerSink,
// // //           provider,
// // //         );

// // //         // Confirm the animation step is complete
// // //         print(
// // //             'Animation complete from ($fromLat, $fromLong) to ($toLat, $toLong)');

// // //         // Update starting point for the next animation step
// // //         fromLat = toLat;
// // //         fromLong = toLong;

// // //         print('Reached point ($toLat, $toLong), moving to next.');
// // //       } catch (e) {
// // //         print('Error during animation: $e');
// // //       }
// // //     }
// // //     print('Animation completed for all markers!');
// // //   }

// // //   Future<void> animateVessel(
// // //     double fromLat,
// // //     double fromLong,
// // //     double toLat,
// // //     double toLong,
// // //     StreamSink<List<Marker>> mapMarkerSink,
// // //     TickerProvider provider,
// // //   ) async {
// // //     final double bearing = getBearing(
// // //       latlong.LatLng(fromLat, fromLong),
// // //       latlong.LatLng(toLat, toLong),
// // //     );

// // //     var carMarker = Marker(
// // //       width: 60.0,
// // //       height: 60.0,
// // //       point: latlong.LatLng(fromLat, fromLong),
// // //       child: Transform.rotate(
// // //         angle: bearing * pi / 180,
// // //         child: Image.asset(
// // //           'assets/images/kapal-hijau.png',
// // //           width: 50,
// // //           height: 50,
// // //         ),
// // //       ),
// // //     );

// // //     // Update the marker position on the map
// // //     widget.markers.clear();
// // //     widget.markers.add(carMarker);
// // //     mapMarkerSink.add(widget.markers);

// // //     final animationController = AnimationController(
// // //       duration: const Duration(seconds: 3),
// // //       vsync: provider,
// // //     );

// // //     Tween<double> tween = Tween(begin: 0, end: 1);
// // //     _animation = tween.animate(animationController)
// // //       ..addListener(() {
// // //         final v = _animation!.value;
// // //         double lng = v * toLong + (1 - v) * fromLong;
// // //         double lat = v * toLat + (1 - v) * fromLat;
// // //         latlong.LatLng newPos = latlong.LatLng(lat, lng);

// // //         // Update marker position during the animation
// // //         carMarker = Marker(
// // //           width: 60.0,
// // //           height: 60.0,
// // //           point: newPos,
// // //           child: Transform.rotate(
// // //             angle: bearing * pi / 180,
// // //             child: Image.asset(
// // //               'assets/images/kapal-hijau.png',
// // //               width: 50,
// // //               height: 50,
// // //             ),
// // //           ),
// // //         );

// // //         widget.markers.clear();
// // //         widget.markers.add(carMarker);
// // //         mapMarkerSink.add(widget.markers);

// // //         _mapController.move(newPos, _mapController.camera.zoom);
// // //       });

// // //     // Await the completion of the animation
// // //     await animationController.forward();
// // //     print("Animation complete from ($fromLat, $fromLong) to ($toLat, $toLong)");

// // //     animationController.dispose();
// // //   }

// // //   // double getBearing(latlong.LatLng begin, latlong.LatLng end) {
// // //   //   double lat = (begin.latitude - end.latitude).abs();
// // //   //   double lng = (begin.longitude - end.longitude).abs();

// // //   //   if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
// // //   //     return degrees(atan(lng / lat));
// // //   //   } else if (begin.latitude >= end.latitude &&
// // //   //       begin.longitude < end.longitude) {
// // //   //     return (90 - degrees(atan(lng / lat))) + 90;
// // //   //   } else if (begin.latitude >= end.latitude &&
// // //   //       begin.longitude >= end.longitude) {
// // //   //     return degrees(atan(lng / lat)) + 180;
// // //   //   } else if (begin.latitude < end.latitude &&
// // //   //       begin.longitude >= end.longitude) {
// // //   //     return (90 - degrees(atan(lng / lat))) + 270;
// // //   //   }
// // //   //   return -1;
// // //   // }

// // //   double getBearing(latlong.LatLng begin, latlong.LatLng end) {
// // //     double dLat = end.latitude - begin.latitude;
// // //     double dLon = end.longitude - begin.longitude;

// // //     if (dLat == 0 && dLon == 0) {
// // //       // Jika posisi awal dan akhir sama, kembalikan bearing default (misalnya 0 derajat)
// // //       return 0.0;
// // //     }

// // //     // Menghitung sudut bearing
// // //     final radians = atan2(dLon, dLat);
// // //     final degreesBearing = (radians * 180 / pi).remainder(360);

// // //     return degreesBearing < 0 ? degreesBearing + 360 : degreesBearing;
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:latlong2/latlong.dart';
// // import 'package:latlong2/latlong.dart' as latLng;

// // class VesselPlayback extends StatefulWidget {
// //   @override
// //   _VesselPlaybackState createState() => _VesselPlaybackState();
// // }

// // class _VesselPlaybackState extends State<VesselPlayback>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<double> _animation;

// //   // Data marker dalam bentuk latitude dan longitude
// //   final List<LatLng> markers = [
// //     LatLng(1.376252, 128.136055), // Posisi 1
// //     LatLng(1.303478, 128.071918), // Posisi 2
// //     LatLng(1.199570, 128.075116), // Posisi 3
// //     LatLng(1.127708, 128.117967), // Posisi 4
// //     LatLng(1.128041, 128.118160), // Posisi 5
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();

// //     _controller = AnimationController(
// //       duration: Duration(seconds: 5),
// //       vsync: this,
// //     );

// //     _animation =
// //         Tween<double>(begin: 0, end: markers.length - 1).animate(_controller);

// //     // Mulai animasi
// //     _controller.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: FlutterMap(
// //         options: MapOptions(
// //           initialCenter: markers[0], // Pusat peta di marker pertama
// //           initialZoom: 20,
// //         ),
// //         children: [
// //           TileLayer(
// //             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
// //             subdomains: ['a', 'b', 'c'],
// //           ),
// //           MarkerLayer(
// //             markers: markers.map((marker) {
// //               return Marker(
// //                 point: marker,
// //                 child: Icon(
// //                   Icons.location_on,
// //                   color: Colors.red,
// //                   size: 30,
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //           // Marker untuk kapal
// //           MarkerLayer(
// //             markers: [
// //               Marker(
// //                 point: markers[0], // Posisi awal kapal
// //                 child: Icon(
// //                   Icons.directions_boat,
// //                   color: Colors.blue,
// //                   size: 30,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class VesselPlayback extends StatefulWidget {
//   const VesselPlayback(
//       {super.key, required this.polylinePoints, required this.markers});

//   final List<LatLng> polylinePoints;
//   final List<Marker> markers;

//   @override
//   _VesselPlaybackState createState() => _VesselPlaybackState();
// }

// class _VesselPlaybackState extends State<VesselPlayback>
//     with SingleTickerProviderStateMixin {

//   late AnimationController _controller;
//   late LatLngTween _latLngTween;
//   late Animation<LatLng> _animation;
//   int _currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..addListener(() {
//         setState(() {});
//       });

//     _initializeTween();
//   }

//   void _initializeTween() {
//     List<LatLng> coordinates =
//         widget.markers.map((marker) => marker.point).toList();

//     if (_currentIndex < coordinates.length - 1) {
//       _latLngTween = LatLngTween(
//         begin: coordinates[_currentIndex],
//         end: coordinates[_currentIndex + 1],
//       );
//       _animation = _latLngTween.animate(CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ));
//       _controller.forward(from: 0).then((_) {
//         _currentIndex++;
//         if (_currentIndex < coordinates.length - 1) {
//           _initializeTween();
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterMap(
//       options: MapOptions(
//         initialCenter:
//             widget.markers.isNotEmpty ? widget.markers[0].point : LatLng(0, 0),
//         initialZoom: 12,
//       ),
//       children: [
//         TileLayer(
//           urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//           subdomains: ['a', 'b', 'c'],
//         ),
//         PolylineLayer(
//           polylines: [
//             Polyline(
//               points: widget.polylinePoints,
//               color: Colors.blue,
//               strokeWidth: 2,
//             ),
//           ],
//         ),
//         MarkerLayer(
//           markers: [
//             ...widget.markers,
//             if (_animation.value != null)
//               Marker(
//                 width: 40,
//                 height: 40,
//                 point: _animation.value,
//                 child: Icon(
//                   Icons.directions_boat,
//                   color: Colors.blue,
//                   size: 30,
//                 ),
//               ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// class VesselPlayback extends StatefulWidget {
//   const VesselPlayback(
//       {super.key, required this.polylinePoints, required this.markers});

//   final List<LatLng> polylinePoints;
//   final List<Marker> markers;

//   @override
//   _VesselPlaybackState createState() => _VesselPlaybackState();
// }

// class _VesselPlaybackState extends State<VesselPlayback>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late LatLngTween _latLngTween;
//   late Animation<LatLng> _animation;
//   late MapController _mapController;
//   int _currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _mapController = MapController();

//     // Mulai dari titik terakhir
//     _currentIndex = widget.markers.length - 1;

//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     )..addListener(() {
//         setState(() {
//           // Gerakkan peta ke posisi animasi saat ini
//           if (_animation.value != null) {
//             _mapController.move(_animation.value, _mapController.camera.zoom);
//           }
//         });
//       });

//     _initializeTween();
//   }

//   void _initializeTween() {
//     List<LatLng> coordinates =
//         widget.markers.map((marker) => marker.point).toList();

//     if (_currentIndex > 0) {
//       // if (_currentIndex < coordinates.length - 1) {
//       _latLngTween = LatLngTween(
//         begin: coordinates[_currentIndex],
//         // end: coordinates[_currentIndex + 1],
//         end: coordinates[_currentIndex - 1],
//       );
//       _animation = _latLngTween.animate(CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ));
//       _controller.forward(from: 0).then((_) {
//         // _currentIndex++;
//         _currentIndex--;
//         if (_currentIndex > 0) {
//           // if (_currentIndex < coordinates.length - 1) {
//           _initializeTween();
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   double getBearing(LatLng start, LatLng end) {
//     double lat1 = start.latitude * pi / 180; // Mengubah latitude ke radian
//     double lon1 = start.longitude * pi / 180; // Mengubah longitude ke radian
//     double lat2 = end.latitude * pi / 180; // Mengubah latitude ke radian
//     double lon2 = end.longitude * pi / 180; // Mengubah longitude ke radian

//     double dLon = lon2 - lon1;

//     // Menghitung bearing menggunakan rumus
//     double y = sin(dLon) * cos(lat2);
//     double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
//     double bearing = atan2(y, x);

//     // Mengubah bearing dari radian ke derajat
//     bearing = bearing * 180 / pi;

//     // Memastikan bearing berada dalam rentang 0 - 360 derajat
//     if (bearing < 0) {
//       bearing += 360;
//     }

//     return bearing;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlutterMap(
//         mapController: _mapController,
//         options: MapOptions(
//           initialCenter: widget.markers.isNotEmpty
//               // ? widget.markers[0].point
//               ? widget.markers[widget.markers.length - 1].point
//               : LatLng(0, 0),
//           initialZoom: 12,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: ['a', 'b', 'c'],
//           ),
//           PolylineLayer(
//             polylines: [
//               Polyline(
//                 points: widget.polylinePoints,
//                 color: Colors.blue,
//                 strokeWidth: 2,
//               ),
//             ],
//           ),
//           MarkerLayer(
//             markers: [
//               ...widget.markers,
//               if (_animation.value != null)
//                 Marker(
//                   width: 40,
//                   height: 40,
//                   point: _animation.value,
//                   child: Image.asset(
//                     'assets/images/kapal-hijau.png',
//                     width: 50,
//                     height: 50,
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


class VesselPlayback extends StatefulWidget {
  const VesselPlayback({super.key, required this.polylinePoints, required this.markers});

  final List<LatLng> polylinePoints;
  final List<Marker> markers;

  @override
  _VesselPlaybackState createState() => _VesselPlaybackState();
}

class _VesselPlaybackState extends State<VesselPlayback> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late LatLngTween _latLngTween;
  late Animation<LatLng> _animation;
  late MapController _mapController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    // Mulai dari titik terakhir
    _currentIndex = widget.markers.length - 1;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          // Gerakkan peta ke posisi animasi saat ini
          if (_animation.value != null) {
            _mapController.move(_animation.value, _mapController.camera.zoom);
          }
        });
      });

    _initializeTween();
  }

  void _initializeTween() {
    List<LatLng> coordinates = widget.markers.map((marker) => marker.point).toList();

    if (_currentIndex > 0) {
      // Menghitung titik awal dan titik akhir
      _latLngTween = LatLngTween(
        begin: coordinates[_currentIndex],
        end: coordinates[_currentIndex - 1],
      );
      _animation = _latLngTween.animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0).then((_) {
        _currentIndex--;
        if (_currentIndex > 0) {
          _initializeTween();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double getBearing(LatLng start, LatLng end) {
    double lat1 = start.latitude * pi / 180; // Mengubah latitude ke radian
    double lon1 = start.longitude * pi / 180; // Mengubah longitude ke radian
    double lat2 = end.latitude * pi / 180;   // Mengubah latitude ke radian
    double lon2 = end.longitude * pi / 180;  // Mengubah longitude ke radian

    double dLon = lon2 - lon1;

    // Menghitung bearing menggunakan rumus
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    double bearing = atan2(y, x);

    // Mengubah bearing dari radian ke derajat
    bearing = bearing * 180 / pi;

    // Memastikan bearing berada dalam rentang 0 - 360 derajat
    if (bearing < 0) {
      bearing += 360;
    }

    return bearing;
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung bearing jika ada dua titik berturut-turut
    double bearing = 0;
    if (_currentIndex > 0) {
      List<LatLng> coordinates = widget.markers.map((marker) => marker.point).toList();
      bearing = getBearing(coordinates[_currentIndex], coordinates[_currentIndex - 1]);
    }

    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: widget.markers.isNotEmpty
              ? widget.markers[widget.markers.length - 1].point
              : LatLng(0, 0),
          initialZoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: widget.polylinePoints,
                color: Colors.blue,
                strokeWidth: 2,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              ...widget.markers,
              if (_animation.value != null)
                Marker(
                  width: 40,
                  height: 40,
                  point: _animation.value,
                  child: Transform.rotate(
                    angle: (bearing * pi / 180), // Convert bearing to radians
                    child: Image.asset(
                      'assets/images/kapal-hijau.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
