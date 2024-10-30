// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/formated_latlong.dart';
import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class MileageLocationPage extends StatefulWidget {
  final List<Map<String, dynamic>>? data;

  const MileageLocationPage({super.key, this.data});

  @override
  _MileageLocationPageState createState() => _MileageLocationPageState();
}

class _MileageLocationPageState extends State<MileageLocationPage> {
  final MapController mapController = MapController();
  String _selectedMapProvider = 'OpenStreetMap';
  Map<String, dynamic>? _selectedMarkerData;
  final formatterLatlong = FormatedLatlong();
  bool? _isStartMarker;

  LatLng _getInitialCenter() {
    if (widget.data != null && widget.data!.isNotEmpty) {
      return LatLng(
        double.parse(widget.data!.first['start_latitude'].toString()),
        double.parse(widget.data!.first['start_longitude'].toString()),
      );
    }
    return LatLng(-4.4511412299261, 111.082877130109);
  }

  List<LatLng> _getPolylinePoints() {
    List<LatLng> polylinePoints = [];

    for (var i = 0; i < widget.data!.length; i++) {
      final entry = widget.data![i];

      polylinePoints.add(
        LatLng(
          double.parse(entry['start_latitude'].toString()),
          double.parse(entry['start_longitude'].toString()),
        ),
      );

      polylinePoints.add(
        LatLng(
          double.parse(entry['end_latitude'].toString()),
          double.parse(entry['end_longitude'].toString()),
        ),
      );
    }
    return polylinePoints;
  }

  List<Marker> _buildMarkers() {
    return widget.data?.expand((entry) {
          return [
            // mark awal
            Marker(
              width: 80,
              height: 80,
              point: LatLng(
                double.parse(entry['start_latitude'].toString()),
                double.parse(entry['start_longitude'].toString()),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMarkerData = entry;
                    _isStartMarker = true;
                  });
                },
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
            // mark akhir
            Marker(
              width: 80,
              height: 80,
              point: LatLng(
                double.parse(entry['end_latitude'].toString()),
                double.parse(entry['end_longitude'].toString()),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMarkerData = entry;
                    _isStartMarker = false;
                  });
                },
                child: Icon(
                  Icons.location_on,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ),
          ];
        }).toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    final polylinePoints = _getPolylinePoints();
    final markers = _buildMarkers();
    final initialCenter = _getInitialCenter();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: 20,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.doubleTapZoom,
              ),
            ),
            mapController: mapController,
            children: [
              TileLayer(
                urlTemplate: MapConfig.getUrlTemplate(_selectedMapProvider),
                userAgentPackageName: 'com.example.app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: polylinePoints,
                    color: Colors.blue,
                    strokeWidth: 1.0,
                  ),
                ],
              ),
              MarkerLayer(
                markers: markers,
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
          if (_selectedMarkerData != null)
            Positioned(
              left: 20,
              bottom: 20,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tanggal: ${DateFormat('dd MMM yyyy hh:mm a').format(_isStartMarker == true ? _selectedMarkerData!['waktu_awal'] : _selectedMarkerData!['waktu_akhir'])}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon:
                              Icon(Icons.close, size: 20, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              _selectedMarkerData = null;
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      'Latitude: ${_isStartMarker == true ? formatterLatlong.formatLatitude(double.tryParse(_selectedMarkerData!['start_latitude'].toString())) : formatterLatlong.formatLatitude(double.tryParse(_selectedMarkerData!['end_latitude'].toString()))}',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Longitude: ${_isStartMarker == true ? formatterLatlong.formatLongitude(double.tryParse(_selectedMarkerData!['start_longitude'].toString())) : formatterLatlong.formatLongitude(double.tryParse(_selectedMarkerData!['end_longitude'].toString()))}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
