// // ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_string_interpolations

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';

// import '../../../../core/constants/constants.dart';

// class ProfileKapalGeosatPreviewTile extends StatefulWidget {
//   const ProfileKapalGeosatPreviewTile({
//     Key? key,
//     this.idfull,
//     this.namaKapal,
//     this.kategori,
//     this.type,
//     this.sn,
//     this.imei,
//     this.atpStart,
//     this.atpEnd,
//     this.customer,
//     this.lat,
//     this.lon,
//     this.timestamp,
//   }) : super(key: key);

//   final String? idfull;
//   final String? namaKapal;
//   final String? sn;
//   final String? imei;
//   // final DateTime? atpStart;
//   // final DateTime? atpEnd;
//   final String? atpStart;
//   final String? atpEnd;
//   final String? kategori;
//   final String? type;
//   final String? customer;
//   final String? lat;
//   final String? lon;
//   final String? timestamp;

//   @override
//   _ProfileKapalGeosatPreviewTileState createState() =>
//       _ProfileKapalGeosatPreviewTileState();
// }

// class _ProfileKapalGeosatPreviewTileState
//     extends State<ProfileKapalGeosatPreviewTile> {
//   bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Color.fromARGB(255, 98, 182, 183),
//       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(
//               '${widget.namaKapal ?? '-'}',
//               style: TextStyle(color: Colors.white),
//             ),
//             trailing: IconButton(
//               icon:
//                   Icon(_isExpanded ? Icons.arrow_upward : Icons.arrow_downward),
//               color: Colors.white,
//               onPressed: () {
//                 setState(() {
//                   _isExpanded = !_isExpanded;
//                 });
//               },
//             ),
//           ),
//           if (_isExpanded)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 borderRadius: AppDefaults.borderRadius,
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'ID :',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             '${widget.idfull ?? '-'}',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'SN/IMEI :',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             '${widget.sn ?? '-'}/${widget.imei ?? '-'}',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Customer :',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             '${widget.customer ?? '-'}',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Tgl Aktifasi :',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             widget.timestamp != null
//                                 ? '${DateFormat('dd MMM y').format(DateTime.parse(widget.timestamp!))}'
//                                 : '-',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   // Divider(
//                   //   thickness: 0.8,
//                   //   color: Colors.white,
//                   // ),
//                   // Row(
//                   //   children: [
//                   //     Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       children: [
//                   //         Text(
//                   //           'Atp Start :',
//                   //           style: TextStyle(color: Colors.white),
//                   //         ),
//                   //         Text(
//                   //           widget.atpStart != null
//                   //               ? '${DateFormat('dd MMM y').format(DateTime.parse(widget.atpStart!))}'
//                   //               : '-',
//                   //           style: TextStyle(color: Colors.white),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //     Spacer(),
//                   //     Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       children: [
//                   //         Text(
//                   //           'Atp End :',
//                   //           style: TextStyle(color: Colors.white),
//                   //         ),
//                   //         Text(
//                   //           widget.atpEnd != null
//                   //               ? '${DateFormat('dd MMM y').format(DateTime.parse(widget.atpEnd!))}'
//                   //               : '-',
//                   //           style: TextStyle(color: Colors.white),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ],
//                   // ),
//                   Divider(
//                     thickness: 0.8,
//                     color: Colors.white,
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Type : ${widget.type ?? '-'}',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Category : ${widget.kategori ?? '-'}',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Divider(
//                     thickness: 0.8,
//                     color: Colors.white,
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Latitude :',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             '${widget.lat ?? '-'}',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Longitude :',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             '${widget.lon ?? '-'}',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Divider(
//                     thickness: 0.8,
//                     color: Colors.white,
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 363,
//                         height: 150,
//                         child: FlutterMap(
//                           options: MapOptions(
//                             initialCenter: LatLng(double.parse(widget.lat!),
//                                 double.parse(widget.lon!)),
//                             initialZoom: 4,
//                           ),
//                           children: [
//                             TileLayer(
//                               urlTemplate:
//                                   // 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                                   'https://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
//                               userAgentPackageName: 'com.example.app',
//                             ),
//                             MarkerLayer(
//                               markers: [
//                                 Marker(
//                                   point: LatLng(double.parse(widget.lat!),
//                                       double.parse(widget.lon!)),
//                                   width: 20,
//                                   height: 10,
//                                   child: const Icon(
//                                     FontAwesomeIcons.ship,
//                                     color: Colors.black,
//                                     size: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geotraking/core/components/marker_image_widget.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/views/profile/geosat/components/profile_tracking_one_geosat_page.dart';
// import 'package:geotraking/views/profile/components/profile_tracking_one_page.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import 'package:timeago/timeago.dart' as timeago;

class ProfileKapalGeosatPreviewTile extends StatefulWidget {
  const ProfileKapalGeosatPreviewTile({
    Key? key,
    required this.idfull,
    this.mobileId,
    this.namaKapal,
    this.kategori,
    this.type,
    this.custamer,
    this.lat,
    this.lon,
    this.sn,
    this.imei,
    this.powerStatus,
    this.externalVoltage,
    this.heading,
    this.speed,
    this.speedKmh,
    this.speedKn,
    this.timestamp,
    this.broadcast,
    this.atpStart,
    this.atpEnd,
  }) : super(key: key);

  final String idfull;
  final String? mobileId;
  final String? namaKapal;
  final String? kategori;
  final String? type;
  final String? custamer;
  final String? lat;
  final String? lon;
  final String? sn;
  final String? imei;
  final String? powerStatus;
  final String? externalVoltage;
  final String? heading;
  final String? speed;
  final double? speedKmh;
  final double? speedKn;
  final String? timestamp;
  final String? broadcast;
  final String? atpStart;
  final String? atpEnd;

  @override
  _ProfileKapalGeosatPreviewTileState createState() =>
      _ProfileKapalGeosatPreviewTileState();
}

class _ProfileKapalGeosatPreviewTileState
    extends State<ProfileKapalGeosatPreviewTile> {
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
      return Color.fromARGB(255, 127, 183, 126);
    } else if (difference.inMinutes < 120) {
      return Color.fromARGB(255, 255, 222, 77);
    } else if (difference.inDays < 7) {
      return Color.fromARGB(255, 243, 182, 100);
    } else {
      return Color.fromARGB(255, 117, 134, 148);
    }
  }

  Color _getTextColor() {
    final timestamp = DateTime.parse(widget.timestamp!);
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 72) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color _getTextHeadlineColor() {
    final timestamp = DateTime.parse(widget.timestamp!);
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 72) {
      return Colors.white60;
    } else {
      return Colors.black54;
    }
  }

  // String _formatLatitude(double? lat) {
  //   if (lat == null) return '';
  //   try {
  //     int degrees = lat.toInt();
  //     double minutes = (lat - degrees) * 60;
  //     int minutesInt = minutes.toInt();
  //     double seconds = (minutes - minutesInt) * 60;
  //     return '${degrees.abs()} ${degrees < 0 ? 'S' : 'N'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
  //   } catch (e) {
  //     return ''; // or return a default value
  //   }
  // }

  // String _formatLongitude(double? lon) {
  //   if (lon == null) return '';
  //   try {
  //     int degrees = lon.toInt();
  //     double minutes = (lon - degrees) * 60;
  //     int minutesInt = minutes.toInt();
  //     double seconds = (minutes - minutesInt) * 60;
  //     return '${degrees.abs()} ${degrees < 0 ? 'W' : 'E'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
  //   } catch (e) {
  //     return ''; // or return a default value
  //   }
  // }

  // Color _getCardColor() {
  //   final timestamp = DateTime.parse(widget.timestamp!);
  //   final now = DateTime.now();
  //   final difference = now.difference(timestamp);

  //   if (difference.inMinutes < 72) {
  //     // kurang dari 1 jam 12 menit
  //     return Color.fromARGB(255, 127, 183, 126);
  //   } else if (difference.inMinutes < 120) {
  //     // kurang dari 2 jam
  //     return Color.fromARGB(255, 241, 235, 144);
  //   } else if (difference.inDays < 7) {
  //     // kurang dari 7 hari
  //     return Color.fromARGB(255, 243, 182, 100);
  //   } else {
  //     // lebih dari 7 hari
  //     return Color.fromARGB(255, 117, 134, 148);
  //   }
  // }

  // Widget _getMarkerImage(String? timestamp) {
  //   if (timestamp == null) return Container();

  //   final dateTime = DateTime.parse(timestamp);
  //   final now = DateTime.now();
  //   final difference = now.difference(dateTime);

  //   if (difference.inMinutes < 72) {
  //     // 1 hour 12 minutes
  //     return Transform.rotate(
  //       angle: widget.heading != null
  //           ? double.parse(widget.heading!) * pi / 180
  //           : 0,
  //       child: Container(
  //         width: 30,
  //         height: 30,
  //         child:
  //             Image.asset('assets/images/kapal-hijau.png', fit: BoxFit.contain),
  //       ),
  //     );
  //   } else if (difference.inMinutes < 120) {
  //     // 2 hours
  //     return Transform.rotate(
  //       angle: widget.heading != null
  //           ? double.parse(widget.heading!) * pi / 180
  //           : 0,
  //       child: Container(
  //         width: 30,
  //         height: 30,
  //         child: Image.asset('assets/images/kapal-kuning.png',
  //             fit: BoxFit.contain),
  //       ),
  //     );
  //   } else if (difference.inHours < 168) {
  //     // 7 days
  //     return Transform.rotate(
  //       angle: widget.heading != null
  //           ? double.parse(widget.heading!) * pi / 180
  //           : 0,
  //       child: Container(
  //         width: 30,
  //         height: 30,
  //         child: Image.asset('assets/images/kapal-orange.png',
  //             fit: BoxFit.contain),
  //       ),
  //     );
  //   } else {
  //     return Transform.rotate(
  //       angle: widget.heading != null
  //           ? double.parse(widget.heading!) * pi / 180
  //           : 0,
  //       child: Container(
  //         width: 30,
  //         height: 30,
  //         child:
  //             Image.asset('assets/images/kapal-hijau.png', fit: BoxFit.contain),
  //       ),
  //     );
  //   }
  // }

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
              style: TextStyle(color: _getTextColor()),
            ),
            subtitle: Text(
              timeago.format(DateTime.parse(widget.timestamp!), locale: 'en'),
              style: TextStyle(color: _getTextHeadlineColor()),
            ),
            trailing: IconButton(
              icon:
                  Icon(_isExpanded ? Icons.arrow_upward : Icons.arrow_downward),
              color: _getTextColor(),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ID :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              '${widget.idfull}',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SN/IMEI :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              '${widget.sn ?? '-'}/${widget.imei ?? '-'}',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: _getTextColor(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Device Type :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              '${widget.type ?? '-'}',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                      // Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              '${widget.kategori ?? '-'}',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: _getTextColor(),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Owner :',
                            style: TextStyle(color: _getTextHeadlineColor()),
                          ),
                          Text(
                            '${widget.custamer ?? '-'}',
                            style: TextStyle(color: _getTextColor()),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: _getTextColor(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Received Date :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              widget.timestamp != null
                                  ? '${DateFormat('dd MMM y (HH:mm:ss)').format(DateTime.parse(widget.timestamp!))}'
                                  : '-',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Broadcast Date :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              widget.broadcast != null
                                  ? '${DateFormat('dd MMM y (HH:mm:ss)').format(DateTime.parse(widget.broadcast!))}'
                                  : '-',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: _getTextColor(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Airtime Start :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              widget.atpStart != null
                                  ? '${DateFormat('dd MMM y').format(DateTime.parse(widget.atpStart!))}'
                                  : '-',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Airtime End :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              widget.atpEnd != null
                                  ? '${DateFormat('dd MMM y').format(DateTime.parse(widget.atpEnd!))}'
                                  : '-',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: _getTextColor(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Power Source :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              '${widget.powerStatus ?? '-'}',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                      // Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Power Value :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              '${widget.externalVoltage ?? '-'} kwh',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: _getTextColor(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Heading :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              '${widget.heading ?? '-'}°',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Speed :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              '${widget.speedKn ?? '-'} knot/${widget.speedKmh ?? '-'} kmh',
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: _getTextColor(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Latitude :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              _formatLatitude(double.parse(widget.lat!)),
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                      // Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Longitude :',
                              style: TextStyle(color: _getTextHeadlineColor()),
                            ),
                            Text(
                              _formatLongitude(double.parse(widget.lon!)),
                              style: TextStyle(color: _getTextColor()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: _getTextColor(),
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
                                              timestamp: widget.timestamp!,
                                              heading: widget.heading),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(3),
                                child: IconButton(
                                  icon: const Icon(Icons.place_outlined,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileTrackingOneGeosatPage(
                                          idFull: widget.idfull,
                                          mobileId: widget.mobileId!,
                                          timestamp: widget.timestamp!,
                                          heading: widget.heading!,
                                          lat: double.parse(widget.lat!),
                                          lon: double.parse(widget.lon!),
                                        ),
                                      ),
                                    );
                                  },
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
    // return Card(
    //   color: _getCardColor(),
    //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    //   child: Column(
    //     children: [
    //       ListTile(
    //         title: Text(
    //           '${widget.namaKapal ?? '-'}',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         subtitle: Text(
    //           timeago.format(DateTime.parse(widget.timestamp!), locale: 'en'),
    //           style: TextStyle(color: Colors.white60),
    //         ),
    //         trailing: IconButton(
    //           icon:
    //               Icon(_isExpanded ? Icons.arrow_upward : Icons.arrow_downward),
    //           color: Colors.white,
    //           onPressed: () {
    //             setState(() {
    //               _isExpanded = !_isExpanded;
    //             });
    //           },
    //         ),
    //       ),
    //       if (_isExpanded)
    //         Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //           decoration: BoxDecoration(
    //             borderRadius: AppDefaults.borderRadius,
    //           ),
    //           child: Column(
    //             children: [
    //               Row(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'ID : ${widget.idfull}',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               SizedBox(height: 5),
    //               Row(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'SN/IMEI :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         '${widget.sn ?? '-'}/${widget.imei ?? '-'}',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               Divider(
    //                 thickness: 0.8,
    //                 color: Colors.white,
    //               ),
    //               Row(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Owner :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         widget.custamer != null &&
    //                                 widget.custamer!.length > 30
    //                             ? widget.custamer!.substring(0, 30) + '...'
    //                             : widget.custamer ?? '',
    //                         style: TextStyle(color: Colors.white),
    //                         maxLines: 2,
    //                         overflow: TextOverflow.ellipsis,
    //                       ),
    //                       // Text(
    //                       //   '${widget.custamer ?? '-'}',
    //                       //   style: TextStyle(color: Colors.white),
    //                       // ),
    //                       // Text(
    //                       //   '${widget.custamer ?? '-'}',
    //                       //   style: TextStyle(color: Colors.white),
    //                       //   overflow: TextOverflow.ellipsis, // Add this line
    //                       //   maxLines:
    //                       //       2, // Add this line to allow wrapping to 2 lines
    //                       // ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               Divider(
    //                 thickness: 0.8,
    //                 color: Colors.white,
    //               ),
    //               Row(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Vessel Type :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         '${widget.type ?? '-'}',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                   Spacer(),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Category :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         '${widget.kategori ?? '-'}',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               Divider(
    //                 thickness: 0.8,
    //                 color: Colors.white,
    //               ),
    //               Row(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Received Date :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       // Text(
    //                       //   widget.timestamp != null
    //                       //       ? '${DateFormat('dd MMM y (HH:mm:ss)').format(DateTime.parse(widget.timestamp!))}'
    //                       //       : '-',
    //                       //   style: TextStyle(color: Colors.white),
    //                       // ),
    //                       Text(
    //                         '${DateFormat('dd MMM y (HH:mm:ss)').format(DateTime.parse(widget.timestamp!))}',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               Divider(
    //                 thickness: 0.8,
    //                 color: Colors.white,
    //               ),
    //               Row(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Broadcast Date :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         '${DateFormat('dd MMM y (HH:mm:ss)').format(DateTime.parse(widget.broadcast!))}',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               Divider(
    //                 thickness: 0.8,
    //                 color: Colors.white,
    //               ),
    //               Row(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Power Source :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         '${widget.powerStatus ?? '-'}',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                   Spacer(),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Power Value :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         '${widget.externalVoltage ?? '-'} kwh',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                   // Spacer(),
    //                   // Column(
    //                   //   crossAxisAlignment: CrossAxisAlignment.start,
    //                   //   children: [
    //                   //     Text(
    //                   //       'Device Alarm :',
    //                   //       style: TextStyle(color: Colors.white60),
    //                   //     ),
    //                   //     Text(
    //                   //       'Alarm',
    //                   //       style: TextStyle(color: Colors.white),
    //                   //     ),
    //                   //   ],
    //                   // ),
    //                 ],
    //               ),
    //               Divider(
    //                 thickness: 0.8,
    //                 color: Colors.white,
    //               ),
    //               Row(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Heading :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         '${widget.heading ?? '-'} °',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                   Spacer(),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Speed :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         '${widget.speedKn ?? '-'} knot/${widget.speedKmh ?? '-'} kmh',
    //                         // '${widget.speed ?? '-'} knot',
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                   // Spacer(),
    //                   // Column(
    //                   //   crossAxisAlignment: CrossAxisAlignment.start,
    //                   //   children: [
    //                   //     Text(
    //                   //       'Distance :',
    //                   //       style: TextStyle(color: Colors.white60),
    //                   //     ),
    //                   //     Text(
    //                   //       '- NMi',
    //                   //       style: TextStyle(color: Colors.white),
    //                   //     ),
    //                   //   ],
    //                   // ),
    //                 ],
    //               ),
    //               Divider(
    //                 thickness: 0.8,
    //                 color: Colors.white,
    //               ),
    //               Row(
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Latitude :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         _formatLatitude(double.parse(widget.lat ?? '0')),
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                   Spacer(),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Longitude :',
    //                         style: TextStyle(color: Colors.white60),
    //                       ),
    //                       Text(
    //                         _formatLongitude(double.parse(widget.lon ?? '0')),
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               Divider(
    //                 thickness: 0.8,
    //                 color: Colors.white,
    //               ),
    //               Row(
    //                 children: [
    //                   Stack(
    //                     children: [
    //                       ClipRRect(
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(10),
    //                         ),
    //                         child: Container(
    //                           width: 363,
    //                           height: 150,
    //                           child: FlutterMap(
    //                             options: MapOptions(
    //                               initialCenter: LatLng(
    //                                   double.parse(widget.lat!),
    //                                   double.parse(widget.lon!)),
    //                               initialZoom: 4,
    //                             ),
    //                             children: [
    //                               TileLayer(
    //                                 urlTemplate:
    //                                     'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    //                                 userAgentPackageName: 'com.example.app',
    //                               ),
    //                               MarkerLayer(
    //                                 markers: [
    //                                   Marker(
    //                                     point: LatLng(double.parse(widget.lat!),
    //                                         double.parse(widget.lon!)),
    //                                     width: 30,
    //                                     height: 30,
    //                                     child:
    //                                         _getMarkerImage(widget.timestamp),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                       Positioned(
    //                         bottom: 10,
    //                         right: 10,
    //                         child: Container(
    //                           decoration: BoxDecoration(
    //                             color: Colors.black38,
    //                             shape: BoxShape.circle,
    //                           ),
    //                           padding: const EdgeInsets.all(3),
    //                           child: IconButton(
    //                             icon: const Icon(Icons.place_outlined,
    //                                 color: Colors.white),
    //                             onPressed: () {
    //                               Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         ProfileTrackingOneGeosatPage(
    //                                           idFull: widget.idfull,
    //                                           mobileId: widget.mobileId!,
    //                                           timestamp: widget.timestamp!,
    //                                           heading: widget.heading!,
    //                                           lat: double.parse(widget.lat!),
    //                                           lon: double.parse(widget.lon!),
    //                                         )),
    //                               );
    //                             },
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //     ],
    //   ),
    // );
  }
}
