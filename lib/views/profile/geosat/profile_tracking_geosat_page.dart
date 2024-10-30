// ignore_for_file: prefer_final_fields, prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unnecessary_string_interpolations, unused_local_variable, unused_field, avoid_print, prefer_const_literals_to_create_immutables, deprecated_member_use
// import 'package:animate_do/animate_do.dart';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/card_vessel_color.dart';
import 'package:geotraking/core/components/loading_map.dart';
// import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:geotraking/core/components/marker_image_widget.dart';
import 'package:geotraking/core/components/selected_basarnas_info.dart';
import 'package:geotraking/core/components/selected_pelabuhan_info.dart';
// import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/core/models/basarnas.dart';
import 'package:geotraking/core/models/port_ri.dart';
import 'package:geotraking/core/models/port_ri_detail.dart';
import 'package:geotraking/core/models/wpp.dart';
import 'package:geotraking/core/models/wpp_latlon.dart';
import 'package:geotraking/core/services/basarnas_service.dart';
import 'package:geotraking/core/services/port_ri_service.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/core/services/wpp_service.dart';
import 'package:geotraking/views/profile/components/modal/airtime/airtime_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/traking/traking_data_modal.dart';
import 'package:geotraking/views/profile/geosat/components/vessel_data_geosat_modal.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timeago/timeago.dart' as timeago;

class ProfileTrackingGeosatPage extends StatefulWidget {
  const ProfileTrackingGeosatPage({super.key});

  @override
  _ProfileTrackingGeosatPageState createState() =>
      _ProfileTrackingGeosatPageState();
}

class _ProfileTrackingGeosatPageState extends State<ProfileTrackingGeosatPage> {
  final WppRiService _wppRiService = WppRiService();
  final PortPelabuhanService _portPelabuhanService = PortPelabuhanService();
  final BasarnasService _basarnasService = BasarnasService();
  final VesselService vesselService = VesselService();
  final MapController mapController = MapController();

  List<Basarnas> _basarnasList = [];
  List<PortPelabuhan> _portPelabuhanList = [];
  List<Map<String, dynamic>> _kapalGeosatList = [];

  List<WppRi> wppList = [];
  List<dynamic> zoneWpp = [];
  List<Polygon> _polygons = [];

  List<Marker> _markers = []; // Individual markers
  List<CircleMarker> _circleMarkers = []; // Circle markers for clusters
  double _currentZoom = 4;


    final ScrollController _scrollController = ScrollController();

  String _searchQuery = '';
  bool _isSidebarVisible = false;

  Map<String, dynamic>? kapalGeosat;

  PortRi? portRi;
  Basarnas? _selectedBasarnas;
  PortPelabuhan? _selectedPortPelabuhan;

  List<LatLng> _points = [];

  bool _isShowNamaKapal = false;
  bool _isShowBasarnas = false;
  bool _isShowPortPelabuhan = false;
  bool _isShowMyKapal = false;
  bool _isShowWpp = false;
  bool _isLoading = true;

  Map<String, dynamic>? _selectedKapal;

  String _selectedLanguage = 'English';

  List<Color> colors = [
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.brown,
    Colors.tealAccent,
    Colors.cyan,
    Colors.lime,
  ];

  String _selectedMapProvider = 'OpenStreetMap';

