// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class TabCctv extends StatefulWidget {
  const TabCctv({Key? key}) : super(key: key);

  @override
  _TabCctvState createState() => _TabCctvState();
}

String _convertDriveLink(String driveUrl) {
  final fileId = driveUrl.split('/d/')[1].split('/')[0];
  return 'https://drive.google.com/uc?export=view&id=$fileId';
}

class _TabCctvState extends State<TabCctv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 21, 38),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/1s0Y0DQQuan_9rqigwoP6mvv3MqJO3UQd/view?usp=sharing"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        // height: double.infinity,
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'SPESIFIKASI',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'VISIONTRAK CCTV MARITIM',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 2.5,
              children: [
                _buildProductCard('2 Unit CCTV Camera 5Mp', Icons.camera_alt),
                _buildProductCard(
                    'Hardisk 1 TB (Terabyte)', FontAwesomeIcons.hardDrive),
                _buildProductCard('Memory 8 GB (Gigabyte)', Icons.memory),
                _buildProductCard('Wifi Connection', Icons.wifi),
                _buildProductCard('Including GPS Report', Icons.location_on),
                _buildProductCard('Setting By Speed', Icons.settings),
                _buildProductCard(
                    'Cable RG IP Camera 10M (meters)', Icons.account_tree),
                _buildProductCard('Camera Data Analysis', Icons.analytics),
              ],
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'WHY WORK WITH US?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'KENALI CARA KERJA VISIONTRAK',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Column(
              children: [
                _buildBenefitItem(
                  'Sistem Pelacakan Kapal telah dikembangkan menjadi menyediakan fasilitas yang komprehensif untuk pemantauan.',
                ),
                _buildBenefitItem(
                    'Ini memberikan kekuatan, aman, andal dan mudah gunakan sistem pelacakan.'),
                _buildBenefitItem(
                    'Namun jika terjadi masalah, teknisi Insatech Marine siap melakukan servis dan perbaikan, baik terjadwal maupun tidak terjadwal.'),
              ],
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'ABOUT US',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'TENTANG PRODUK KAMI',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 80,
                  // top: 20,
                  bottom: 20,
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/1nk3xNmZq-eSR6y4T4IjNjmH74vD6V8vU/view?usp=sharing"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Satelit Geomatika Indonesia Merupakan Pionir Dalam Bidang Ini Pengembangan Sistem Pelacakan Satelit Dan Komunikasi Dua Arah. Bisnis inti kami adalah memanfaatkan jaringan satelit dengan rekayasa unggul kami pelacakan dan perangkat keras komunikasi terintegrasi dengan Pusat Komando berbasis cloud kami yang terdepan di industri–GeoSat',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              // onTap: () => {},
              onTap: () async {
                const url =
                    'https://drive.google.com/uc?export=download&id=1Hp7-EmCVdTKeU1AuBFhEosNOqVzSfWl0'; // URL unduhan PDF
                try {
                  // Mendapatkan direktori sementara untuk menyimpan file
                  final tempDir = await getTemporaryDirectory();
                  final filePath = '${tempDir.path}/brosur-visiontrak-cctv.pdf';

                  // Mengunduh file menggunakan Dio
                  final dio = Dio();
                  await dio.download(url, filePath);

                  // Membuka file PDF menggunakan open_file
                  OpenFile.open(filePath);
                } catch (e) {
                  // Menangani error saat unduh atau buka file
                  print('Error saat mengunduh atau membuka file: $e');
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5, top: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900,
                      Color.fromARGB(255, 2, 21, 38)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dapatkan Brosur',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'VisionTrak',
                          style: TextStyle(
                            color: Color.fromARGB(255, 243, 182, 100),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade900,
                            Colors.purple.shade600
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Download",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 1,
                            height: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBenefitItem(String title) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
    ),
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(15),
    child: Row(
      children: [
        Icon(
          Icons.check,
          color: Colors.blue.shade900,
          size: 30,
        ),
        SizedBox(width: 13),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 17,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildProductCard(String title, IconData icon) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
    ),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 25,
          ),
        ),
        Expanded(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 3, 52, 110),
                  Color.fromARGB(255, 110, 172, 218),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
