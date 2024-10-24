// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.kuota,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   harga,
                //   style: TextStyle(
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('Only | With Connection'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Kategori',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(_isShowKategoriPaket
                            ? Icons.arrow_upward
                            : Icons.arrow_downward),
                        onPressed: () {
                          setState(() {
                            _isShowKategoriPaket = !_isShowKategoriPaket;
                          });
                        },
                      ),
                    ],
                  ),
                  if (_isShowKategoriPaket)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 8),
                                Text(
                                  'Kategori 1',
                                ),
                              ],
                            ),
                            Text(
                              'A',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 8),
                                Text(
                                  'Kategori 2',
                                ),
                              ],
                            ),
                            Text(
                              'B',
                            ),
                          ],
                        ),
                      ],
                    ),
                  Divider(),
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
                      IconButton(
                        icon: Icon(_isShowDeskripsi
                            ? Icons.arrow_upward
                            : Icons.arrow_downward),
                        onPressed: () {
                          setState(() {
                            _isShowDeskripsi = !_isShowDeskripsi;
                          });
                        },
                      ),
                    ],
                  ),
                  // if (_isShowDeskripsi) SizedBox(height: 8),
                  if (_isShowDeskripsi)
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                      style: TextStyle(color: Colors.grey.shade700),
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
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 127, 183, 126),
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Beli Sekarang',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
