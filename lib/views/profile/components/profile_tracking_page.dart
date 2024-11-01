// ignore_for_file: prefer_final_fields, prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unnecessary_string_interpolations, unused_local_variable, unused_field, avoid_print, prefer_const_literals_to_create_immutables, deprecated_member_use
import 'dart:math';
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
import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/core/models/basarnas.dart';
// import 'package:geotraking/core/models/kapal_member.dart';
import 'package:geotraking/core/models/port_ri.dart';
import 'package:geotraking/core/models/port_ri_detail.dart';
import 'package:geotraking/core/models/wpp_latlon.dart';
import 'package:geotraking/core/services/basarnas_service.dart';
// import 'package:geotraking/core/services/kapal_member_service.dart';
import 'package:geotraking/core/services/port_ri_service.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/core/services/wpp_service.dart';
import 'package:geotraking/views/profile/components/modal/airtime/airtime_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/traking/traking_data_modal.dart';
import 'package:geotraking/views/profile/components/modal/vessel/vessel_data_modal.dart';
import 'package:info_popup/info_popup.dart';
// import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timeago/timeago.dart' as timeago;

class ProfileTrackingPage extends StatefulWidget {
  const ProfileTrackingPage({super.key});

  @override
  _ProfileTrackingPageState createState() => _ProfileTrackingPageState();
}

class _ProfileTrackingPageState extends State<ProfileTrackingPage> {
  final WppRiService _wppRiService = WppRiService();
  final PortPelabuhanService _portPelabuhanService = PortPelabuhanService();
  final BasarnasService _basarnasService = BasarnasService();
  final VesselService vesselService = VesselService();
  final MapController mapController = MapController();

  List<Basarnas> _basarnasList = [];
  List<PortPelabuhan> _portPelabuhanList = [];
  List<Map<String, dynamic>> _kapalMemberList = [];

  PortRi? portRi;
  Basarnas? _selectedBasarnas;
  Map<String, dynamic>? _selectedKapalMember;
  PortPelabuhan? _selectedPortPelabuhan;

  List<Polygon> _polygons = [];
  List<Polyline> _polylinesBasarnas = [];
  List<Polyline> _polylinesPortPelabuhan = [];
  List<LatLng> _points = [];
  List<LatLng> _polylineHistoryTraking = [];

  bool _isShowBasarnas = false;
  bool _isShowPortPelabuhan = false;
  bool _isShowMyKapal = false;
  bool _isShowWpp = false;
  bool _isShowNamaKapal = false;
  bool _isShowTrakingKapal = false;
  bool _isLoading = true;

  bool _isSidebarVisible = false;
  String _searchQuery = '';
  double _currentZoom = 15;

  final ScrollController _scrollController = ScrollController();

  String _selectedLanguage = 'English';

