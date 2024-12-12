// ignore_for_file: prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geotraking/core/components/map_config.dart';

class MapTool extends StatefulWidget {
  final MapController mapController;
  final String selectedMapProvider;
  final ValueChanged<String> onMapProviderChanged;

  const MapTool({
    super.key,
    required this.mapController,
    required this.selectedMapProvider,
    required this.onMapProviderChanged,
  });

  @override
  _MapToolState createState() => _MapToolState();
}

class _MapToolState extends State<MapTool> {
  bool _isSidebarVisible = false;

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 16,
          right: _isSidebarVisible ? 0 : -MediaQuery.of(context).size.width / 2,
          bottom: MediaQuery.of(context).size.height / 2,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Sidebar(
              onClose: _toggleSidebar,
              selectedValue: MapConfig.getMapProviders()
                  .indexOf(widget.selectedMapProvider),
              onValueChanged: (int index) {
                widget.onMapProviderChanged(MapConfig.getMapProviders()[index]);
                _toggleSidebar();
              },
            ),
          ),
        ),
        if (!_isSidebarVisible)
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.zoom_in, color: Colors.white),
                    onPressed: () {
                      widget.mapController.move(
                        widget.mapController.camera.center,
                        widget.mapController.camera.zoom + 0.5,
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
                    icon: const Icon(Icons.zoom_out, color: Colors.white),
                    onPressed: () {
                      if (widget.mapController.camera.zoom > 2) {
                        widget.mapController.move(
                          widget.mapController.camera.center,
                          widget.mapController.camera.zoom - 0.5,
                        );
                      }
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
                    icon: const Icon(Icons.map, color: Colors.white),
                    onPressed: _toggleSidebar,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class Sidebar extends StatelessWidget {
  final VoidCallback onClose;
  final int selectedValue;
  final void Function(int) onValueChanged;

  const Sidebar({
    Key? key,
    required this.onClose,
    required this.selectedValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children:
                List.generate(MapConfig.getMapProviders().length, (index) {
              return ListTile(
                leading: Radio(
                  value: index,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
                    if (value != null) {
                      onValueChanged(value);
                    }
                  },
                ),
                title: Text(
                  MapConfig.getMapProviders()[index],
                  style: TextStyle(color: Colors.black),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
          child: GestureDetector(
            onTap: onClose,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Icon(Icons.close, size: 25, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
