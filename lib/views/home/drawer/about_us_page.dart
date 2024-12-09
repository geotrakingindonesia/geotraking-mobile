// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/views/profile/support/components/tutorial_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(Localization.getAboutUs(_selectedLanguage)),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDefaults.padding),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return FadeInLeft(
                duration: Duration(milliseconds: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Localization.getTeksAboutUs(_selectedLanguage),
                      textAlign: TextAlign.justify,
                    ),
                    TutorialTile(
                      title: 'Geotraking Mobile Application',
                      videoUrl: 'https://youtu.be/oH5AQY6HDfc',
                    ),
                    Divider(),
                    Text(
                      Localization.getTextVersiApk(_selectedLanguage),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