  List<LatLng> _polylinePointsTraking = [];
  List<Marker> _markersTraking = [];

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
      return _kapalMemberList;
    }
    return _kapalMemberList
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
        double zoomLevel = 15;
        mapController.move(newLatLng, zoomLevel);
        setState(() {
          _currentZoom = zoomLevel;
        });
      });
    }
  }

  void _onTrackVessel(List<LatLng> polylinePoints, List<Marker> markers,
      List<double> headings) {
    setState(() {
      _polylinePointsTraking = polylinePoints;
      _markersTraking = markers;
    });
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

  // String _formatLatitude(double? lat) {
  //   if (lat == null) return '';
  //   int degrees = lat.toInt();
  //   double minutes = (lat - degrees) * 60;
  //   int minutesInt = minutes.toInt();
  //   double seconds = (minutes - minutesInt) * 60;
  //   return '${degrees.abs()} ${degrees < 0 ? 'S' : 'N'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
  // }

  // String _formatLongitude(double? lon) {
  //   if (lon == null) return '';
  //   int degrees = lon.toInt();
  //   double minutes = (lon - degrees) * 60;
  //   int minutesInt = minutes.toInt();
  //   double seconds = (minutes - minutesInt) * 60;
  //   return '${degrees.abs()} ${degrees < 0 ? 'W' : 'E'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
  // }

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
      final kapalMemberData = await vesselService.getDataKapal();

      _calculateDistancesAndCreatePolylines(
        basarnasData,
        portPelabuhanData,
        kapalMemberData!,
      );

      setState(() {
        _basarnasList = basarnasData;
        _portPelabuhanList = portPelabuhanData;
        _kapalMemberList = kapalMemberData;
        _polygons = _polygons;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  double _calculateDistance(LatLng point1, LatLng point2) {
    const int radius = 6371; // radius bumi di km
    double lat1 = point1.latitude * (pi / 180);
    double lat2 = point2.latitude * (pi / 180);
    double lon1 = point1.longitude * (pi / 180);
    double lon2 = point2.longitude * (pi / 180);
    double dLat = (lat2 - lat1);
    double dLon = (lon2 - lon1);
    double a =
        pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = radius * c;
    return distance;
  }

  void _calculateDistancesAndCreatePolylines(
      List<Basarnas> basarnasList,
      List<PortPelabuhan> portPelabuhanList,
      List<Map<String, dynamic>> kapalMemberList) {
    _polylinesBasarnas.clear();

    for (var kapalMember in kapalMemberList) {
      double nearestBasarnasDistance = double.infinity;
      double nearestPortPelabuhanDistance = double.infinity;
      PortPelabuhan? nearestPortPelabuhan;
      Basarnas? nearestBasarnas;

      for (var basarnas in basarnasList) {
        double distance = _calculateDistance(
          LatLng(double.parse(kapalMember['lat']),
              double.parse(kapalMember['lon'])),
          LatLng(basarnas.lat, basarnas.lon),
        );

        if (distance < nearestBasarnasDistance) {
          nearestBasarnasDistance = distance;
          nearestBasarnas = basarnas;
        }
      }

      for (var portPelabuhan in portPelabuhanList) {
        double distance = _calculateDistance(
          LatLng(double.parse(kapalMember['lat']),
              double.parse(kapalMember['lon'])),
          LatLng(portPelabuhan.lat, portPelabuhan.lon),
        );

        if (distance < nearestPortPelabuhanDistance) {
          nearestPortPelabuhanDistance = distance;
          nearestPortPelabuhan = portPelabuhan;
        }
      }

      List<LatLng> points = [
        LatLng(
            double.parse(kapalMember['lat']), double.parse(kapalMember['lon'])),
        LatLng(nearestBasarnas!.lat, nearestBasarnas.lon),
      ];

      List<LatLng> pointsPortPelabuhan = [
        LatLng(
            double.parse(kapalMember['lat']), double.parse(kapalMember['lon'])),
        LatLng(nearestPortPelabuhan!.lat, nearestPortPelabuhan.lon),
      ];

      _polylinesBasarnas.add(Polyline(
        points: points,
        color: Colors.blueAccent,
        strokeWidth: 2,
      ));

      _polylinesPortPelabuhan.add(Polyline(
        points: pointsPortPelabuhan,
        color: Colors.orangeAccent,
        strokeWidth: 2,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldWithBoxBackground,
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
              options: const MapOptions(
                initialCenter: LatLng(-4.4511412299261, 111.082877130109),
                initialZoom: 4,
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
                PolylineLayer<Object>(
                  polylines: _isShowBasarnas ? _polylinesBasarnas : [],
                ),
                PolylineLayer<Object>(
                  polylines:
                      _isShowPortPelabuhan ? _polylinesPortPelabuhan : [],
                ),
                PolygonLayer<Object>(
                  polygons: _isShowWpp ? _polygons : [],
                ),
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
                MarkerLayer(
                  markers: _kapalMemberList.map((kapalMember) {
                    bool isSelected = _selectedKapalMember == kapalMember;
                    return Marker(
                      width: 30,
                      height: 30,
                      point: LatLng(double.parse(kapalMember['lat']),
                          double.parse(kapalMember['lon'])),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedKapalMember = kapalMember;
                          });
                        },
                        // child: InfoPopupWidget(
                        //   child: Stack(
                        //     children: [
                        //       MarkerImageWidget(
                        //         timestamp: kapalMember['timestamp'],
                        //         heading: kapalMember['heading'],
                        //       ),
                        //       if (isSelected)
                        //         Positioned(
                        //           left: 0,
                        //           right: 0,
                        //           top: 0,
                        //           bottom: 0,
                        //           child: Container(
                        //             decoration: BoxDecoration(
                        //               border: Border.all(
                        //                   color: Colors.red, width: 2),
                        //               borderRadius: BorderRadius.circular(15),
                        //             ),
                        //           ),
                        //         ),
                        //     ],
                        //   ),
                        //   customContent: () => Container(
                        //     padding: EdgeInsets.all(8),
                        //     width: 290,
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: DefaultTabController(
                        //       length: 4, // Number of tabs
                        //       child: Column(
                        //         children: [
                        //           TabBar(
                        //             tabs: [
                        //               Tab(text: 'Vessel'),
                        //               Tab(text: 'Tracking'),
                        //               Tab(text: 'Airtime'),
                        //               Tab(text: 'Close'),
                        //             ],
                        //           ),
                        //           Expanded(
                        //             child: TabBarView(
                        //               children: [
                        //                 // Content for Tracking tab
                        //                 Center(
                        //                   child: Text('Tracking Information'),
                        //                 ),

                        //                 // Content for Airtime tab
                        //                 Center(
                        //                   child: Text('Airtime Information'),
                        //                 ),

                        //                 // Content for Close tab
                        //                 Center(
                        //                   child: Text('Close the popup'),
                        //                 ),
                        //                 Center(
                        //                   child: Text('Close the popup'),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        child: Stack(
                          children: [
                            MarkerImageWidget(
                              timestamp: kapalMember['timestamp'],
                              heading: kapalMember['heading'],
                            ),
                            if (isSelected)
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.red, width: 2),
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
                if (_isShowNamaKapal)
                  MarkerLayer(
                    markers: _kapalMemberList.map((kapalMember) {
                      bool isSelected = _selectedKapalMember == kapalMember;
                      return Marker(
                        width: 120,
                        height: 23,
                        point: LatLng(
                          double.parse(kapalMember['lat']),
                          double.parse(kapalMember['lon']),
                        ),
                        child: Transform.translate(
                          offset: Offset(0, -25),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                kapalMember['nama_kapal'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
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
                        Icons.directions_boat_filled_rounded,
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
            if (_selectedKapalMember != null)
              Positioned(
                top: 216,
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
                          Icons.location_history_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return VesselDataModal(
                                  vesselData: _selectedKapalMember!);
                            },
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight:
                                    MediaQuery.of(context).size.height / 3),
                          );
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
                          Icons.location_searching,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
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
                                  mobileId: _selectedKapalMember!['mobile_id'],
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
                                maxHeight:
                                    MediaQuery.of(context).size.height / 2),
                          );
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
                          Icons.timer,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return AirtimeDataModal(
                                  future: vesselService.getAirtimeKapal(
                                      _selectedKapalMember!['idfull'] ?? ''));
                            },
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight:
                                    MediaQuery.of(context).size.height / 3),
                          );
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
                          Icons.close,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedKapalMember = null;
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
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
                              ? 'Vessel: ${_kapalMemberList.length}'
                              : _filteredVesselList.isEmpty
                                  ? 'Not found.'
                                  : 'Vessel found: ${_filteredVesselList.length}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: _kapalMemberList.length,
                          itemBuilder: (context, index) {
                            final vessel = _kapalMemberList[index];
                            final isSelected = _selectedKapalMember != null &&
                                vessel['mobile_id'] ==
                                    _selectedKapalMember!['mobile_id'];

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
                                      _selectedKapalMember = vessel;
                                      _animateMoveTo(LatLng(
                                        double.parse(vessel['lat']),
                                        double.parse(vessel['lon']),
                                      ));
                                    });
                                    _toggleSidebar();
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: cardVesselColor(
                                                  vessel['timestamp']),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40)),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Text(
                                              vessel['mobile_id'],
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
                                          DateTime.parse(vessel['timestamp']),
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
      ),
    );
    // return Scaffold(
    //   backgroundColor: AppColors.scaffoldWithBoxBackground,
    //   appBar: AppBar(
    //     title: Text(Localization.getTrackKapalKu(_selectedLanguage)),
    //     titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
    //           color: Colors.black,
    //         ),
    //     leading: const AppBackButton(),
    //     actions: [
    //       IconButton(
    //         icon: Icon(
    //           _isSidebarVisible ? Icons.cancel : Icons.search,
    //           color: Colors.black,
    //         ),
    //         onPressed: _toggleSidebar,
    //       ),
    //     ],
    //     backgroundColor: Colors.white,
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
    //           // interactiveFlags: InteractiveFlag.pinchZoom |
    //           //     InteractiveFlag.drag |
    //           //     InteractiveFlag.doubleTapZoom,
    //         ),
    //         mapController: mapController,
    //         children: [
    //           TileLayer(
    //             urlTemplate: MapConfig.getUrlTemplate(_selectedMapProvider),
    //             userAgentPackageName: 'com.example.app',
    //           ),
    //           PolylineLayer<Object>(
    //             polylines: _isShowBasarnas ? _polylinesBasarnas : [],
    //           ),
    //           PolylineLayer<Object>(
    //             polylines: _isShowPortPelabuhan ? _polylinesPortPelabuhan : [],
    //           ),
    //           PolygonLayer<Object>(
    //             polygons: _isShowWpp ? _polygons : [],
    //           ),

    //           // PolylineLayer(
    //           //     polylines: _isShowBasarnas ? _polylinesBasarnas : []),
    //           // PolylineLayer(
    //           //     polylines:
    //           //         _isShowPortPelabuhan ? _polylinesPortPelabuhan : []),
    //           // PolygonLayer(polygons: _isShowWpp ? _polygons : []),
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
    //             markers: _kapalMemberList.map((kapalMember) {
    //               bool isSelected = _selectedKapalMember == kapalMember;
    //               return Marker(
    //                 width: 30,
    //                 height: 30,
    //                 point: LatLng(double.parse(kapalMember['lat']),
    //                     double.parse(kapalMember['lon'])),
    //                 child: GestureDetector(
    //                   onTap: () {
    //                     setState(() {
    //                       _selectedKapalMember = kapalMember;
    //                     });
    //                   },
    //                   child: Stack(
    //                     children: [
    //                       MarkerImageWidget(
    //                         timestamp: kapalMember['timestamp'],
    //                         heading: kapalMember['heading'],
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
    //               markers: _kapalMemberList.map((kapalMember) {
    //                 bool isSelected = _selectedKapalMember == kapalMember;
    //                 return Marker(
    //                   width: 120,
    //                   height: 30,
    //                   point: LatLng(double.parse(kapalMember['lat']),
    //                       double.parse(kapalMember['lon'])),
    //                   child: Container(
    //                     padding: const EdgeInsets.all(5),
    //                     decoration: BoxDecoration(
    //                       color: Colors.white.withOpacity(0.3),
    //                       borderRadius: BorderRadius.circular(15),
    //                     ),
    //                     child: Center(
    //                       child: Text(
    //                         kapalMember['nama_kapal'],
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
    //                   // show && hidden basarnas
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
    //                   // show && hidden port ri
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
    //                   // show && hidden zona wpp
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
    //                   // show && hidden zona wpp
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
    //       if (_isSidebarVisible)
    //         Positioned(
    //           right: 0,
    //           top: 0,
    //           bottom: 0,
    //           width: MediaQuery.of(context).size.width * 0.6,
    //           child: AnimatedContainer(
    //             duration: Duration(milliseconds: 300),
    //             color: Colors.white,
    //             child: Column(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(16.0),
    //                   child: TextField(
    //                     decoration: InputDecoration(
    //                       labelText: 'Search Vessel..',
    //                       labelStyle: TextStyle(color: Colors.black),
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(40)),
    //                       ),
    //                       enabledBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(40)),
    //                         borderSide: BorderSide(color: Colors.black),
    //                       ),
    //                       focusedBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(40)),
    //                         borderSide: BorderSide(color: Colors.black),
    //                       ),
    //                     ),
    //                     onChanged: (query) {
    //                       setState(() {
    //                         _searchQuery = query;
    //                         _filteredVesselList;
    //                       });
    //                     },
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Text(
    //                     _searchQuery.isEmpty
    //                         ? 'Vessel: ${_kapalMemberList.length}'
    //                         : _filteredVesselList.isEmpty
    //                             ? 'Not found.'
    //                             : 'Vessel found: ${_filteredVesselList.length}',
    //                     style: TextStyle(fontSize: 16, color: Colors.black),
    //                   ),
    //                 ),
    //                 Expanded(
    //                   child: ListView.builder(
    //                     controller: _scrollController,
    //                     itemCount: _kapalMemberList.length,
    //                     itemBuilder: (context, index) {
    //                       final vessel = _kapalMemberList[index];
    //                       final isSelected = _selectedKapalMember != null &&
    //                           vessel['mobile_id'] ==
    //                               _selectedKapalMember!['mobile_id'];

    //                       if (_searchQuery.isEmpty ||
    //                           vessel['nama_kapal']
    //                               .toLowerCase()
    //                               .contains(_searchQuery.toLowerCase())) {
    //                         return Container(
    //                           margin: EdgeInsets.symmetric(
    //                               vertical: 4, horizontal: 16),
    //                           padding: EdgeInsets.symmetric(
    //                               vertical: 8, horizontal: 12),
    //                           decoration: BoxDecoration(
    //                             color: isSelected
    //                                 ? Colors.blue[100]
    //                                 : Colors.white,
    //                             borderRadius: BorderRadius.circular(8),
    //                             boxShadow: [
    //                               BoxShadow(
    //                                 color: Colors.grey.withOpacity(0.3),
    //                                 spreadRadius: 2,
    //                                 blurRadius: 5,
    //                                 offset: Offset(0, 2),
    //                               ),
    //                             ],
    //                           ),
    //                           child: InkWell(
    //                             onTap: () {
    //                               setState(() {
    //                                 _selectedKapalMember = vessel;
    //                                 _animateMoveTo(LatLng(
    //                                   double.parse(vessel['lat']),
    //                                   double.parse(vessel['lon']),
    //                                 ));
    //                               });
    //                               _toggleSidebar();
    //                             },
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Row(
    //                                   children: [
    //                                     Container(
    //                                       decoration: BoxDecoration(
    //                                         color: cardVesselColor(
    //                                             vessel['timestamp']),
    //                                         borderRadius: BorderRadius.all(
    //                                             Radius.circular(40)),
    //                                       ),
    //                                       padding: const EdgeInsets.symmetric(
    //                                           horizontal: 8, vertical: 4),
    //                                       child: Text(
    //                                         vessel['mobile_id'],
    //                                         style: TextStyle(
    //                                             fontSize: 10,
    //                                             color: Colors.black,
    //                                             fontWeight: FontWeight.bold),
    //                                       ),
    //                                     ),
    //                                     SizedBox(width: 8),
    //                                     Expanded(
    //                                       child: Text(
    //                                         vessel['nama_kapal'],
    //                                         style: TextStyle(
    //                                             fontSize: 13,
    //                                             color: Colors.black),
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 SizedBox(height: 4),
    //                                 Text(
    //                                   timeago.format(
    //                                     DateTime.parse(vessel['timestamp']),
    //                                   ),
    //                                   style: TextStyle(
    //                                       fontSize: 12, color: Colors.grey),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         );
    //                       } else {
    //                         return Container();
    //                       }
    //                     },
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //     ],
    //   ),
    //   bottomNavigationBar: Visibility(
    //     visible: _selectedKapalMember != null,
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
    //           // Close button
    //           setState(() {
    //             _selectedKapalMember = null;
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
    //                   mobileId: _selectedKapalMember!['mobile_id'],
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
    //                   ? VesselDataModal(vesselData: _selectedKapalMember!)
    //                   : AirtimeDataModal(
    //                       future: vesselService.getAirtimeKapal(
    //                           _selectedKapalMember!['idfull'] ?? ''));
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
