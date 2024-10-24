// ignore_for_file: library_private_types_in_public_api, unnecessary_string_interpolations, use_build_context_synchronously, avoid_print, prefer_const_constructors, prefer_final_fields, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/loading_map.dart';
import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:geotraking/core/components/selected_pelabuhan_info.dart';
import 'package:geotraking/core/models/port_ri.dart';
import 'package:geotraking/core/models/port_ri_detail.dart';
import 'package:geotraking/core/services/port_ri_service.dart';
import 'package:latlong2/latlong.dart';

class PortRiPage extends StatefulWidget {
  const PortRiPage({super.key});

  @override
  _PortRiPageState createState() => _PortRiPageState();
}

class _PortRiPageState extends State<PortRiPage> {
  final MapController mapController = MapController();
  final PortPelabuhanService portPelabuhanService = PortPelabuhanService();

  String _selectedMapProvider = 'OpenStreetMap';
  PortPelabuhan? _selectedPortPelabuhan;
  PortRi? portRi;
  List<PortPelabuhan> _portPelabuhanList = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPortPelabuhanData();
  }

  Future<void> _loadPortPelabuhanData() async {
    setState(() {
      _isLoading = true;
    });

    PortPelabuhanService portPelabuhanService = PortPelabuhanService();
    List<PortPelabuhan> portPelabuhanList =
        await portPelabuhanService.getCachedData();

    setState(() {
      _portPelabuhanList = portPelabuhanList;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Port Pelabuhan Republik Indonesia'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        centerTitle: true,
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
              MarkerLayer(
                markers: _portPelabuhanList.map((portPelabuhan) {
                  return Marker(
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.towerObservation,
                        color: Colors.black45,
                        size: 14,
                      ),
                      onPressed: () async {
                        _selectedPortPelabuhan = portPelabuhan;
                        portRi = await portPelabuhanService
                            .getDetailDataPortPelabuhan(
                                portPelabuhan.kodePelabuhan);
                        setState(() {});
                      },
                    ),
                    point: LatLng(portPelabuhan.lat, portPelabuhan.lon),
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
    );
  }
}
