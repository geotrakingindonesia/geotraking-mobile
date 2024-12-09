// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/formated_latlong.dart';
import 'package:geotraking/core/components/info_row.dart';
import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:info_popup/info_popup.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MileageLocationPage extends StatefulWidget {
  final List<Map<String, dynamic>>? data;

  const MileageLocationPage({super.key, this.data});

  @override
  _MileageLocationPageState createState() => _MileageLocationPageState();
}

class _MileageLocationPageState extends State<MileageLocationPage> {
  final MapController mapController = MapController();
  String _selectedMapProvider = 'OpenStreetMap';
  final formatterLatlong = FormatedLatlong();

  String _selectedTimezonePreferences = 'UTC+7';
  String _selectedSpeedPreferences = 'Knots';
  String _selectedCoordinatePreferences = 'Degrees';

  List<LatLng> get points =>
      widget.data?.map((location) {
        double lat = location['latitude'] is String
            ? double.parse(location['latitude'])
            : location['latitude'];
        double lng = location['longitude'] is String
            ? double.parse(location['longitude'])
            : location['longitude'];
        return LatLng(lat, lng);
      }).toList() ??
      [];

  @override
  void initState() {
    super.initState();
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

  String _getSpeed(Map<String, dynamic> data) {
    switch (_selectedSpeedPreferences) {
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

  @override
  Widget build(BuildContext context) {
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
              initialCenter: points.isNotEmpty ? points[0] : LatLng(0, 0),
              initialZoom: 12,
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
                    points: points,
                    color: Colors.blue,
                    strokeWidth: 2.0,
                  ),
                ],
              ),
              MarkerLayer(
                markers: widget.data?.map((location) {
                      double lat = location['latitude'] is String
                          ? double.parse(location['latitude'])
                          : location['latitude'];
                      double lng = location['longitude'] is String
                          ? double.parse(location['longitude'])
                          : location['longitude'];
                      double heading = location['heading'] is String
                          ? double.parse(location['heading'])
                          : location['heading'];
                      double speedKn = location['speed_kn'] is String
                          ? double.parse(location['speed_kn'])
                          : location['speed_kn'];
                      String received;
                      if (location['received'] is DateTime) {
                        received = DateFormat('dd MMM yyyy hh:mm a')
                            .format(location['received']);
                      } else {
                        received = location['received'] ?? 'N/A';
                      }

                      String speed = _getSpeed(location);

                      return Marker(
                        point: LatLng(lat, lng),
                        width: 13,
                        height: 13,
                        child: InfoPopupWidget(
                          child: Transform.rotate(
                            angle: heading * pi / 180,
                            child: Image.asset(
                              'assets/images/arrow_traking.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          customContent: () => Container(
                            padding: EdgeInsets.all(8),
                            width: 290,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildInfoRow(
                                    'Received date (${_selectedTimezonePreferences})',
                                    ': ${received}'),
                                Divider(),
                                buildInfoRow(
                                  'Latitude',
                                  _selectedCoordinatePreferences == 'Degrees'
                                      ? ': ${formatterLatlong.formatLatitude(lat)}'
                                      : ': ${lat.toString()}',
                                ),
                                // ': ${formatterLatlong.formatLatitude(lat)}'),
                                Divider(),
                                buildInfoRow(
                                  'Longitude',
                                  _selectedCoordinatePreferences == 'Degrees'
                                      ? ': ${formatterLatlong.formatLongitude(lng)}'
                                      : ': ${lng.toString()}',
                                ),
                                // ': ${formatterLatlong.formatLongitude(lng)}'),
                                Divider(),
                                buildInfoRow('Heading', ': ${heading}°'),
                                Divider(),
                                buildInfoRow(
                                  'Speed',
                                  //   ': ${_getSpeed(data)} ${_selectedSpeedPreferences}',
                                  // ),
                                  ': $speed ${_selectedSpeedPreferences}',
                                ),
                                // ': ${speedKn.toStringAsFixed(2)} Knots'),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ],
          ),
          // Map tool to change map provider
          MapTool(
            mapController: mapController,
            selectedMapProvider: _selectedMapProvider,
            onMapProviderChanged: (value) {
              setState(() {
                _selectedMapProvider = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
