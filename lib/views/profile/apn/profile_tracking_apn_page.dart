// ignore_for_file: prefer_final_fields, prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unnecessary_string_interpolations, unused_local_variable, unused_field, avoid_print, prefer_const_literals_to_create_immutables
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/loading_map.dart';
import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:geotraking/core/components/marker_image_widget.dart';
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
import 'package:geotraking/views/profile/apn/components/vessel_data_modal.dart';
import 'package:latlong2/latlong.dart';

class ProfileTrackingAPNPage extends StatefulWidget {
  const ProfileTrackingAPNPage({super.key});

  @override
  _ProfileTrackingAPNPageState createState() => _ProfileTrackingAPNPageState();
}

class _ProfileTrackingAPNPageState extends State<ProfileTrackingAPNPage> {
  final WppRiService _wppRiService = WppRiService();
  final PortPelabuhanService _portPelabuhanService = PortPelabuhanService();
  final BasarnasService _basarnasService = BasarnasService();
  final VesselService vesselService = VesselService();
  final MapController mapController = MapController();

  List<Basarnas> _basarnasList = [];
  List<PortPelabuhan> _portPelabuhanList = [];
  List<dynamic> _kapalAPNList = [];

  List<WppRi> wppList = [];
  List<dynamic> zoneWpp = [];
  List<Polygon> _polygons = [];

  List<Polyline> _polylines = [];
  List<Polyline> _polylinesPortPelabuhan = [];
  List<LatLng> _points = [];

  bool _isShowBasarnas = false;
  bool _isShowPortPelabuhan = false;
  bool _isShowMyKapal = false;
  bool _isShowWpp = false;
  bool _isLoading = true;

  PortRi? portRi;
  Basarnas? _selectedBasarnas;
  PortPelabuhan? _selectedPortPelabuhan;
  dynamic _selectedkapalAPN;

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

      final basarnasData = await _basarnasService.getDataBasarnas();
      final portPelabuhanData =
          await _portPelabuhanService.getDataPortPelabuhan();
      final kapalAPNData = await vesselService.getDataKapalAPN();

      setState(() {
        _basarnasList = basarnasData;
        _portPelabuhanList = portPelabuhanData;
        _kapalAPNList = kapalAPNData!;
        _polygons = _polygons;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        title: const Text('Track Kapal-Ku (APN)'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        leading: const AppBackButton(),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(-3.858333, 122.508333),
              initialZoom: 10,
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
              PolygonLayer<Object>(polygons: _isShowWpp ? _polygons : []),
              PolygonLayer(
                polygons: [
                  Polygon(
                    points: [
                      LatLng(-3.858333, 122.508333),
                      LatLng(-3.858333, 122.533333),
                      LatLng(-3.791667, 122.533333),
                      LatLng(-3.791667, 122.45),
                    ],
                    color: const Color.fromARGB(135, 68, 137, 255),
                    isFilled: true,
                    // isDotted: true,
                    borderColor: Colors.black45,
                    borderStrokeWidth: 2,
                  ),
                ],
              ),
              MarkerLayer(
                markers: _isShowBasarnas
                    ? _basarnasList.map((basarnas) {
                        return Marker(
                          child: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.lifeRing,
                              color: Colors.redAccent,
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
                              color: Colors.brown.shade400,
                              size: 14,
                            ),
                            onPressed: () async {
                              _selectedPortPelabuhan = portPelabuhan;
                              portRi = await _portPelabuhanService
                                  // .fetchDetailPelabuhan(
                                  //     portPelabuhan.kodePelabuhan);
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
                markers: _kapalAPNList.map((kapalAPN) {
                  bool isSelected = _selectedkapalAPN == kapalAPN;
                  return Marker(
                    width: 30,
                    height: 30,
                    point: LatLng(
                      double.parse(kapalAPN['latitude']),
                      double.parse(kapalAPN['longitude']),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedkapalAPN = kapalAPN;
                        });
                      },
                      child: Stack(
                        children: [
                          MarkerImageWidget(
                              timestamp: kapalAPN['timestamp'].toString(),
                              heading: kapalAPN['heading']),
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
                      // show && hidden basarnas
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
                      // show && hidden port ri
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
                      // show && hidden zona wpp
                      setState(() {
                        _isShowWpp = !_isShowWpp;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          _isLoading ? LoadingMap() : Container(),
          Positioned(
            bottom: 10,
            left: 10,
            child: _selectedBasarnas != null
                ? Stack(
                    children: [
                      FadeInLeft(
                        duration: Duration(milliseconds: 1300),
                        child: Container(
                          width: 300,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Nama Basarnas: ${_selectedBasarnas?.namaBasarnas}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Tipe Basarnas: ${_selectedBasarnas?.tipe}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Latitude: ${_selectedBasarnas?.lat}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Longitude: ${_selectedBasarnas?.lon}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _selectedBasarnas = null;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: _selectedPortPelabuhan != null
                ? Stack(
                    children: [
                      FadeInLeft(
                        duration: Duration(milliseconds: 1300),
                        child: Container(
                          width: 300,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Nama Pelabuhan: ${_selectedPortPelabuhan?.namaPelabuhan}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Kode Pelabuhan: ${_selectedPortPelabuhan?.kodePelabuhan}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                portRi != null
                                    ? Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Unit Kerja: ${portRi?.unitKerja}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Lokasi: ${portRi?.lokasiPelabuhan}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Alamat Kantor: ${portRi?.alamatKantor}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Latitude: ${_selectedPortPelabuhan?.lat}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Longitude: ${_selectedPortPelabuhan?.lon}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _selectedPortPelabuhan = null;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: _selectedkapalAPN != null,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_boat),
              label: 'Vessel',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.close),
              label: 'Close',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          onTap: (index) async {
            if (index == 1) {
              setState(() {
                _selectedkapalAPN = null;
              });
            } else {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return VesselDataModal(kapalAPN: _selectedkapalAPN);
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
