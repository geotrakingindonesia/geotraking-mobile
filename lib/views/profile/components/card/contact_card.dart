import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatefulWidget {
  const ContactCard({Key? key}) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadLanguageFromSharedPreferences();
  }

  _loadLanguageFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('language');
    if (language != null) {
      setState(() {
        _selectedLanguage = language;
      });
    }
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                Localization.getContactUs(_selectedLanguage),
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 16.0, left: 16, bottom: 16, top: 10),
            child: Container(
              padding: EdgeInsets.all(16),
              // decoration: BoxDecoration(
              //   color: Colors.green,
              //   borderRadius: BorderRadius.circular(8),
              //   boxShadow: [
              //     BoxShadow(
              //         color: Colors.grey.shade400,
              //         blurRadius: 5,
              //         spreadRadius: 1),
              //   ],
              // ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft, // Mulai dari kiri
                  end: Alignment.centerRight, // Arahkan ke kanan
                  colors: [
                    Color.fromARGB(255, 22, 66, 60),
                    // Color.fromARGB(255, 106, 156, 137),
                    // Color.fromARGB(255, 196, 218, 210)
                    Colors.greenAccent
                  ], 
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),

              child: Row(
                children: [
                  Icon(FontAwesomeIcons.whatsapp,
                      size: 40, color: Colors.white),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Geosat',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '+6281908192559',
                        style: TextStyle(color: Colors.white60, fontSize: 14),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onPressed: () => _launchUrl(
                        'https://wa.me/6281908192559?text=Hallo+Geomatika+Satelit+Indonesia'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
