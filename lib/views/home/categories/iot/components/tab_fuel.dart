import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
// import 'package:geotraking/views/home/categories/iot/components/tab_card.dart';

class TabFuel extends StatefulWidget {
  const TabFuel({Key? key}) : super(key: key);

  @override
  _TabFuelState createState() => _TabFuelState();
}

String _convertDriveLink(String driveUrl) {
  final fileId = driveUrl.split('/d/')[1].split('/')[0];
  return 'https://drive.google.com/uc?export=view&id=$fileId';
}

class _TabFuelState extends State<TabFuel> {
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
            SizedBox(height: 20,),
            
            Center(
              child: Text('Coming Soon'),
            )
            // Container(
            //   margin: EdgeInsets.only(left: 5),
            //   child: Text(
            //     'Fuel Monitoring Only',
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // TabCard(
            //   namaPaket: 'Fuel Monitoring',
            //   kuota: 'Sensor Competible RPM, Coreolis dan Ovalgear',
            //   masaAktif: 'Contact: 081234567890',
            // ),
            // TabCard(
            //   namaPaket: 'Fuel Monitoring AI',
            //   kuota: 'Laporan analitik menggunakan AI',
            //   masaAktif: 'Contact: 081234567890',
            // ),
            // SizedBox(height: 32),
            // Container(
            //   margin: EdgeInsets.only(left: 5),
            //   child: Text(
            //     'Fuel Monitoring With Connection',
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // TabCard(
            //   namaPaket: '2 Fuel Monitoring',
            //   kuota: '2 Fuel Monitoring',
            //   masaAktif: '2 Fuel Monitoring',
            // ),
            // TabCard(
            //   namaPaket: '4 Fuel Monitoring',
            //   kuota: '4 Fuel Monitoring',
            //   masaAktif: '4 Fuel Monitoring',
            // ),
            // SizedBox(height: 32),
            // Container(
            //   margin: EdgeInsets.only(left: 5),
            //   child: Text(
            //     'Calculate Fuel Monitoring',
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // TabCard(
            //   namaPaket: '2 Fuel Monitoring',
            //   kuota: '2 Fuel Monitoring',
            //   masaAktif: '2 Fuel Monitoring',
            // ),
            // TabCard(
            //   namaPaket: '4 Fuel Monitoring',
            //   kuota: '4 Fuel Monitoring',
            //   masaAktif: '4 Fuel Monitoring',
            // ),
            // SizedBox(height: 32),
            // Container(
            //   margin: EdgeInsets.only(left: 5),
            //   child: Text(
            //     'Fuel Monitoring With Request',
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // TabCard(
            //   namaPaket: '2 Fuel Monitoring',
            //   kuota: '2 Fuel Monitoring',
            //   masaAktif: '2 Fuel Monitoring',
            // ),
            // TabCard(
            //   namaPaket: '4 Fuel Monitoring',
            //   kuota: '4 Fuel Monitoring',
            //   masaAktif: '4 Fuel Monitoring',
            // ),
          ],
        ),
      ),
    );
  }
}
