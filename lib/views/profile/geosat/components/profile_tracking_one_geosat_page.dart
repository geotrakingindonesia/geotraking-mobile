// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:geotraking/core/components/marker_image_widget.dart';
import 'package:geotraking/core/constants/app_colors.dart';
// import 'package:geotraking/core/services/kapal_geosat_service.dart';
// import 'package:geotraking/core/services/kapal_member_service.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/views/profile/components/airtime_data_modal.dart';
import 'package:geotraking/views/profile/components/traking_data_modal.dart';
import 'package:geotraking/views/profile/geosat/components/vessel_data_geosat_modal.dart';
import 'package:latlong2/latlong.dart';

class ProfileTrackingOneGeosatPage extends StatefulWidget {
  final String idFull;
  final String? mobileId;
  final String? timestamp;
  final String? heading;
  final double lat;
  final double lon;

  ProfileTrackingOneGeosatPage({
    super.key,
    required this.idFull,
    this.mobileId,
    this.timestamp,
    this.heading,
    required this.lat,
    required this.lon,
  });
  @override
  _ProfileTrackingOneGeosatPageState createState() =>
      _ProfileTrackingOneGeosatPageState();
}

class _ProfileTrackingOneGeosatPageState
    extends State<ProfileTrackingOneGeosatPage> {
  final VesselService vesselService = VesselService();
  final MapController mapController = MapController();
  String _selectedLanguage = 'English';

  List<LatLng> _polylinePointsTraking = [];
  List<Marker> _markersTraking = [];
  String _selectedMapProvider = 'OpenStreetMap';

  Map<String, dynamic>? kapalGeosat;

  bool _showAirtimeModal = false;
  bool _showVesselModal = false;
  bool _showTrackingModal = false;

  @override
  void initState() {
    super.initState();
    vesselService.getDataKapalGeosat().then((value) {
      setState(() {
        kapalGeosat =
            value!.firstWhere((geosat) => geosat['id'] == widget.mobileId);
      });
    });
    _showVesselModal = true;
    _fetchAndShowVesselData();
  }

  void _onTrackVessel(List<LatLng> polylinePoints, List<Marker> markers,
      List<double> headings) {
    setState(() {
      _polylinePointsTraking = polylinePoints;
      _markersTraking = markers;
    });
  }

  Future<void> _fetchAndShowVesselData() async {
    final vesselDataList = await vesselService.getDataKapalGeosat();
    final vesselData = vesselDataList!
        .firstWhere((data) => data['id'] == widget.mobileId);

    setState(() {
      kapalGeosat = vesselData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        title: Text(Localization.getTrackKapalKu(_selectedLanguage) +
            ' (${widget.idFull})'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        leading: const AppBackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: LatLng(widget.lat, widget.lon),
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
                        point: LatLng(widget.lat, widget.lon),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15 * 1.2),
                                  backgroundColor: Colors.redAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showVesselModal = !_showVesselModal;
                                    _showAirtimeModal = false;
                                    _showTrackingModal = false;
                                  });
                                  _fetchAndShowVesselData();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  padding: const EdgeInsets.all(15 * 1.2),
                                  backgroundColor: Colors.orangeAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showTrackingModal = !_showTrackingModal;
                                    _showVesselModal = false;
                                    _showAirtimeModal = false;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  padding: const EdgeInsets.all(15 * 1.2),
                                  backgroundColor: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showAirtimeModal = !_showAirtimeModal;
                                    _showTrackingModal = false;
                                    _showVesselModal = false;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              Spacer(),
                            ],
                          ),
                          Divider(thickness: 1, color: Colors.black54),
                          if (_showVesselModal)
                            VesselDataGeosatModal(
                              kapalGeosat: kapalGeosat,
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
                              future:
                                  vesselService.getAirtimeKapal(widget.idFull),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Visibility(
      //   child: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.directions_boat),
      //         label: 'Vessel',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.location_searching),
      //         label: 'Traking',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.timer),
      //         label: 'Airtime',
      //       ),
      //     ],
      //     selectedItemColor: Colors.black,
      //     unselectedItemColor: Colors.black,
      //     onTap: (index) async {
      //       if (index == 1) {
      //         await showModalBottomSheet(
      //           context: context,
      //           isScrollControlled: true,
      //           builder: (context) {
      //             double keyboardHeight =
      //                 MediaQuery.of(context).viewInsets.bottom;
      //             double paddingBottom =
      //                 keyboardHeight > 0 ? keyboardHeight + 10 : 10;
      //             return Padding(
      //               padding: EdgeInsets.only(bottom: paddingBottom),
      //               child: TrakingDataModal(
      //                 mobileId: widget.mobileId ?? '',
      //                 onTrackVessel: _onTrackVessel,
      //                 onClearHistory: () {
      //                   setState(() {
      //                     _polylinePointsTraking.clear();
      //                     _markersTraking.clear();
      //                   });
      //                 },
      //               ),
      //             );
      //           },
      //           constraints: BoxConstraints(
      //             maxWidth: MediaQuery.of(context).size.width,
      //             maxHeight: MediaQuery.of(context).size.height / 2,
      //           ),
      //         );
      //       } else {
      //         showModalBottomSheet(
      //           context: context,
      //           isScrollControlled: true,
      //           builder: (context) {
      //             return index == 0
      //                 ? VesselDataGeosatModal(kapalGeosat: kapalGeosat!)
      //                 : AirtimeDataModal(
      //                     // future: kapalMemberService
      //                     future: vesselService.getAirtimeKapal(widget.idFull));
      //           },
      //           constraints: BoxConstraints(
      //               maxWidth: MediaQuery.of(context).size.width,
      //               maxHeight: MediaQuery.of(context).size.height / 3),
      //         );
      //       }
      //     },
      //   ),
      // ),
    );
  }
}
