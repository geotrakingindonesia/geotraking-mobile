import 'package:flutter/material.dart';
import 'package:geotraking/core/components/banner_rekening.dart';
import 'package:geotraking/views/home/categories/topup/components/product_category.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_card.dart';

class TabGlobalstar extends StatefulWidget {
  const TabGlobalstar({Key? key}) : super(key: key);

  @override
  _TabGlobalstarState createState() => _TabGlobalstarState();
}

class _TabGlobalstarState extends State<TabGlobalstar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Tracking',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            // SizedBox(height: 16),
            // TabCard(),
            // TabCard(),
            // SizedBox(height: 32),
            Text(
              'Pulsa',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            // TabCard(),
            // TabCard(),
            SizedBox(height: 32),
            Text(
              'Broadband Marine',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            // TabCard(),
            // TabCard(),
            SizedBox(height: 32),
            
            BannerRekening(),
            ProductCategory(categori: 'globalstar',),
          ],
        ),
      ),
    );
  }
}
