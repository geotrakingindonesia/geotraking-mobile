// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:geotraking/core/components/card_vessel_color.dart';
import 'package:geotraking/core/components/formated_latlong.dart';
import 'package:geotraking/core/components/marker_image_widget.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
// import 'package:geotraking/core/models/member.dart';
// import 'package:geotraking/core/services/auth/authenticate_service.dart';
// import 'package:geotraking/core/services/status_payment_member_service.dart';
import 'package:geotraking/core/services/trouble_member_service.dart';
import 'package:geotraking/core/utils/validators.dart';
import 'package:geotraking/views/profile/components/profile_tracking_one_page.dart';
import 'package:geotraking/views/profile/geosat/components/profile_tracking_one_geosat_page.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import 'package:timeago/timeago.dart' as timeago;

class ProfileKapalPreviewTile extends StatefulWidget {
  const ProfileKapalPreviewTile({
    Key? key,
    required this.idfull,
    this.isAdmin,
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
    this.speedMs,
    this.speedMph,
    this.rpm1,
    this.rpm2,
    this.timestamp,
    this.broadcast,
    this.atpStart,
    this.atpEnd,
    this.selectedTimeZonePreferences,
    this.selectedSpeedPreferences,
    this.selectedCoordinatePreferences,
  }) : super(key: key);

  final String idfull;
  final String? isAdmin;
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
  final double? speedMs;
  final double? speedMph;
  final int? rpm1;
  final int? rpm2;
  final String? timestamp;
  final String? broadcast;
  final String? atpStart;
  final String? atpEnd;
  // set time zone data kapal
  final String? selectedTimeZonePreferences;
  final String? selectedSpeedPreferences;
  final String? selectedCoordinatePreferences;

  @override
  _ProfileKapalPreviewTileState createState() =>
      _ProfileKapalPreviewTileState();
}

class _ProfileKapalPreviewTileState extends State<ProfileKapalPreviewTile> {
  bool _isExpanded = false;
  final _key = GlobalKey<FormState>();
  final TroubleMemberService troubleMemberService = TroubleMemberService();
  final TextEditingController _keluhanController = TextEditingController();
  // final StatusPaymentMemberService statusPaymentMemberService =
  //     StatusPaymentMemberService();
  String _keluhan = '';
  final FormatedLatlong _formatedLatlong = FormatedLatlong();
  // MemberUser? _user;

  // String _formatLatitude(double? lat) {
  //   if (lat == null) return '';
  //   try {
  //     int degrees = lat.toInt();
  //     double minutes = (lat - degrees) * 60;
  //     int minutesInt = minutes.toInt();
  //     double seconds = (minutes - minutesInt) * 60;
  //     return '${degrees.abs()} ${degrees < 0 ? 'S' : 'N'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
  //   } catch (e) {
  //     return '';
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
  //     return '';
  //   }
  // }

  onSimpanTrouble() async {
    if (_key.currentState!.validate()) {
      _key.currentState?.save();
      try {
        await troubleMemberService.storeTroubleData(widget.mobileId!, _keluhan);
        _keluhanController.clear();
        Navigator.of(context).pop();
        _onSuccessSimpanTrouble();
      } catch (e) {
        setState(() {
          print('gagal kirim keluhan.');
        });
      }
    }
  }

  // onSimpanPerpanjanganAirtime() async {
  //   try {
  //     await statusPaymentMemberService.storeStatusPaymentData(widget.mobileId!);
  //     Navigator.of(context).pop();
  //     _onSuccessSimpanPerpanjangAirtime();
  //   } catch (e) {
  //     setState(() {
  //       print('gagal perpanjangan airtime.');
  //     });
  //   }
  // }

  _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  _onSuccessSimpanPerpanjangAirtime() {
    _showSnackbar(
        'Berhasil Konfirmasi, lihat di menu status payment pada profile untuk detailnya.');
  }

