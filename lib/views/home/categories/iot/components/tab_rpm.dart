import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
// import 'package:geotraking/views/home/categories/iot/components/tab_card.dart';

class TabRpm extends StatefulWidget {
  const TabRpm({Key? key}) : super(key: key);

  @override
  _TabRpmState createState() => _TabRpmState();
}

String _convertDriveLink(String driveUrl) {
  final fileId = driveUrl.split('/d/')[1].split('/')[0];
  return 'https://drive.google.com/uc?export=view&id=$fileId';
}

class _TabRpmState extends State<TabRpm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
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
                          "https://drive.google.com/file/d/1rkT2KfZCAvLZynktuLueuFQJJiczTqC3/view?usp=sharing"),
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
                  // child: Container(
                  //   child: ClipRRect(
                  //     borderRadius: AppDefaults.borderRadius,
                  //     child: Image.asset(
                  //       'assets/images/banner_fuel.jpeg',
                  //       width: double.infinity,
                  //       fit: BoxFit.contain,
                  //     ),
                  //   ),
                  // ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text('Coming Soon'),
            )
            // Container(
            //   margin: EdgeInsets.only(left: 5),
            //   child: Text(
            //     'RPM Only',
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // TabCard(
            //   namaPaket: '2 RPM',
            //   kuota: '2 RPM',
            //   masaAktif: '2 RPM',
            // ),
            // TabCard(
            //   namaPaket: '4 RPM',
            //   kuota: '4 RPM',
            //   masaAktif: '4 RPM',
            // ),
            // SizedBox(height: 32),
            // Container(
            //   margin: EdgeInsets.only(left: 5),
            //   child: Text(
            //     'RPM With Connection',
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // TabCard(
            //   namaPaket: '2 RPM With Connection',
            //   kuota: '2 RPM With Connection',
            //   masaAktif: '2 RPM With Connection',
            // ),
            // TabCard(
            //   namaPaket: '4 RPM With Connection',
            //   kuota: '4 RPM With Connection',
            //   masaAktif: '4 RPM With Connection',
            // ),
            // SizedBox(height: 32),
            // Container(
            //   margin: EdgeInsets.only(left: 5),
            //   child: Text(
            //     'Calculate RPM',
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // TabCard(
            //   namaPaket: 'Calculate 2 RPM',
            //   kuota: 'Calculate 2 RPM',
            //   masaAktif: 'Calculate 2 RPM',
            // ),
            // TabCard(
            //   namaPaket: 'Calculate 4 RPM',
            //   kuota: 'Calculate 4 RPM',
            //   masaAktif: 'Calculate 4 RPM',
            // ),
            // SizedBox(height: 32),
            // Container(
            //   margin: EdgeInsets.only(left: 5),
            //   child: Text(
            //     'RPM With Request',
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // TabCard(
            //   namaPaket: '2 RPM With Request',
            //   kuota: '2 RPM With Request',
            //   masaAktif: '2 RPM With Request',
            // ),
            // TabCard(
            //   namaPaket: '4 RPM With Request',
            //   kuota: '4 RPM With Request',
            //   masaAktif: '4 RPM With Request',
            // ),
          ],
        ),
      ),
    );
  }
}
