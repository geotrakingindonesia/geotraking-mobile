// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/views/profile/support/components/tutorial_tile.dart';
import 'package:geotraking/views/profile/support/components/tutorial_tile_pdf.dart';
import 'package:geotraking/views/profile/support/components/tutorial_tile_teks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialPack extends StatefulWidget {
  const TutorialPack({
    Key? key,
  }) : super(key: key);

  @override
  _TutorialPackState createState() => _TutorialPackState();
}

class _TutorialPackState extends State<TutorialPack> {
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
    return FadeInDown(
        duration: Duration(milliseconds: 1000),
        child: ListView(
          padding: EdgeInsets.only(top: 8),
          children: [
            TutorialTile(
              title: Localization.getTabTutorialBluetrakerHelpCenter(
                  _selectedLanguage),
              videoUrl: 'https://www.youtube.com/watch?v=J83HiFOWYrA',
            ),
            TutorialTile(
              title: Localization.getTabTutorialSmartoneHelpCenter(
                  _selectedLanguage),
              videoUrl: 'https://www.youtube.com/watch?v=Yg4hyn4Kbc8',
            ),
            TutorialTilePdf(
              title: Localization.getTabTutorialCheckVMSBluetraker(
                  _selectedLanguage),
              pdfUrl:
                  'https://drive.google.com/file/d/1uSPjXUV4MS0n0-EouSQNvkE2g4Z367Yn/view?usp=sharing',
            ),
            TutorialTilePdf(
              title: Localization.getTabTutorialCheckSmartoneSolar(
                  _selectedLanguage),
              pdfUrl:
                  'https://drive.google.com/file/d/1TgN-jzGY2o_TvUH6a9vnNuh7xHdC0wS4/view?usp=sharing',
            ),
            TutorialTilePdf(
              title: Localization.getTabTutorialInstallationVisionTrak(
                  _selectedLanguage),
              pdfUrl:
                  'https://drive.google.com/file/d/14xtNLamirwIiRg_lKhxIq1tRW6lwUH7p/view?usp=sharing',
            ),
            TutorialTilePdf(
              title: 'Ais Cube Integration',
              pdfUrl:
                  'https://drive.google.com/file/d/1Qm0Uekf7jNJd0UkOCNeAXJikELOrSgyl/view?usp=sharing',
            ),
            TutorialTile(
              title: 'Dukungan Iridium GO!',
              videoUrl: 'https://youtu.be/_R2nRaFz7lc',
            ),
            TutorialTileTeks(
              title: 'Iridium 9555 Pemecahan Masalah',
            ),
          ],
        ));
  }
}
