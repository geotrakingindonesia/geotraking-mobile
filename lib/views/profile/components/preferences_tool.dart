// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/constants/constants.dart';
import 'package:geotraking/core/routes/app_routes.dart';
import 'package:geotraking/views/profile/components/profile_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesTool extends StatefulWidget {
  PreferencesTool({super.key});

  @override
  _PreferencesToolState createState() => _PreferencesToolState();
}

class _PreferencesToolState extends State<PreferencesTool> {
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
      // backgroundColor: AppColors.scaffoldWithBoxBackground,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Preferences'),
        leading: const AppBackButton(),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    ProfileListTile(
                      title: 'General',
                      icon: Icons.info,
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.generalPreferences),
                    ),
                    Divider(),
                    // ProfileListTile(
                    //   title: 'Map',
                    //   icon: Icons.info,
                    //   onTap: () => Navigator.pushNamed(
                    //       context, AppRoutes.mapPreferences),
                    // ),
                    // Divider(),
                    // ProfileListTile(
                    //   title: 'Geofencing',
                    //   icon: Icons.info,
                    //   onTap: () => Navigator.pushNamed(
                    //       context, AppRoutes.setGeofencing),
                    // ),
                    // Divider(),
                  ],
                ),
              ),
            ),
            // Center(child: Text('Coming soon'),)
          ],
        ),
      ),
    );
  }
}
