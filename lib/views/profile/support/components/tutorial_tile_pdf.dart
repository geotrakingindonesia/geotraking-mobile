import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialTilePdf extends StatelessWidget {
  final String title;
  final String pdfUrl;

  const TutorialTilePdf({
    Key? key,
    required this.title,
    required this.pdfUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 98, 182, 183),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        onTap: () async {
          if (await canLaunch(pdfUrl)) {
            await launch(pdfUrl);
          } else {
            throw 'Could not launch $pdfUrl';
          }
        },
      ),
    );
  }
}
