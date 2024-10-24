// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/views/profile/report/jaraktempuh/components/vessel_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JaraktempuhPage extends StatefulWidget {
  const JaraktempuhPage({super.key});

  @override
  _JaraktempuhPageState createState() => _JaraktempuhPageState();
}

class _JaraktempuhPageState extends State<JaraktempuhPage> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Localization.jarakTempuh(_selectedLanguage)),
        leading: const AppBackButton(), 
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        backgroundColor: Colors.white,
      ),
      body: const VesselList(),
    );
  }
}
