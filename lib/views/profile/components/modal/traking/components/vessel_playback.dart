// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class VesselPlayback extends StatefulWidget {
  const VesselPlayback(
      {super.key, required this.polylinePoints, required this.markers});

  final List<LatLng> polylinePoints;
  final List<Marker> markers;

  @override
  _VesselPlaybackState createState() => _VesselPlaybackState();
}

class _VesselPlaybackState extends State<VesselPlayback>
    with SingleTickerProviderStateMixin {
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
    List<LatLng> coordinates =
        widget.markers.map((marker) => marker.point).toList();

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
    double lat1 = start.latitude * pi / 180;
    double lon1 = start.longitude * pi / 180;
    double lat2 = end.latitude * pi / 180;
    double lon2 = end.longitude * pi / 180;

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
      List<LatLng> coordinates =
          widget.markers.map((marker) => marker.point).toList();
      bearing = getBearing(
          coordinates[_currentIndex], coordinates[_currentIndex - 1]);
    }

    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: widget.markers.isNotEmpty
              ? widget.markers[widget.markers.length - 1].point
              : LatLng(0, 0),
          initialZoom: 12,
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.pinchZoom |
                InteractiveFlag.drag |
                InteractiveFlag.doubleTapZoom,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
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
                    angle: (bearing * pi / 180),
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
