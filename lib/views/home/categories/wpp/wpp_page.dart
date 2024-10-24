// ignore_for_file: prefer_final_fields, prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unnecessary_string_interpolations, unused_local_variable, sized_box_for_whitespace, deprecated_member_use
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/loading_map.dart';
import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/models/wpp.dart';
import 'package:geotraking/core/models/wpp_latlon.dart';
import 'package:geotraking/core/services/wpp_service.dart';
import 'package:geotraking/views/home/categories/wpp/components/detail_button.dart';
import 'package:latlong2/latlong.dart';

class WppPage extends StatefulWidget {
  const WppPage({super.key});

  @override
  _WppPageState createState() => _WppPageState();
}

class _WppPageState extends State<WppPage> {
  final WppRiService _wppRiService = WppRiService();
  final MapController mapController = MapController();
  WppRi? selectedWpp;
  int selectedWppId = 0;
  List<WppRi> wppList = [];
  List<dynamic> zoneWpp = [];
  List<Polygon> _polygons = [];
  List<LatLng> _points = [];

  bool _isLoading = true;
  bool _showDetail = false;
  bool _showAllZones = true;

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
    _showAllZones = true;
    _loadCachedData();
  }

  Future<void> _loadCachedData() async {
    var cachedData = await _wppRiService.loadCachedData();
    setState(() {
      wppList = cachedData['wppList'];
      if (wppList.isNotEmpty) {
        selectedWppId = wppList.first.id!;
        selectedWpp = wppList.first;
      }

      List<WppLatLong?> allZoneWpp = cachedData['zoneWpp'];
      List<dynamic> decodedJson = jsonDecode(jsonEncode(allZoneWpp));

      _polygons = _createPolygonsFromData(decodedJson);
      _isLoading = false;
      _showAllZones = true;
    });
  }

  List<Polygon> _createPolygonsFromData(List<dynamic> data) {
    final pointsByWppId = <int, List<LatLng>>{};
    for (var item in data) {
      final zone = WppLatLong.fromJson(item);
      if (!pointsByWppId.containsKey(zone.wppId)) {
        pointsByWppId[zone.wppId!] = [];
      }
      pointsByWppId[zone.wppId]!.add(LatLng(zone.lat, zone.lon));
    }

    return pointsByWppId.entries
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
  }

  Future<void> _showMarkerPolygon() async {
    if (selectedWpp == null) return;

    final selectedWppData = await _wppRiService.getDetailDataWpp(selectedWppId);
    setState(() {
      _points =
          selectedWppData.map((item) => LatLng(item.lat, item.lon)).toList();
      _showAllZones = false;
      _showDetail = true;
      _isLoading = false;
    });
  }

  Future<void> _showDetailWpp(BuildContext context) async {
    setState(() {
      _showDetail = true;
    });

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 180, top: 5, right: 180),
                    child: Divider(
                      color: Colors.black54,
                      thickness: 3,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Nama Zona:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              )),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${selectedWpp!.namaWpp}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Colors.black,
                                              )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(thickness: 0.5, color: Colors.black),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Keterangan :',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              )),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('${selectedWpp!.keterangan}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Colors.black,
                                              )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showDetailLatLong(BuildContext context) async {
    if (selectedWppId == 0) return;
    List<WppLatLong> zoneWppList =
        await _wppRiService.getDetailDataWpp(selectedWppId);

    setState(() {
      _showDetail = true;
    });

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 180, top: 5, right: 180),
                  child: Divider(
                    color: Colors.black54,
                    thickness: 3,
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    // color: Colors.grey[100],
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Latitude :',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Longtitude :',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 0.5, color: Colors.black),
                          Expanded(
                            child: ListView.builder(
                              itemCount: zoneWppList.length,
                              itemBuilder: (context, index) {
                                WppLatLong? zoneWpp = zoneWppList[index];
                                return ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('${zoneWpp.lat}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                color: Colors.black,
                                              )),
                                      Spacer(),
                                      Text('${zoneWpp.lon}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                color: Colors.black,
                                              )),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wilayah Pengelolaan Perikanan'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        centerTitle: true,
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
              PolygonLayer(
                polygons: _showAllZones
                    ? _polygons
                    : [
                        Polygon(
                          points: _points,
                          color: Colors.blueAccent.withOpacity(0.3),
                          isFilled: true,
                          // isDotted: true,
                          borderColor: Colors.black45,
                          borderStrokeWidth: 2,
                        ),
                      ],
              ),
              MarkerLayer(
                markers: _points.map((point) {
                  return Marker(
                    child: Icon(
                      Icons.circle,
                      color: Colors.black54,
                      size: 5,
                    ),
                    point: point,
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: PopupMenuButton<WppRi>(
                        icon: Icon(
                          FontAwesomeIcons.mapLocationDot,
                          color: Colors.white,
                        ),
                        onSelected: (WppRi newValue) async {
                          setState(() {
                            selectedWpp = newValue;
                            selectedWppId = newValue.id!;
                          });
                          await _showMarkerPolygon();
                        },
                        itemBuilder: (context) => wppList.map((WppRi value) {
                          return PopupMenuItem<WppRi>(
                            value: value,
                            child: Text(
                              value.namaWpp,
                              textAlign: TextAlign.start,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(width: 5),
                    if (selectedWpp != null)
                      Opacity(
                        opacity: _showDetail ? 1 : 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            selectedWpp!.namaWpp,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          _isLoading ? LoadingMap() : Container(),
          _showDetail
              ? Positioned(
                  right: 10,
                  left: 10,
                  bottom: 10,
                  child: Container(
                    width: 300,
                    height: 100,
                    child: DetailButtonWpp(
                      onSeeDetailWpp: () async {
                        _showDetailWpp(context);
                        setState(() {
                          _showDetail = true;
                        });
                      },
                      onSeeDetailLatLong: () async {
                        _showDetailLatLong(context);
                        setState(() {
                          _showDetail = true;
                        });
                      },
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
