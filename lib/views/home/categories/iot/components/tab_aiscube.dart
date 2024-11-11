import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/views/profile/support/components/tutorial_tile_pdf.dart';

class TabAiscube extends StatefulWidget {
  const TabAiscube({Key? key}) : super(key: key);

  @override
  _TabAiscubeState createState() => _TabAiscubeState();
}

class _TabAiscubeState extends State<TabAiscube> {
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
                        'assets/images/banner_fuel.jpeg',
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            TutorialTilePdf(
              title: 'Ais Cube Integration',
              pdfUrl: 'https://drive.google.com/file/d/1Qm0Uekf7jNJd0UkOCNeAXJikELOrSgyl/view?usp=sharing',
            ),
            SizedBox(height: 10,),
            Center(
              child: Text('Coming Soon'),
            ),
          ],
        ),
      ),
    );
  }
}
