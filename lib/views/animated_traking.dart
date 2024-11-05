import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:vector_math/vector_math.dart';

class AnimatedTraking extends StatefulWidget {
  const AnimatedTraking({Key? key}) : super(key: key);

  @override
  _AnimatedTrakingState createState() => _AnimatedTrakingState();
}

class _AnimatedTrakingState extends State<AnimatedTraking> with TickerProviderStateMixin {
  final List<Marker> _markers = <Marker>[];
  Animation<double>? _animation;

  final _mapMarkerSC = StreamController<List<Marker>>();
  late MapController _mapController;

  StreamSink<List<Marker>> get _mapMarkerSink => _mapMarkerSC.sink;

  Stream<List<Marker>> get mapMarkerStream => _mapMarkerSC.stream;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    // Mulai animasi setelah 1 detik
    Future.delayed(const Duration(seconds: 1)).then((value) {
      animateCar(
        37.42796133580664,
        -122.085749655962,
        37.428714,
        -122.078301,
        _mapMarkerSink,
        this,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLocationCamera =
        latlong.LatLng(37.42796133580664, -122.085749655962);

    final flutterMap = StreamBuilder<List<Marker>>(
        stream: mapMarkerStream,
        builder: (context, snapshot) {
          return FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: currentLocationCamera,
              initialZoom: 14.0,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.doubleTapZoom,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: snapshot.data ?? [],
              ),
            ],
          );
        });

    return Scaffold(
      body: Stack(
        children: [
          flutterMap,
        ],
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  animateCar(
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
    StreamSink<List<Marker>> mapMarkerSink,
    TickerProvider provider,
  ) async {
    final double bearing = getBearing(
      latlong.LatLng(fromLat, fromLong),
      latlong.LatLng(toLat, toLong),
    );

    _markers.clear();

    var carMarker = Marker(
      width: 60.0,
      height: 60.0,
      point: latlong.LatLng(fromLat, fromLong),
      child: Transform.rotate(
        angle: bearing * pi / 180,
        child: Image.asset(
          'assets/images/kapal-hijau.png',
          width: 50,
          height: 50,
        ),
      ),
    );

    // Tambahkan marker awal
    _markers.add(carMarker);
    mapMarkerSink.add(_markers);

    final animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: provider,
    );

    Tween<double> tween = Tween(begin: 0, end: 1);
    _animation = tween.animate(animationController)
      ..addListener(() {
        final v = _animation!.value;
        double lng = v * toLong + (1 - v) * fromLong;
        double lat = v * toLat + (1 - v) * fromLat;
        latlong.LatLng newPos = latlong.LatLng(lat, lng);

        _markers.clear();
        carMarker = Marker(
          width: 60.0,
          height: 60.0,
          point: newPos,
          child: Transform.rotate(
            angle: bearing * pi / 180,
            child: Image.asset(
              'assets/images/kapal-hijau.png',
              width: 50,
              height: 50,
            ),
          ),
        );

        _markers.add(carMarker);
        mapMarkerSink.add(_markers);

        _mapController.move(newPos, _mapController.camera.zoom);
      });

    animationController.forward();
  }

  double getBearing(latlong.LatLng begin, latlong.LatLng end) {
    double lat = (begin.latitude - end.latitude).abs();
    double lng = (begin.longitude - end.longitude).abs();

    if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
      return degrees(atan(lng / lat));
    } else if (begin.latitude >= end.latitude &&
        begin.longitude < end.longitude) {
      return (90 - degrees(atan(lng / lat))) + 90;
    } else if (begin.latitude >= end.latitude &&
        begin.longitude >= end.longitude) {
      return degrees(atan(lng / lat)) + 180;
    } else if (begin.latitude < end.latitude &&
        begin.longitude >= end.longitude) {
      return (90 - degrees(atan(lng / lat))) + 270;
    }
    return -1;
  }
}
