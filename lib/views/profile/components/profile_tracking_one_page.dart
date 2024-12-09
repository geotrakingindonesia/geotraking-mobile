// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, sort_child_properties_last, deprecated_member_use, unused_field
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

// import 'dart:math';
// import 'dart:typed_data';
// // import 'package:vector_math/vector_math.dart';

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
  // int _currentIndex = 0;
  bool _showAirtimeModal = false;
  bool _showVesselModal = false;
  bool _showTrackingModal = false;
  bool _showWeatherModal = false;
  bool _showMileageModal = false;

  // bool _isPlaying = false;
  // bool _isPaused = false;
  String _selectedMapProvider = 'OpenStreetMap';
  Map<String, dynamic>? _vesselData;

  bool isPlaybackActive = false;

  String _selectedTimezonePreferences = 'UTC+7';
  String _selectedSpeedPreferences = 'Knots';
  String _selectedCoordinatePreferences = 'Degrees';

  @override
  void initState() {
    super.initState();
    // _loadLanguageFromSharedPreferences();
    _loadPreferences();
    _showVesselModal = true;
    _fetchAndShowVesselData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
      _selectedLanguage = prefs.getString('language') ?? 'English';
    });
  }

  // _loadTimeZonePreferencesFromSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final timeZonePreferences = prefs.getString('SetTimezonePreferences');
  //   if (timeZonePreferences != null) {
  //     setState(() {
  //       _selectedTimezonePreferences = timeZonePreferences;
  //     });
  //   }
  // }

  // _loadLanguageFromSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final language = prefs.getString('language');
  //   if (language != null) {
  //     setState(() {
  //       _selectedLanguage = language;
  //     });
  //   }
  // }

  void _onTrackVessel(List<LatLng> polylinePoints, List<Marker> markers,
      List<double> headings) {
    setState(() {
      _polylinePointsTraking = polylinePoints;
      _markersTraking = markers;
      _headingsTraking = headings;
      _initialMarkers = List.from(markers);
    });
  }

  void _startPlayback() {
    setState(() {
      isPlaybackActive = true;
    });
  }

  void _stopPlayback() {
    setState(() {
      isPlaybackActive = false;
    });
  }

  Future<void> _fetchAndShowVesselData() async {
    // final vesselDataList = await vesselService.getDataKapal(_selectedTimezonePreferences);
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
      // backgroundColor: Colors.transparent,

      backgroundColor: Colors.white,
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
                          scrollDirection: Axis.horizontal,
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
                                    selectedTimeZonePreferences:
                                        _selectedTimezonePreferences,
                                    selectedSpeedPreferences:
                                        _selectedSpeedPreferences,
                                    selectedCoordinatePreferences:
                                        _selectedCoordinatePreferences,
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
