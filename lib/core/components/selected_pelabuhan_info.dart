import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/models/port_ri.dart';
import 'package:geotraking/core/models/port_ri_detail.dart';

class SelectedPelabuhanInfo extends StatelessWidget {
  final PortRi? portRi;
  final PortPelabuhan? selectedPortPelabuhan;
  final VoidCallback onClose;

  const SelectedPelabuhanInfo({
    Key? key,
    required this.selectedPortPelabuhan,
    required this.portRi,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedPortPelabuhan == null) return Container();

    return Positioned(
      bottom: 10,
      left: 10,
      child: Stack(
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
                        'Nama Pelabuhan: ${selectedPortPelabuhan?.namaPelabuhan}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Kode Pelabuhan: ${selectedPortPelabuhan?.kodePelabuhan}',
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
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Lokasi: ${portRi?.lokasiPelabuhan}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Alamat Kantor: ${portRi?.alamatKantor}',
                                  style: const TextStyle(color: Colors.black),
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
                        'Latitude: ${selectedPortPelabuhan?.lat}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Longitude: ${selectedPortPelabuhan?.lon}',
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
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );
  }
}
