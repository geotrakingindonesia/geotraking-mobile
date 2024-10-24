// ignore_for_file: prefer_final_fields, prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unnecessary_string_interpolations, unused_local_variable, unused_field, avoid_print, prefer_const_literals_to_create_immutables, deprecated_member_use
// import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/loading_map.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:geotraking/core/components/marker_image_widget.dart';
import 'package:geotraking/core/components/selected_basarnas_info.dart';
import 'package:geotraking/core/components/selected_pelabuhan_info.dart';
import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/core/models/basarnas.dart';
import 'package:geotraking/core/models/port_ri.dart';
import 'package:geotraking/core/models/port_ri_detail.dart';
import 'package:geotraking/core/models/wpp.dart';
import 'package:geotraking/core/models/wpp_latlon.dart';
import 'package:geotraking/core/services/basarnas_service.dart';
import 'package:geotraking/core/services/port_ri_service.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/core/services/wpp_service.dart';
import 'package:geotraking/views/profile/components/airtime_data_modal.dart';
import 'package:geotraking/views/profile/components/traking_data_modal.dart';
import 'package:geotraking/views/profile/geosat/components/vessel_data_geosat_modal.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      // print(kapalGeosatData);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        title:
            Text(Localization.getTrackKapalKu(_selectedLanguage)),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        leading: const AppBackButton(),
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
              // interactiveFlags: InteractiveFlag.pinchZoom |
              //     InteractiveFlag.drag |
              //     InteractiveFlag.doubleTapZoom,
            ),
            mapController: mapController,
            children: [
              TileLayer(
                urlTemplate: MapConfig.getUrlTemplate(_selectedMapProvider),
                userAgentPackageName: 'com.example.app',
              ),
              // PolygonLayer(polygons: _isShowWpp ? _polygons : []),
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
              // MarkerLayer(
              //   markers: _kapalGeosatList.map((kapalGeosat) {
              //     return Marker(
              //       width: 30,
              //       height: 30,
              //       point: LatLng(double.parse(kapalGeosat['lat']),
              //           double.parse(kapalGeosat['lon'])),
              //       child: GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             kapalGeosat = kapalGeosat;
              //           });
              //         },
              //         child: MarkerImageWidget(
              //           timestamp: kapalGeosat['tgl_aktifasi'],
              //           heading: kapalGeosat['heading'],
              //         ),
              //       ),
              //     );
              //   }).toList(),
              // ),

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
                      color:
                          _isShowBasarnas ? Colors.blue.shade300 : Colors.white,
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
                          future: vesselService
                              .getAirtimeKapal(_selectedKapal!['idfull'] ?? ''));
                },
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height / 3),
              );
            }
          },
        ),
      ),
    );
  }
}
