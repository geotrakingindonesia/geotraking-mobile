// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:url_launcher/url_launcher.dart';

class TabAiscube extends StatefulWidget {
  const TabAiscube({Key? key}) : super(key: key);

  @override
  _TabAiscubeState createState() => _TabAiscubeState();
}

String _convertDriveLink(String driveUrl) {
  final fileId = driveUrl.split('/d/')[1].split('/')[0];
  return 'https://drive.google.com/uc?export=view&id=$fileId';
}

class _TabAiscubeState extends State<TabAiscube> {
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
                          "https://drive.google.com/file/d/1RKNaOC59-ZkqnSY2knvB9HzSKoSlMjos/view?usp=sharing"),
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
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'PRODUK KAMI',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'ONE STOP SOLUTION',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'AIS Cube Integration adalah System Integrasi AIS dan kamera CCTV untuk memantau posisi dan pergerakan kapal yang berjarak 30 nautical miles (~50km) dari pelabuhan/pantai berbasis offline dan online.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: 20,
                  bottom: 20,
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/1AvFPyGI-8q6wqy0LZoZbaaZsVeuo63xw/view?usp=sharing"),
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
                'BENEFIT AIS CUBE',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'OPTIMALISASI & EFISIENSI',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Column(
              children: [
                _buildBenefitItem('Meningkatkan keselamatan pelabuhan',
                    Icons.directions_car_filled_rounded),
                _buildBenefitItem(
                    'Meningkatkan efisiesni operasional Pelabuhan',
                    Icons.settings),
                _buildBenefitItem(
                    'Meningkatkan manajemen lalu lintas kapal dan pelabuhan',
                    Icons.engineering_rounded),
                _buildBenefitItem(
                    'Memberikan informasi akurat tentang pergerakan kapal',
                    Icons.report_gmailerrorred),
                _buildBenefitItem(
                    'Membantu menghindari tabrakan pada saat sandar dan aktifitas',
                    FontAwesomeIcons.shield),
              ],
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'SISTEM INTEGRASI',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'MANAJEMEN PELABUHAN',
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
                _buildProductCard('Monitoring Kapal', FontAwesomeIcons.ship),
                _buildProductCard('Integrasi dengan CCTV', Icons.camera_alt),
                _buildProductCard('Offline & Online', Icons.wifi),
                _buildProductCard(
                    'Mobile & Desktop App', Icons.mobile_friendly),
              ],
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'SOFTWARE AIS',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'KELEBIHAN GEOTRAKING AIS',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Aplikasi dibuat oleh GEOSAT khusus untuk Monitoring AIS, sehingga dapat disesuaikan dengan kebutuhan pelanggan.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 7),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                '''
• Aplikasi Multi Platform (Dekstop, WebBase & Android Mobile)
• Memiliki fitur animasi Play Back pada saat menampilkan data history di Maps
• Dilengkapi dengan fitur Drawing & Geozone sebagai penanda zona kerka
• Pengguna dapat menandai kapal-kapal operasional melalui System Configurasi
• System Pelaporan & Analisa data history kapal di pelabuhan
• Terintegrasi dengan Kamera CCTV baik secara Streaming atau Image Capture
''',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: 20,
                  bottom: 20,
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/17w1H1GhK8whdjzfVN1lOURDjpJrkooMS/view?usp=sharing"),
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
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'PRODUK KAMI',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'PAKET AIS CUBE STATION KAMI',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Column(
              children: [
                _buildPackageItem(
                  "Paket AIS Cube",
                  "Online",
                  "Saya ingin memesan Paket AIS Cube Online.",
                ),
                _buildPackageItem(
                  "Paket AIS Cube",
                  "Lite",
                  "Saya ingin memesan Paket AIS Cube Lite.",
                ),
                _buildPackageItem(
                  "Paket AIS Cube",
                  "Pro",
                  "Saya ingin memesan Paket AIS Cube Pro.",
                ),
              ],
            ),
            SizedBox(height: 10),
            // Container(
            //   color: Colors.transparent,
            //   child: Padding(
            //     padding: const EdgeInsets.all(5),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.black54,
            //             blurRadius: 10.0,
            //             offset: Offset(0, 5),
            //           ),
            //         ],
            //       ),
            //       child: ClipRRect(
            //         borderRadius: AppDefaults.borderRadius,
            //         child: CachedNetworkImage(
            //           imageUrl: _convertDriveLink(
            //               "https://drive.google.com/file/d/1ZSCputfmRwuTKjKa_rJaT4vFaYSngwnM/view?usp=sharing"),
            //           width: double.infinity,
            //           fit: BoxFit.cover,
            //           placeholder: (context, url) => Container(
            //             width: double.infinity,
            //             color: Colors.white,
            //             child: Center(child: CircularProgressIndicator()),
            //           ),
            //           errorWidget: (context, url, error) => Container(
            //             color: Colors.white,
            //             child: Icon(Icons.error, color: Colors.red),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
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

Widget _buildBenefitItem(String title, IconData icon) {
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
          icon,
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

Widget _buildPackageItem(String title, String subtitle, String message) {
  return GestureDetector(
    onTap: () => _launchWhatsApp("6281908192559", message),
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
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Color.fromARGB(255, 243, 182, 100),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.purple.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  "Pesan Sekarang ",
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
  );
}

void _launchWhatsApp(String phoneNumber, String message) async {
  final String whatsappUrl =
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    throw "Could not launch $whatsappUrl";
  }
}
