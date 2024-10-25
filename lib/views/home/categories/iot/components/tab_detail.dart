// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/views/catalogue/components/hubungi_kami_button.dart';
import 'package:url_launcher/url_launcher.dart';

// class TabDetail extends StatelessWidget {
//   final String namaPaket;
//   final String kuota;
//   final String masaAktif;

//   TabDetail({
//     required this.namaPaket,
//     required this.kuota,
//     required this.masaAktif,
//   });

class TabDetail extends StatefulWidget {
  final String namaPaket;
  final String kuota;
  final String masaAktif;

  TabDetail({
    super.key,
    required this.namaPaket,
    required this.kuota,
    required this.masaAktif,
  });

  @override
  _TabDetailState createState() => _TabDetailState();
}

class _TabDetailState extends State<TabDetail> {
  bool _isShowDeskripsi = false;
  bool _isShowKategoriPaket = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Paket'),
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.namaPaket,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 8),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       widget.kuota,
            //       style: TextStyle(
            //         fontSize: 24,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     // Text(
            //     //   harga,
            //     //   style: TextStyle(
            //     //     fontSize: 24,
            //     //     fontWeight: FontWeight.bold,
            //     //   ),
            //     // ),
            //   ],
            // ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('Only'),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Icon(Icons.hourglass_bottom),
                  //         SizedBox(width: 8),
                  //         Text(
                  //           'Masa Aktif',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     Text(
                  //       widget.masaAktif,
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Divider(),
                  // Column(
                  //   children: [

                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Text(
                  //           'Jenis Sensor',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.blueGrey,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     IconButton(
                  //       icon: Icon(_isShowKategoriPaket
                  //           ? Icons.arrow_upward
                  //           : Icons.arrow_downward),
                  //       onPressed: () {
                  //         setState(() {
                  //           _isShowKategoriPaket = !_isShowKategoriPaket;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // if (_isShowKategoriPaket)
                  //   Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               SizedBox(width: 8),
                  //               Text(
                  //                 'Coreolis flow meter',
                  //               ),
                  //             ],
                  //           ),
                  //           Text(
                  //             'A',
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               SizedBox(width: 8),
                  //               Text(
                  //                 'Ovalgear flow meter',
                  //               ),
                  //             ],
                  //           ),
                  //           Text(
                  //             'B',
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Text(
                  //           'Kategori Mesin',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.blueGrey,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     IconButton(
                  //       icon: Icon(_isShowKategoriPaket
                  //           ? Icons.arrow_upward
                  //           : Icons.arrow_downward),
                  //       onPressed: () {
                  //         setState(() {
                  //           _isShowKategoriPaket = !_isShowKategoriPaket;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // if (_isShowKategoriPaket)
                  //   Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               SizedBox(width: 8),
                  //               Text(
                  //                 'Mesin Analog',
                  //               ),
                  //             ],
                  //           ),
                  //           Text(
                  //             'A',
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               SizedBox(width: 8),
                  //               Text(
                  //                 'Mesin Digital',
                  //               ),
                  //             ],
                  //           ),
                  //           Text(
                  //             'B',
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Text(
                  //           'Interval Pengiriman Data',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.blueGrey,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     IconButton(
                  //       icon: Icon(_isShowKategoriPaket
                  //           ? Icons.arrow_upward
                  //           : Icons.arrow_downward),
                  //       onPressed: () {
                  //         setState(() {
                  //           _isShowKategoriPaket = !_isShowKategoriPaket;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // if (_isShowKategoriPaket)
                  //   Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               SizedBox(width: 8),
                  //               Text(
                  //                 'Mesin Analog',
                  //               ),
                  //             ],
                  //           ),
                  //           Text(
                  //             'A',
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               SizedBox(width: 8),
                  //               Text(
                  //                 'Mesin Digital',
                  //               ),
                  //             ],
                  //           ),
                  //           Text(
                  //             'B',
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Deskripsi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      // IconButton(
                      //   icon: Icon(_isShowDeskripsi
                      //       ? Icons.arrow_upward
                      //       : Icons.arrow_downward),
                      //   onPressed: () {
                      //     setState(() {
                      //       _isShowDeskripsi = !_isShowDeskripsi;
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // if (_isShowDeskripsi) SizedBox(height: 8),
                  // if (_isShowDeskripsi)
                  Text(
                    'Pemantauan Bahan Bakar yang Akurat, Andal, dan Perawatannya Rendah',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    'Sistem Pemantauan Bahan Bakar Coriolis memberikan pengelolaan bahan bakar yang akurat dan andal dengan mengukur aliran massa secara langsung menggunakan efek Coriolis. Ideal untuk lingkungan yang menuntut, sistem ini memberikan akurasi dan daya tahan tinggi, menghilangkan kesalahan dari perubahan kepadatan bahan bakar dan viskositas. Optimalkan efisiensi bahan bakar dan kurangi biaya dengan Sistem Pemantauan Bahan Bakar Coriolis.',
                    // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Container(
                    // color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        // decoration: BoxDecoration(
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: Colors.black54,
                        //       blurRadius: 10.0,
                        //       offset: Offset(0, 5),
                        //     ),
                        //   ],
                        // ),
                        child: Container(
                          child: ClipRRect(
                            borderRadius: AppDefaults.borderRadius,
                            child: Image.asset(
                              'assets/images/coriolis.png',
                              // width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Harga Total',
                    style: TextStyle(fontSize: 16),
                  ),
                  // Text(
                  //   harga,
                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 16),
            HubungiKamiButton(
              onHubungiKamiButtonTap: () async {
                String whatsAppUrl =
                    'https://wa.me/6281908192559?text=Hallo+Geomatika+Satelit+Indonesia';
                if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
                  await launchUrl(Uri.parse(whatsAppUrl));
                } else {
                  throw 'Could not launch $whatsAppUrl';
                }
              },
            ),
            // Center(
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color.fromARGB(255, 127, 183, 126),
            //       padding:
            //           EdgeInsets.symmetric(horizontal: 100.0, vertical: 16.0),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     onPressed: () {},
            //     child: Text(
            //       'Hubungi Kami',
            //       style: TextStyle(fontSize: 18, color: Colors.white),
            //     ),
            //   ),
            // ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
