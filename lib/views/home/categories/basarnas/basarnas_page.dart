// ignore_for_file: prefer_final_fields, prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unnecessary_string_interpolations, unused_local_variable, avoid_print, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/loading_map.dart';
import 'package:geotraking/core/components/map_config.dart';
import 'package:geotraking/core/components/map_tool.dart';
import 'package:geotraking/core/components/selected_basarnas_info.dart';
import 'package:geotraking/core/models/basarnas.dart';
import 'package:geotraking/core/services/basarnas_service.dart';
import 'package:latlong2/latlong.dart';

class BasarnasPage extends StatefulWidget {
  const BasarnasPage({super.key});

  @override
  _BasarnasPageState createState() => _BasarnasPageState();
}

class _BasarnasPageState extends State<BasarnasPage> {
  final MapController mapController = MapController();

  bool _isLoading = true;
  String _selectedMapProvider = 'OpenStreetMap';

  List<Basarnas> _basarnasList = [];
  Basarnas? _selectedBasarnas;

  Future<void> _loadBasarnasData() async {
    setState(() {
      _isLoading = true;
    });

    BasarnasService basarnasService = BasarnasService();
    List<Basarnas> basarnasList = await basarnasService.getCachedData();

    setState(() {
      _basarnasList = basarnasList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBasarnasData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Badan Nasional Pencarian dan Pertolongan'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        centerTitle: true,
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
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
                markers: _basarnasList.map((basarnas) {
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
          SelectedBasarnasInfo(
            selectedBasarnas: _selectedBasarnas,
            onClose: () {
              setState(() {
                _selectedBasarnas = null;
              });
            },
          ),
          _isLoading ? LoadingMap() : Container(),
        ],
      ),
    );
  }
}