  _onSuccessSimpanTrouble() {
    _showSnackbar(
        'Berhasil Mengirim Keluhan, lihat di menu trouble pada profile untuk detailnya.');
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _checkLoggedIn();
  // }

  // _checkLoggedIn() async {
  //   final authService = AuthService();
  //   MemberUser? userData = await authService.getCurrentUser();

  //   print(userData);
  //   print(userData!.isAdmin);
  //   setState(() {
  //     _user = userData;
  //   });
  // }

  void _showTroubleshootBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Troubleshoot (${widget.namaKapal})',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _keluhanController,
                                validator: (value) =>
                                    Validators.required(value),
                                onSaved: (value) => _keluhan = value!,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Masukkan Keluhan..',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  filled: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FloatingActionButton(
                        onPressed: onSimpanTrouble,
                        backgroundColor: Colors.blue,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void _showHistoryBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
  //       return Padding(
  //         padding: EdgeInsets.only(bottom: keyboardHeight),
  //         child: SingleChildScrollView(
  //           child: Container(
  //             padding: EdgeInsets.all(16.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   'Perpanjang Airtime (${widget.namaKapal})',
  //                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
  //                         color: Colors.black,
  //                       ),
  //                 ),
  //                 SizedBox(height: 16.0),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: ElevatedButton(
  //                         onPressed: onSimpanPerpanjanganAirtime,
  //                         style: ElevatedButton.styleFrom(
  //                           padding:
  //                               const EdgeInsets.all(AppDefaults.padding * 1.2),
  //                           backgroundColor: Colors.blue,
  //                         ),
  //                         child: Text(
  //                           'Konfirmasi Perpanjangan Airtime',
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .titleSmall
  //                               ?.copyWith(
  //                                 color: Colors.white,
  //                               ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardVesselColor(widget.timestamp!),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${widget.namaKapal ?? '-'}',
              style: TextStyle(color: cardTextColor(widget.timestamp!)),
            ),
            // subtitle: Text(
            //   timeago.format(DateTime.parse(widget.timestamp!), locale: 'en'),
            //   style: TextStyle(color: cardHeadlineTextColor(widget.timestamp!)),
            // ),
            subtitle: Row(
              children: [
                Text(
                  timeago.format(DateTime.parse(widget.timestamp!),
                      locale: 'en'),
                  style: TextStyle(
                      color: cardHeadlineTextColor(widget.timestamp!)),
                ),
                // SizedBox(width: 5),
                // ShakeWidget(
                //   duration: const Duration(seconds: 3),
                //   shakeConstant: ShakeRotateConstant2(),
                //   autoPlay: true,
                //   child: Icon(
                //     Icons.notifications_active,
                //     color: cardHeadlineTextColor(widget.timestamp!),
                //     size: 20,
                //   ),
                // ),
              ],
            ),
            trailing: IconButton(
              icon:
                  Icon(_isExpanded ? Icons.arrow_upward : Icons.arrow_downward),
              color: cardTextColor(widget.timestamp!),
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
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              '${widget.idfull}',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
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
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              '${widget.sn ?? '-'}/${widget.imei ?? '-'}',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: cardTextColor(widget.timestamp!),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Device Type :',
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              '${widget.type ?? '-'}',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category :',
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              '${widget.kategori ?? '-'}',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: cardTextColor(widget.timestamp!),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Owner :',
                            style: TextStyle(
                                color:
                                    cardHeadlineTextColor(widget.timestamp!)),
                          ),
                          Text(
                            '${widget.custamer ?? '-'}',
                            style: TextStyle(
                                color: cardTextColor(widget.timestamp!)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: cardTextColor(widget.timestamp!),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Received Date (${widget.selectedTimeZonePreferences}):',
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              widget.timestamp != null
                                  ? '${DateFormat('dd MMM y (HH:mm:ss)').format(DateTime.parse(widget.timestamp!))}'
                                  : '-',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Broadcast Date (${widget.selectedTimeZonePreferences}):',
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              widget.broadcast != null
                                  ? '${DateFormat('dd MMM y (HH:mm:ss)').format(DateTime.parse(widget.broadcast!))}'
                                  : '-',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: cardTextColor(widget.timestamp!),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Airtime Start :',
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              widget.atpStart != null
                                  ? '${DateFormat('dd MMM y').format(DateTime.parse(widget.atpStart!))}'
                                  : '-',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
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
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              widget.atpEnd != null
                                  ? '${DateFormat('dd MMM y').format(DateTime.parse(widget.atpEnd!))}'
                                  : '-',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: cardTextColor(widget.timestamp!),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Power Source :',
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              '${widget.powerStatus ?? '-'}',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
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
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              '${widget.externalVoltage ?? '-'} kwh',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: cardTextColor(widget.timestamp!),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Heading :',
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              '${widget.heading ?? '-'}°',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
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
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              // '${widget.speedKn ?? '-'} knot/${widget.speedKmh ?? '-'} kmh ${widget.selectedSpeedPreferences}',
                              '${widget.speed ?? '-'} ${widget.selectedSpeedPreferences}',
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: cardTextColor(widget.timestamp!),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wind :',
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.wind,
                                  color: cardTextColor(widget.timestamp!),
                                  size: 15,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Ongoing',
                                  style: TextStyle(
                                    color: cardTextColor(widget.timestamp!),
                                  ),
                                ),
                              ],
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
                              'Temperature :',
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.temperatureEmpty,
                                  color: cardTextColor(widget.timestamp!),
                                  size: 15,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Ongoing',
                                  style: TextStyle(
                                    color: cardTextColor(widget.timestamp!),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: cardTextColor(widget.timestamp!),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Latitude :',
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              // _formatLatitude(double.parse(widget.lat!)),
                              widget.selectedCoordinatePreferences == 'Degrees'
                                  ? _formatedLatlong
                                      .formatLatitude(double.parse(widget.lat!))
                                  : double.parse(widget.lat!).toString(),
                              // _formatedLatlong.formatLatitude(double.parse(widget.lat!)),
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
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
                              style: TextStyle(
                                  color:
                                      cardHeadlineTextColor(widget.timestamp!)),
                            ),
                            Text(
                              // _formatLongitude(double.parse(widget.lon!)),
                              // _formatedLatlong
                              //     .formatLongitude(double.parse(widget.lon!)),
                              widget.selectedCoordinatePreferences == 'Degrees'
                                  ? _formatedLatlong
                                      .formatLongitude(double.parse(widget.lon!))
                                  : double.parse(widget.lon!).toString(),
                              style: TextStyle(
                                  color: cardTextColor(widget.timestamp!)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: cardTextColor(widget.timestamp!),
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
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.black38,
                                      //     shape: BoxShape.circle,
                                      //   ),
                                      //   child: IconButton(
                                      //     icon: const Icon(Icons.history,
                                      //         color: Colors.white),
                                      //     onPressed: () {
                                      //       _showHistoryBottomSheet(context);
                                      //     },
                                      //   ),
                                      // ),
                                      SizedBox(width: 5),
                                      if (widget.isAdmin == '0')
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black38,
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            icon: const Icon(Icons.troubleshoot,
                                                color: Colors.white),
                                            onPressed: () {
                                              _showTroubleshootBottomSheet(
                                                  context);
                                            },
                                          ),
                                        ),
                                      SizedBox(width: 5),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black38,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.place_outlined,
                                              color: Colors.white),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => widget
                                                            .isAdmin ==
                                                        '0'
                                                    ? ProfileTrackingOnePage(
                                                        idFull: widget.idfull,
                                                        mobileId:
                                                            widget.mobileId!,
                                                        timestamp:
                                                            widget.timestamp!,
                                                        heading:
                                                            widget.heading!,
                                                        lat: widget.lat!,
                                                        lon: widget.lon!,
                                                      )
                                                    : ProfileTrackingOneGeosatPage(
                                                        idFull: widget.idfull,
                                                        mobileId:
                                                            widget.mobileId!,
                                                        timestamp:
                                                            widget.timestamp!,
                                                        heading:
                                                            widget.heading!,
                                                        lat: double.parse(
                                                            widget.lat!),
                                                        lon: double.parse(
                                                            widget.lon!),
                                                      ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.8,
                    color: cardTextColor(widget.timestamp!),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          AnimatedRadialGauge(
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.elasticOut,
                                            radius: 80,
                                            value:
                                                widget.rpm1?.toDouble() ?? 0.0,
                                            axis: GaugeAxis(
                                              min: 0,
                                              max: 1000,
                                              degrees: 180,
                                              pointer: GaugePointer.triangle(
                                                borderRadius: 2,
                                                color: Color(0xFF193663),
                                                width: 10,
                                                height: 40,
                                              ),
                                              progressBar:
                                                  const GaugeProgressBar
                                                      .rounded(
                                                color: Colors.transparent,
                                              ),
                                              segments: [
                                                const GaugeSegment(
                                                  from: 0,
                                                  to: 200,
                                                  color: Colors.red,
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 201,
                                                  to: 400,
                                                  color: Colors.orange,
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 401,
                                                  to: 600,
                                                  color: Colors.yellow,
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 601,
                                                  to: 800,
                                                  color: Colors.greenAccent,
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 801,
                                                  to: 1000,
                                                  color: Colors.green,
                                                  cornerRadius: Radius.zero,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 60,
                                            child: Text(
                                              'RPM1: ${widget.rpm1}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Flexible(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          AnimatedRadialGauge(
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.elasticOut,
                                            radius: 80,
                                            value:
                                                widget.rpm2?.toDouble() ?? 0.0,
                                            axis: GaugeAxis(
                                              min: 0,
                                              max: 1000,
                                              degrees: 180,
                                              pointer: GaugePointer.triangle(
                                                borderRadius: 2,
                                                color: Color(0xFF193663),
                                                width: 10,
                                                height: 40,
                                              ),
                                              progressBar:
                                                  const GaugeProgressBar
                                                      .rounded(
                                                color: Colors.transparent,
                                              ),
                                              segments: [
                                                const GaugeSegment(
                                                  from: 0,
                                                  to: 200,
                                                  color: Colors.red,
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 201,
                                                  to: 400,
                                                  color: Colors.orange,
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 401,
                                                  to: 600,
                                                  color: Colors.yellow,
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 601,
                                                  to: 800,
                                                  color: Colors.greenAccent,
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 801,
                                                  to: 1000,
                                                  color: Colors.green,
                                                  cornerRadius: Radius.zero,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 60,
                                            child: Text(
                                              'RPM2: ${widget.rpm2}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Column(
                                //       children: [
                                //         Icon(Icons.circle,
                                //             color: Colors.red, size: 12),
                                //         Text(
                                //           '0 - 200',
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //     Column(
                                //       children: [
                                //         Icon(Icons.circle,
                                //             color: Colors.orange, size: 12),
                                //         Text(
                                //           '201 - 400',
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //     Column(
                                //       children: [
                                //         Icon(Icons.circle,
                                //             color: Colors.yellow, size: 12),
                                //         Text(
                                //           '401 - 600',
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //     Column(
                                //       children: [
                                //         Icon(Icons.circle,
                                //             color: Colors.greenAccent,
                                //             size: 12),
                                //         Text(
                                //           '601 - 800',
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //     Column(
                                //       children: [
                                //         Icon(Icons.circle,
                                //             color: Colors.green, size: 12),
                                //         Text(
                                //           '801 - 1000',
                                //           style: TextStyle(fontSize: 12),
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded( // Membungkus dengan Expanded untuk meratakan space
      child: Column(
        children: [
          Icon(Icons.circle, color: Colors.red, size: 12),
          Text(
            '0 - 200',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    ),
    Expanded( // Membungkus dengan Expanded untuk meratakan space
      child: Column(
        children: [
          Icon(Icons.circle, color: Colors.orange, size: 12),
          Text(
            '201 - 400',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    ),
    Expanded( // Membungkus dengan Expanded untuk meratakan space
      child: Column(
        children: [
          Icon(Icons.circle, color: Colors.yellow, size: 12),
          Text(
            '401 - 600',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    ),
    Expanded( // Membungkus dengan Expanded untuk meratakan space
      child: Column(
        children: [
          Icon(Icons.circle, color: Colors.greenAccent, size: 12),
          Text(
            '601 - 800',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    ),
    Expanded( // Membungkus dengan Expanded untuk meratakan space
      child: Column(
        children: [
          Icon(Icons.circle, color: Colors.green, size: 12),
          Text(
            '801 - 1000',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    ),
  ],
),
                              ],
                            ),
                            // child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Flexible(
                            //       child: Stack(
                            //         alignment: Alignment.center,
                            //         children: [
                            //           AnimatedRadialGauge(
                            //             duration: const Duration(seconds: 1),
                            //             curve: Curves.elasticOut,
                            //             radius: 80,
                            //             value: 650,
                            //             axis: GaugeAxis(
                            //               min: 0,
                            //               max: 1000,
                            //               degrees: 180,
                            //               pointer: GaugePointer.triangle(
                            //                 borderRadius: 2,
                            //                 color: Color(0xFF193663),
                            //                 width: 10,
                            //                 height: 40,
                            //               ),
                            //               progressBar:
                            //                   const GaugeProgressBar.rounded(
                            //                 color: Colors.transparent,
                            //               ),
                            //               segments: [
                            //                 const GaugeSegment(
                            //                   from: 0,
                            //                   to: 200,
                            //                   color: Colors.red,
                            //                   cornerRadius: Radius.zero,
                            //                 ),
                            //                 const GaugeSegment(
                            //                   from: 201,
                            //                   to: 400,
                            //                   color: Colors.orange,
                            //                   cornerRadius: Radius.zero,
                            //                 ),
                            //                 const GaugeSegment(
                            //                   from: 401,
                            //                   to: 600,
                            //                   color: Colors.yellow,
                            //                   cornerRadius: Radius.zero,
                            //                 ),
                            //                 const GaugeSegment(
                            //                   from: 601,
                            //                   to: 800,
                            //                   color: Colors.greenAccent,
                            //                   cornerRadius: Radius.zero,
                            //                 ),
                            //                 const GaugeSegment(
                            //                   from: 801,
                            //                   to: 1000,
                            //                   color: Colors.green,
                            //                   cornerRadius: Radius.zero,
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //           Positioned(
                            //             top: 60,
                            //             child: Text(
                            //               'RPM1: 650',
                            //               style: TextStyle(
                            //                 fontSize: 14,
                            //                 fontWeight: FontWeight.bold,
                            //                 color: Colors.black,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(width: 16),
                            //     Flexible(
                            //       child: Stack(
                            //         alignment: Alignment.center,
                            //         children: [
                            //           AnimatedRadialGauge(
                            //             duration: const Duration(seconds: 1),
                            //             curve: Curves.elasticOut,
                            //             radius: 80,
                            //             value: 50,
                            //             axis: GaugeAxis(
                            //               min: 0,
                            //               max: 1000,
                            //               degrees: 180,
                            //               pointer: GaugePointer.triangle(
                            //                 borderRadius: 2,
                            //                 color: Color(0xFF193663),
                            //                 width: 10,
                            //                 height: 40,
                            //               ),
                            //               progressBar:
                            //                   const GaugeProgressBar.rounded(
                            //                 color: Colors.transparent,
                            //               ),
                            //               segments: [
                            //                 const GaugeSegment(
                            //                   from: 0,
                            //                   to: 200,
                            //                   color: Colors.red,
                            //                   cornerRadius: Radius.zero,
                            //                 ),
                            //                 const GaugeSegment(
                            //                   from: 201,
                            //                   to: 400,
                            //                   color: Colors.orange,
                            //                   cornerRadius: Radius.zero,
                            //                 ),
                            //                 const GaugeSegment(
                            //                   from: 401,
                            //                   to: 600,
                            //                   color: Colors.yellow,
                            //                   cornerRadius: Radius.zero,
                            //                 ),
                            //                 const GaugeSegment(
                            //                   from: 601,
                            //                   to: 800,
                            //                   color: Colors.greenAccent,
                            //                   cornerRadius: Radius.zero,
                            //                 ),
                            //                 const GaugeSegment(
                            //                   from: 801,
                            //                   to: 1000,
                            //                   color: Colors.green,
                            //                   cornerRadius: Radius.zero,
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //           Positioned(
                            //             top: 60,
                            //             child: Text(
                            //               'RPM2: 50',
                            //               style: TextStyle(
                            //                 fontSize: 14,
                            //                 fontWeight: FontWeight.bold,
                            //                 color: Colors.black,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ),
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
