// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/views/profile/geosat/components/profile_kapal_geosat_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileKapalGeosatPage extends StatefulWidget {
  const ProfileKapalGeosatPage({super.key});

  @override
  _ProfileKapalGeosatPageState createState() => _ProfileKapalGeosatPageState();
}

class _ProfileKapalGeosatPageState extends State<ProfileKapalGeosatPage> {
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
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        title: Text(Localization.getKapalKu(_selectedLanguage)),
        leading: const AppBackButton(),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
            centerTitle: false,
      ),
      body: ProfileKapalGeosatList(),
    );
  }
}
