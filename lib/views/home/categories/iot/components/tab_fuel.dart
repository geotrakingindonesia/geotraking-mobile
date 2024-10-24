import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/views/home/categories/iot/components/tab_card.dart';

class TabFuel extends StatefulWidget {
  const TabFuel({Key? key}) : super(key: key);

  @override
  _TabFuelState createState() => _TabFuelState();
}

class _TabFuelState extends State<TabFuel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Container(
                    child: ClipRRect(
                      borderRadius: AppDefaults.borderRadius,
                      child: Image.asset(
                        'assets/images/banner_fuel.jpeg',
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Fuel Monitoring Only',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            TabCard(
              namaPaket: '2 Fuel Monitoring',
              kuota: '2 Fuel Monitoring',
              masaAktif: '2 Fuel Monitoring',
            ),
            TabCard(
              namaPaket: '4 Fuel Monitoring',
              kuota: '4 Fuel Monitoring',
              masaAktif: '4 Fuel Monitoring',
            ),
            SizedBox(height: 32),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Fuel Monitoring With Connection',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            TabCard(
              namaPaket: '2 Fuel Monitoring',
              kuota: '2 Fuel Monitoring',
              masaAktif: '2 Fuel Monitoring',
            ),
            TabCard(
              namaPaket: '4 Fuel Monitoring',
              kuota: '4 Fuel Monitoring',
              masaAktif: '4 Fuel Monitoring',
            ),
            SizedBox(height: 32),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Calculate Fuel Monitoring',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            TabCard(
              namaPaket: '2 Fuel Monitoring',
              kuota: '2 Fuel Monitoring',
              masaAktif: '2 Fuel Monitoring',
            ),
            TabCard(
              namaPaket: '4 Fuel Monitoring',
              kuota: '4 Fuel Monitoring',
              masaAktif: '4 Fuel Monitoring',
            ),
            SizedBox(height: 32),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Fuel Monitoring With Request',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            TabCard(
              namaPaket: '2 Fuel Monitoring',
              kuota: '2 Fuel Monitoring',
              masaAktif: '2 Fuel Monitoring',
            ),
            TabCard(
              namaPaket: '4 Fuel Monitoring',
              kuota: '4 Fuel Monitoring',
              masaAktif: '4 Fuel Monitoring',
            ),
          ],
        ),
      ),
    );
  }
}