  @override
  void initState() {
    super.initState();
    _fetchData();
    _loadLanguageFromSharedPreferences();
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
  
  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
      if (!_isSidebarVisible) {
        _searchQuery = '';
      }
    });
  }

  
  List<dynamic> get _filteredVesselList {
    if (_searchQuery.isEmpty) {
      return _kapalGeosatList;
    }
    return _kapalGeosatList
        .where((vessel) => vessel['nama_kapal']
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void _animateMoveTo(LatLng targetLocation) {
    const int steps = 10;
    const Duration delay = Duration(milliseconds: 50);
    final LatLng currentLocation = mapController.camera.center;

    double latitudeStep =
        (targetLocation.latitude - currentLocation.latitude) / steps;
    double longitudeStep =
        (targetLocation.longitude - currentLocation.longitude) / steps;

    for (int i = 1; i <= steps; i++) {
      Future.delayed(delay * i, () {
        final newLatLng = LatLng(
          currentLocation.latitude + latitudeStep * i,
          currentLocation.longitude + longitudeStep * i,
        );
        double zoomLevel = 20;
        mapController.move(newLatLng, zoomLevel);
        setState(() {
          _currentZoom = zoomLevel;
        });
      });
    }
  }



  List<LatLng> _polylinePointsTraking = [];
  List<Marker> _markersTraking = [];

  // void _onTrackVessel(List<LatLng> polylinePoints, List<Marker> markers) {
  //   setState(() {
  //     _polylinePointsTraking = polylinePoints;
  //     _markersTraking = markers;
  //   });
  // }

  void _onTrackVessel(List<LatLng> polylinePoints, List<Marker> markers,
      List<double> headings) {
    setState(() {
      _polylinePointsTraking = polylinePoints;
      _markersTraking = markers;
    });
  }

  Future<void> _fetchData() async {
    try {
      List<WppLatLong?> allZoneWpp = await _wppRiService.getAllZoneWpp();

      var pointsByWppId = <int, List<LatLng>>{};
      for (var zone in allZoneWpp) {
        if (!pointsByWppId.containsKey(zone!.wppId)) {
          pointsByWppId[zone.wppId!] = [];
        }
        pointsByWppId[zone.wppId]!.add(LatLng(zone.lat, zone.lon));
      }

      _polygons = pointsByWppId.entries
          .toList()
          .asMap()
          .map((index, entry) {
            List<LatLng> points = entry.value;
            String labelText = 'WPP-${571 + index + (index >= 3 ? 137 : 0)}';
            return MapEntry(
              index,
              Polygon(
                points: points,
                color: colors[index % colors.length].withOpacity(0.3),
                isFilled: true,
                // isDotted: true,
                borderColor: Colors.black45,
                borderStrokeWidth: 2,
                label: labelText,
                labelStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            );
          })
          .values
          .toList();

      final basarnasData = await _basarnasService.getCachedData();
      final portPelabuhanData = await _portPelabuhanService.getCachedData();
      final kapalGeosatData = await vesselService.getDataKapalGeosat();

      setState(() {
        _basarnasList = basarnasData;
        _portPelabuhanList = portPelabuhanData;
        _kapalGeosatList = kapalGeosatData!;
        _polygons = _polygons;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  double? parseToDouble(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    try {
      return double.parse(value);
    } catch (e) {
      print('Error parsing double: $e');
      return null;
    }
  }

  // List<CircleMarker> _calculateClusters() {
  //   const double clusterRadius = 10000.0; // Radius for clustering in meters
  //   List<CircleMarker> circles = [];

  //   List<List<LatLng>> clusters = []; // Holds clusters of LatLng
  //   List<LatLng> visited = []; // Keeps track of visited positions

  //   for (var kapal in _kapalGeosatList) {
  //     LatLng position =
  //         LatLng(double.parse(kapal['lat']), double.parse(kapal['lon']));

  //     // If the position is already visited, skip it
  //     if (visited.contains(position)) {
  //       continue;
  //     }

  //     // Create a new cluster
  //     List<LatLng> currentCluster = [position];
  //     visited.add(position);

  //     // Check distances to all other vessels
  //     for (var otherKapal in _kapalGeosatList) {
  //       LatLng otherPosition = LatLng(
  //           double.parse(otherKapal['lat']), double.parse(otherKapal['lon']));

  //       if (position != otherPosition &&
  //           _distanceBetween(position, otherPosition) <= clusterRadius) {
  //         currentCluster.add(otherPosition);
  //         visited.add(otherPosition);
  //       }
  //     }

  //     // Add the current cluster to the list of clusters
  //     clusters.add(currentCluster);
  //   }

  //   // Create CircleMarkers from the clusters
  //   for (var cluster in clusters) {
  //     LatLng center = _calculateClusterCenter(cluster);
  //     circles.add(CircleMarker(
  //       point: center,
  //       color: Colors.blue.withOpacity(0.3),
  //       borderStrokeWidth: 2,
  //       borderColor: Colors.blue.shade100,
  //       radius:
  //           20 + (cluster.length * 0.1), // Adjust circle radius based on size
  //     ));
  //   }

  //   return circles;
  // }

  // double _distanceBetween(LatLng point1, LatLng point2) {
  //   const double R = 6371000; // Radius of Earth in meters
  //   double dLat = (point2.latitude - point1.latitude) * (3.14159 / 180);
  //   double dLon = (point2.longitude - point1.longitude) * (3.14159 / 180);
  //   double a = (sin(dLat / 2) * sin(dLat / 2)) +
  //       (cos(point1.latitude * (3.14159 / 180)) *
  //           cos(point2.latitude * (3.14159 / 180)) *
  //           sin(dLon / 2) *
  //           sin(dLon / 2));
  //   double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  //   return R * c; // Distance in meters
  // }

  // LatLng _calculateClusterCenter(List<LatLng> positions) {
  //   double latSum = 0;
  //   double lonSum = 0;

  //   for (var pos in positions) {
  //     latSum += pos.latitude;
  //     lonSum += pos.longitude;
  //   }

  //   return LatLng(latSum / positions.length, lonSum / positions.length);
  // }

  // List<CircleMarker> _calculateClusters() {
  //   const double clusterRadius = 10.0; // Radius for clustering in meters
  //   List<CircleMarker> circles = [];

  //   List<List<LatLng>> clusters = []; // Holds clusters of LatLng
  //   List<LatLng> visited = []; // Keeps track of visited positions

  //   for (var kapal in _kapalGeosatList) {
  //     LatLng position =
  //         LatLng(double.parse(kapal['lat']), double.parse(kapal['lon']));

  //     // If the position is already visited, skip it
  //     if (visited.contains(position)) {
  //       continue;
  //     }

  //     // Create a new cluster
  //     List<LatLng> currentCluster = [position];
  //     visited.add(position);

  //     // Check distances to all other vessels
  //     for (var otherKapal in _kapalGeosatList) {
  //       LatLng otherPosition = LatLng(
  //           double.parse(otherKapal['lat']), double.parse(otherKapal['lon']));

  //       if (position != otherPosition &&
  //           _distanceBetween(position, otherPosition) <= clusterRadius) {
  //         currentCluster.add(otherPosition);
  //         visited.add(otherPosition);
  //       }
  //     }

  //     // Only add the current cluster to the list if it has more than one ship
  //     if (currentCluster.length > 1) {
  //       clusters.add(currentCluster);
  //     }
  //   }

  //   // Create CircleMarkers from the clusters
  //   for (var cluster in clusters) {
  //     LatLng center = _calculateClusterCenter(cluster);
  //     circles.add(CircleMarker(
  //       point: center,
  //       color: Colors.blue.withOpacity(0.3),
  //       borderStrokeWidth: 2,
  //       borderColor: Colors.blue.shade100,
  //       radius:
  //           20 + (cluster.length * 0.1), // Adjust circle radius based on size
  //     ));
  //   }

  //   return circles;
  // }

  @override
  Widget build(BuildContext context) {
    // _circleMarkers = _calculateClusters();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: ClipRRect(
            child: AppBar(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Geo',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    TextSpan(
                      text: 'Traking',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Color.fromARGB(255, 13, 124, 102),
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              actions: [
          IconButton(
            icon: Icon(
              _isSidebarVisible ? Icons.cancel : Icons.search,
              color: Colors.black,
            ),
            onPressed: _toggleSidebar,
          ),
        ],
        backgroundColor: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(-4.4511412299261, 111.082877130109),
                initialZoom: _currentZoom,
                // onPositionChanged: (camera, hasGesture) {
                //   setState(() {
                //     _currentZoom = camera.zoom;
                //   });
                // },
                interactionOptions: InteractionOptions(
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
                PolygonLayer<Object>(polygons: _isShowWpp ? _polygons : []),
                MarkerLayer(
                  markers: _isShowBasarnas
                      ? _basarnasList.map((basarnas) {
                          return Marker(
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.lifeRing,
                                color: Colors.black54,
                                size: 14,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedBasarnas = basarnas;
                                });
                              },
                            ),
                            point: LatLng(basarnas.lat, basarnas.lon),
                          );
                        }).toList()
                      : [],
                ),
                MarkerLayer(
                  markers: _isShowPortPelabuhan
                      ? _portPelabuhanList.map((portPelabuhan) {
                          return Marker(
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.towerObservation,
                                color: Colors.brown.withOpacity(0.4),
                                size: 14,
                              ),
                              onPressed: () async {
                                _selectedPortPelabuhan = portPelabuhan;
                                portRi = await _portPelabuhanService
                                    .getDetailDataPortPelabuhan(
                                        portPelabuhan.kodePelabuhan);
                                setState(() {});
                              },
                            ),
                            point: LatLng(portPelabuhan.lat, portPelabuhan.lon),
                          );
                        }).toList()
                      : [],
                ),
                // if (_currentZoom < 7) ...[
                //   CircleLayer(circles: _circleMarkers),
                // ],
                // if (_currentZoom >= 7) ...[
                  MarkerLayer(
                    markers: _kapalGeosatList.map((kapalGeosat) {
                      bool isSelected = _selectedKapal == kapalGeosat;
                      return Marker(
                        width: 30,
                        height: 30,
                        point: LatLng(double.parse(kapalGeosat['lat']),
                            double.parse(kapalGeosat['lon'])),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedKapal = kapalGeosat;
                            });
                          },
                          child: Stack(
                            children: [
                              MarkerImageWidget(
                                timestamp: kapalGeosat['tgl_aktifasi'],
                                heading: kapalGeosat['heading'],
                              ),
                              if (isSelected)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                // ],
                if (_isShowNamaKapal)
                  MarkerLayer(
                    markers: _kapalGeosatList.map((kapalGeosat) {
                      bool isSelected = _selectedKapal == kapalGeosat;
                      return Marker(
                        width: 120,
                        height: 30,
                        point: LatLng(double.parse(kapalGeosat['lat']),
                            double.parse(kapalGeosat['lon'])),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              kapalGeosat['nama_kapal'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.lifeRing,
                        size: 20,
                        color: _isShowBasarnas
                            ? Colors.blue.shade300
                            : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isShowBasarnas = !_isShowBasarnas;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.towerObservation,
                        size: 20,
                        color: _isShowPortPelabuhan
                            ? Colors.blue.shade300
                            : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isShowPortPelabuhan = !_isShowPortPelabuhan;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.mapLocationDot,
                        size: 20,
                        color: _isShowWpp ? Colors.blue.shade300 : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isShowWpp = !_isShowWpp;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.ship,
                        size: 20,
                        color: _isShowNamaKapal
                            ? Colors.blue.shade300
                            : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isShowNamaKapal = !_isShowNamaKapal;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SelectedBasarnasInfo(
              selectedBasarnas: _selectedBasarnas,
              onClose: () {
                setState(() {
                  _selectedBasarnas = null;
                });
              },
            ),
            SelectedPelabuhanInfo(
              selectedPortPelabuhan: _selectedPortPelabuhan,
              portRi: portRi,
              onClose: () {
                setState(() {
                  _selectedPortPelabuhan = null;
                });
              },
            ),
            _isLoading ? LoadingMap() : Container(),
             if (_isSidebarVisible)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.6,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Search Vessel..',
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
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (query) {
                          setState(() {
                            _searchQuery = query;
                            _filteredVesselList;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _searchQuery.isEmpty
                            ? 'Vessel: ${_kapalGeosatList.length}'
                            : _filteredVesselList.isEmpty
                                ? 'Not found.'
                                : 'Vessel found: ${_filteredVesselList.length}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _kapalGeosatList.length,
                        itemBuilder: (context, index) {
                          final vessel = _kapalGeosatList[index];
                          final isSelected = _selectedKapal != null &&
                              vessel['id'] ==
                                  _selectedKapal!['id'];

                          if (_searchQuery.isEmpty ||
                              vessel['nama_kapal']
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase())) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue[100]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedKapal = vessel;
                                    _animateMoveTo(LatLng(
                                      double.parse(vessel['lat']),
                                      double.parse(vessel['lon']),
                                    ));
                                  });
                                  _toggleSidebar();
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: cardVesselColor(
                                                vessel['tgl_aktifasi']),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Text(
                                            vessel['id'],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            vessel['nama_kapal'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      timeago.format(
                                        DateTime.parse(vessel['tgl_aktifasi']),
                                      ),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Visibility(
          visible: _selectedKapal != null,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_boat),
                label: 'Vessel',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_searching),
                label: 'Traking',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Airtime',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.close),
                label: 'Close',
              ),
            ],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            onTap: (index) async {
              if (index == 3) {
                setState(() {
                  _selectedKapal = null;
                });
              } else if (index == 1) {
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    double keyboardHeight =
                        MediaQuery.of(context).viewInsets.bottom;
                    double paddingBottom =
                        keyboardHeight > 0 ? keyboardHeight + 10 : 10;

                    return Padding(
                      padding: EdgeInsets.only(bottom: paddingBottom),
                      child: TrakingDataModal(
                        mobileId: _selectedKapal!['id'],
                        onTrackVessel: _onTrackVessel,
                        onClearHistory: () {
                          setState(() {
                            _polylinePointsTraking.clear();
                            _markersTraking.clear();
                          });
                        },
                      ),
                    );
                  },
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height / 2),
                );
              } else {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return index == 0
                        ? VesselDataGeosatModal(kapalGeosat: _selectedKapal!)
                        : AirtimeDataModal(
                            future: vesselService.getAirtimeKapal(
                                _selectedKapal!['idfull'] ?? ''));
                  },
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height / 3),
                );
              }
            },
          ),
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: AppColors.scaffoldWithBoxBackground,
    //   appBar: PreferredSize(
    //     preferredSize: Size.fromHeight(50.0),
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.only(
    //         bottomLeft: Radius.circular(20.0),
    //         bottomRight: Radius.circular(20.0),
    //       ),
    //       child: AppBar(
    //         title: RichText(
    //           text: TextSpan(
    //             children: [
    //               TextSpan(
    //                 text: 'Geo',
    //                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //               ),
    //               TextSpan(
    //                 text: 'Traking',
    //                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    //                       color: Color.fromARGB(255, 13, 124, 102),
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         automaticallyImplyLeading: false,
    //         backgroundColor: Colors.white,
    //         elevation: 0,
    //       ),
    //     ),
    //   ),
    //   body: Stack(
    //     children: [
    //       FlutterMap(
    //         options: const MapOptions(
    //           initialCenter: LatLng(-4.4511412299261, 111.082877130109),
    //           initialZoom: 4,
    //           interactionOptions: const InteractionOptions(
    //             flags: InteractiveFlag.pinchZoom |
    //                 InteractiveFlag.drag |
    //                 InteractiveFlag.doubleTapZoom,
    //           ),
    //         ),
    //         mapController: mapController,
    //         children: [
    //           TileLayer(
    //             urlTemplate: MapConfig.getUrlTemplate(_selectedMapProvider),
    //             userAgentPackageName: 'com.example.app',
    //           ),
    //           PolygonLayer<Object>(polygons: _isShowWpp ? _polygons : []),
    //           MarkerLayer(
    //             markers: _isShowBasarnas
    //                 ? _basarnasList.map((basarnas) {
    //                     return Marker(
    //                       child: IconButton(
    //                         icon: FaIcon(
    //                           FontAwesomeIcons.lifeRing,
    //                           color: Colors.black54,
    //                           size: 14,
    //                         ),
    //                         onPressed: () {
    //                           setState(() {
    //                             _selectedBasarnas = basarnas;
    //                           });
    //                         },
    //                       ),
    //                       point: LatLng(basarnas.lat, basarnas.lon),
    //                     );
    //                   }).toList()
    //                 : [],
    //           ),
    //           MarkerLayer(
    //             markers: _isShowPortPelabuhan
    //                 ? _portPelabuhanList.map((portPelabuhan) {
    //                     return Marker(
    //                       child: IconButton(
    //                         icon: FaIcon(
    //                           FontAwesomeIcons.towerObservation,
    //                           color: Colors.brown.withOpacity(0.4),
    //                           size: 14,
    //                         ),
    //                         onPressed: () async {
    //                           _selectedPortPelabuhan = portPelabuhan;
    //                           portRi = await _portPelabuhanService
    //                               .getDetailDataPortPelabuhan(
    //                                   portPelabuhan.kodePelabuhan);
    //                           setState(() {});
    //                         },
    //                       ),
    //                       point: LatLng(portPelabuhan.lat, portPelabuhan.lon),
    //                     );
    //                   }).toList()
    //                 : [],
    //           ),
    //           MarkerLayer(
    //             markers: _kapalGeosatList.map((kapalGeosat) {
    //               bool isSelected = _selectedKapal == kapalGeosat;
    //               return Marker(
    //                 width: 30,
    //                 height: 30,
    //                 point: LatLng(double.parse(kapalGeosat['lat']),
    //                     double.parse(kapalGeosat['lon'])),
    //                 child: GestureDetector(
    //                   onTap: () {
    //                     setState(() {
    //                       _selectedKapal = kapalGeosat;
    //                     });
    //                   },
    //                   child: Stack(
    //                     children: [
    //                       MarkerImageWidget(
    //                         timestamp: kapalGeosat['tgl_aktifasi'],
    //                         heading: kapalGeosat['heading'],
    //                       ),
    //                       if (isSelected)
    //                         Positioned(
    //                           left: 0,
    //                           right: 0,
    //                           top: 0,
    //                           bottom: 0,
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                               border:
    //                                   Border.all(color: Colors.red, width: 2),
    //                               borderRadius: BorderRadius.circular(15),
    //                             ),
    //                           ),
    //                         ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             }).toList(),
    //           ),
    //           if (_isShowNamaKapal)
    //             MarkerLayer(
    //               markers: _kapalGeosatList.map((kapalGeosat) {
    //                 bool isSelected = _selectedKapal == kapalGeosat;
    //                 return Marker(
    //                   width: 120,
    //                   height: 30,
    //                   point: LatLng(double.parse(kapalGeosat['lat']),
    //                       double.parse(kapalGeosat['lon'])),
    //                   child: Container(
    //                     padding: const EdgeInsets.all(5),
    //                     decoration: BoxDecoration(
    //                       color: Colors.white.withOpacity(0.3),
    //                       borderRadius: BorderRadius.circular(15),
    //                     ),
    //                     child: Center(
    //                       child: Text(
    //                         kapalGeosat['nama_kapal'],
    //                         overflow: TextOverflow.ellipsis,
    //                         style: TextStyle(color: Colors.black),
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               }).toList(),
    //             ),

    //           PolylineLayer(
    //             polylines: [
    //               Polyline(
    //                 points: _polylinePointsTraking,
    //                 color: Colors.blue,
    //                 strokeWidth: 2,
    //               ),
    //             ],
    //           ),
    //           MarkerLayer(
    //             markers: _markersTraking,
    //           ),
    //         ],
    //       ),
    //       MapTool(
    //         mapController: mapController,
    //         selectedMapProvider: _selectedMapProvider,
    //         onMapProviderChanged: (value) {
    //           setState(() {
    //             _selectedMapProvider = value;
    //           });
    //         },
    //       ),
    //       Positioned(
    //         top: 16,
    //         left: 16,
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Container(
    //               decoration: BoxDecoration(
    //                 color: Colors.black38,
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //               child: IconButton(
    //                 icon: Icon(
    //                   FontAwesomeIcons.lifeRing,
    //                   size: 20,
    //                   color:
    //                       _isShowBasarnas ? Colors.blue.shade300 : Colors.white,
    //                 ),
    //                 onPressed: () {
    //                   setState(() {
    //                     _isShowBasarnas = !_isShowBasarnas;
    //                   });
    //                 },
    //               ),
    //             ),
    //             SizedBox(height: 2),
    //             Container(
    //               decoration: BoxDecoration(
    //                 color: Colors.black38,
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //               child: IconButton(
    //                 icon: Icon(
    //                   FontAwesomeIcons.towerObservation,
    //                   size: 20,
    //                   color: _isShowPortPelabuhan
    //                       ? Colors.blue.shade300
    //                       : Colors.white,
    //                 ),
    //                 onPressed: () {
    //                   setState(() {
    //                     _isShowPortPelabuhan = !_isShowPortPelabuhan;
    //                   });
    //                 },
    //               ),
    //             ),
    //             SizedBox(height: 2),
    //             Container(
    //               decoration: BoxDecoration(
    //                 color: Colors.black38,
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //               child: IconButton(
    //                 icon: Icon(
    //                   FontAwesomeIcons.mapLocationDot,
    //                   size: 20,
    //                   color: _isShowWpp ? Colors.blue.shade300 : Colors.white,
    //                 ),
    //                 onPressed: () {
    //                   setState(() {
    //                     _isShowWpp = !_isShowWpp;
    //                   });
    //                 },
    //               ),
    //             ),
    //             SizedBox(height: 2),
    //             Container(
    //               decoration: BoxDecoration(
    //                 color: Colors.black38,
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //               child: IconButton(
    //                 icon: Icon(
    //                   FontAwesomeIcons.ship,
    //                   size: 20,
    //                   color: _isShowNamaKapal
    //                       ? Colors.blue.shade300
    //                       : Colors.white,
    //                 ),
    //                 onPressed: () {
    //                   setState(() {
    //                     _isShowNamaKapal = !_isShowNamaKapal;
    //                   });
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SelectedBasarnasInfo(
    //         selectedBasarnas: _selectedBasarnas,
    //         onClose: () {
    //           setState(() {
    //             _selectedBasarnas = null;
    //           });
    //         },
    //       ),
    //       SelectedPelabuhanInfo(
    //         selectedPortPelabuhan: _selectedPortPelabuhan,
    //         portRi: portRi,
    //         onClose: () {
    //           setState(() {
    //             _selectedPortPelabuhan = null;
    //           });
    //         },
    //       ),
    //       _isLoading ? LoadingMap() : Container(),
    //     ],
    //   ),
    //   bottomNavigationBar: Visibility(
    //     visible: _selectedKapal != null,
    //     child: BottomNavigationBar(
    //       type: BottomNavigationBarType.fixed,
    //       items: const <BottomNavigationBarItem>[
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.directions_boat),
    //           label: 'Vessel',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.location_searching),
    //           label: 'Traking',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.timer),
    //           label: 'Airtime',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.close),
    //           label: 'Close',
    //         ),
    //       ],
    //       selectedItemColor: Colors.black,
    //       unselectedItemColor: Colors.black,
    //       onTap: (index) async {
    //         if (index == 3) {
    //           setState(() {
    //             _selectedKapal = null;
    //           });
    //         } else if (index == 1) {
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
    //                   mobileId: _selectedKapal!['id'],
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
    //                 maxWidth: MediaQuery.of(context).size.width,
    //                 maxHeight: MediaQuery.of(context).size.height / 2),
    //           );
    //         } else {
    //           showModalBottomSheet(
    //             context: context,
    //             isScrollControlled: true,
    //             builder: (context) {
    //               return index == 0
    //                   ? VesselDataGeosatModal(kapalGeosat: _selectedKapal!)
    //                   : AirtimeDataModal(
    //                       future: vesselService
    //                           .getAirtimeKapal(_selectedKapal!['idfull'] ?? ''));
    //             },
    //             constraints: BoxConstraints(
    //                 maxWidth: MediaQuery.of(context).size.width,
    //                 maxHeight: MediaQuery.of(context).size.height / 3),
    //           );
    //         }
    //       },
    //     ),
    //   ),
    // );
  }
}
