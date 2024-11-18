// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/constants.dart';
import 'package:geotraking/core/routes/app_routes.dart';
import 'package:geotraking/views/profile/components/profile_list_tile.dart';

class VmsMonitoringKkpSetting extends StatefulWidget {
  VmsMonitoringKkpSetting({super.key});

  @override
  _VmsMonitoringKkpSettingState createState() =>
      _VmsMonitoringKkpSettingState();
}

class _VmsMonitoringKkpSettingState extends State<VmsMonitoringKkpSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Back'),
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
                      title: 'Website',
                      icon: Icons.web_outlined,
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.vmsWebsiteSetting),
                    ),
                    Divider(),
                    ProfileListTile(
                      title: 'Database',
                      icon: FontAwesomeIcons.database,
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.vmsDatabaseSetting),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
