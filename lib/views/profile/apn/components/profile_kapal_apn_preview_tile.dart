// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geotraking/core/components/marker_image_widget.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import 'package:timeago/timeago.dart' as timeago;

class ProfileKapalAPNPreviewTile extends StatefulWidget {
  const ProfileKapalAPNPreviewTile({
    Key? key,
    required this.idfull,
    required this.mobileId,
    this.namaKapal,
    this.kategori,
    this.sn,
    this.imei,
    this.legalName,
    this.powerStatus,
    this.externalVoltage,
    this.type,
    this.flag,
    this.lat,
    this.lon,
    this.eta,
    this.speed,
    this.heading,
    this.distance,
    this.timestamp,
  }) : super(key: key);

  final String idfull;
  final String mobileId;
  final String? namaKapal;
  final String? kategori;
  final String? sn;
  final String? imei;
  final String? legalName;
  final String? powerStatus;
  final String? externalVoltage;
  final String? type;
  final String? flag;
  final String? lat;
  final String? lon;
  final String? eta;
  final String? speed;
  final String? heading;
  final String? distance;
  final String? timestamp;

  @override
  _ProfileKapalAPNPreviewTileState createState() =>
      _ProfileKapalAPNPreviewTileState();
}

class _ProfileKapalAPNPreviewTileState
    extends State<ProfileKapalAPNPreviewTile> {
  bool _isExpanded = false;

  String _formatLatitude(double? lat) {
    if (lat == null) return '';
    try {
      int degrees = lat.toInt();
      double minutes = (lat - degrees) * 60;
      int minutesInt = minutes.toInt();
      double seconds = (minutes - minutesInt) * 60;
      return '${degrees.abs()} ${degrees < 0 ? 'S' : 'N'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
    } catch (e) {
      return '';
    }
  }

  String _formatLongitude(double? lon) {
    if (lon == null) return '';
    try {
      int degrees = lon.toInt();
      double minutes = (lon - degrees) * 60;
      int minutesInt = minutes.toInt();
      double seconds = (minutes - minutesInt) * 60;
      return '${degrees.abs()} ${degrees < 0 ? 'W' : 'E'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
    } catch (e) {
      return '';
    }
  }

  Color _getCardColor() {
    final timestamp = DateTime.parse(widget.timestamp!);
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 72) {
      // kurang dari 1 jam 12 menit
      return Color.fromARGB(255, 127, 183, 126);
    } else if (difference.inMinutes < 120) {
      // kurang dari 2 jam
      return Color.fromARGB(255, 241, 235, 144);
    } else if (difference.inDays < 7) {
      // kurang dari 7 hari
      return Color.fromARGB(255, 243, 182, 100);
    } else {
      // lebih dari 7 hari
      return Color.fromARGB(255, 117, 134, 148);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getCardColor(),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${widget.namaKapal ?? '-'}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              timeago.format(DateTime.parse(widget.timestamp!), locale: 'en'),
              style: TextStyle(color: Colors.white60),
            ),
            trailing: IconButton(
              icon:
                  Icon(_isExpanded ? Icons.arrow_upward : Icons.arrow_downward),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: AppDefaults.borderRadius,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID : ${widget.idfull}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MMSI/SN/IMEI :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            '${widget.mobileId}/${widget.sn ?? '-'}/${widget.imei ?? '-'}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Owner :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            '${widget.legalName ?? '-'}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vessel Type :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            '${widget.type ?? '-'}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            '${widget.kategori ?? '-'}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Flag :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            '${widget.flag ?? '-'}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Received Date :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            widget.timestamp != null
                                ? '${DateFormat('dd MMM y (HH:mm:ss)').format(DateTime.parse(widget.timestamp!))}'
                                : '-',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Power Source :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            '${widget.powerStatus ?? '-'}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Power Value :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            '${widget.externalVoltage ?? '-'} kwh',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Heading :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            '${widget.heading ?? '-'} °',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Speed :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            '${widget.speed ?? '-'} knot',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Latitude :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            _formatLatitude(double.parse(widget.lat ?? '0')),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Longitude :',
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            _formatLongitude(double.parse(widget.lon ?? '0')),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.white,
                  ), 
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Container(
                                height: 150,
                                child: FlutterMap(
                                  options: MapOptions(
                                    initialCenter: LatLng(
                                      double.parse(widget.lat!),
                                      double.parse(widget.lon!),
                                    ),
                                    initialZoom: 4,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.example.app',
                                    ),
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          point: LatLng(
                                            double.parse(widget.lat!),
                                            double.parse(widget.lon!),
                                          ),
                                          width: 30,
                                          height: 30,
                                          child: MarkerImageWidget(
                                              timestamp: widget.timestamp,
                                              heading: widget.heading),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
