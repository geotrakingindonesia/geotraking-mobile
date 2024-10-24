import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
class TabStarlink extends StatefulWidget {
  const TabStarlink({Key? key}) : super(key: key);

  @override
  _TabStarlinkState createState() => _TabStarlinkState();
}

class _TabStarlinkState extends State<TabStarlink> {
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
                  child: Container(
                    child: ClipRRect(
                      borderRadius: AppDefaults.borderRadius,
                      child: Image.asset(
                        'assets/images/banner_starlink.jpeg',
                        width: double.infinity,
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
    );
  }
}
