// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
// import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/views/profile/components/profile_kapal_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileKapalPage extends StatefulWidget {
  const ProfileKapalPage({super.key});

  @override
  _ProfileKapalPageState createState() => _ProfileKapalPageState();
}

class _ProfileKapalPageState extends State<ProfileKapalPage> {
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

  void _launchWhatsApp() async {
    final namaKapal = 'Kapal A';
    final snImeiId = '123456789 (SN/IMEI/ID)';
    final owner = 'John Doe';

    final message = '''
Hi Admin,
Saya mengajukan beberapa kapal yang saya miliki,
berikut data kapalnya:

Nama Kapal: $namaKapal
SN/IMEI/ID: $snImeiId
Owner: $owner
''';

    final phoneNumber = '6281384197696';
    final whatsappUrl =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.scaffoldWithBoxBackground,
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Text(Localization.getKapalKu(_selectedLanguage)),
        leading: const AppBackButton(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Localization.getKapalKu(_selectedLanguage)),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 127, 183, 126),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.message, color: Colors.white),
                onPressed: _launchWhatsApp,
                tooltip: 'Contact Admin via WhatsApp',
              ),
            ),
          ],
        ),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        backgroundColor: Colors.white,
      ),
      body: const ProfileKapalList(),
    );
  }
}
