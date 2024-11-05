// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/routes/app_routes.dart';
import 'package:geotraking/views/profile/components/profile_list_tile.dart';

class ProfileAdminMenuOptions extends StatelessWidget {
  final String selectedLanguage;
  const ProfileAdminMenuOptions({
    Key? key, required this.selectedLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          children: [
            ProfileListTile(
              title: Localization.getKapalKu(selectedLanguage),
              icon: FontAwesomeIcons.ship,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.myProfileKapalGeosat),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // const Divider(
            //   thickness: 0.5,
            //   color: Colors.black,
            // ),
            // ProfileListTile(
            //   title: Localization.getTrackKapalKu(selectedLanguage),
            //   icon: FontAwesomeIcons.locationCrosshairs,
            //   onTap: () =>
            //       Navigator.pushNamed(context, AppRoutes.myProfileTrackKapalGeosat),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // const Divider(
            //   thickness: 0.5,
            //   color: Colors.black,
            // ),
            // ProfileListTile(
            //   title: 'TroubleShoot Member',
            //   icon: Icons.troubleshoot,
            //   onTap: () => Navigator.pushNamed(
            //       context, AppRoutes.troubleshootAdminPage),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // ProfileListTile(
            //   title: 'Buat notifikasi',
            //   icon: Icons.notification_add_rounded,
            //   onTap: () => Navigator.pushNamed(
            //       context, AppRoutes.troubleshootAdminPage),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // ProfileListTile(
            //   title: 'Status Payment',
            //   icon: Icons.history,
            //   onTap: () =>
            //       Navigator.pushNamed(context, AppRoutes.historyPembayaranPage),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // const Divider(
            //   thickness: 0.5,
            //   color: Colors.black,
            // ),
            // // SizedBox(
            // //   height: 5,
            // // ),
            // ProfileListTile(
            //   title: Localization.getNotification(selectedLanguage),
            //   icon: Icons.notifications,
            //   onTap: () =>
            //       Navigator.pushNamed(context, AppRoutes.notificationPage),
            // ),
            // // SizedBox(
            // //   height: 5,
            // // ),
            // const Divider(
            //   thickness: 0.5,
            //   color: Colors.black,
            // ),
            // ProfileListTile(
            //   title: Localization.getHelpCenter(selectedLanguage),
            //   icon: Icons.live_help_outlined,
            //   onTap: () => Navigator.pushNamed(context, AppRoutes.supportPage),
            // ),
            
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            ProfileListTile(
              title: Localization.logBook(selectedLanguage),
              icon: Icons.archive,
              onTap: () => Navigator.pushNamed(
                  context, AppRoutes.logBookHasilPenangkapan),
            ),
            // const Divider(
            //   thickness: 0.5,
            //   color: Colors.black,
            // ),
            // ProfileListTile(
            //   title: 'Histori Tangkapan',
            //   icon: Icons.history,
            //   onTap: () => Navigator.pushNamed(
            //       context, AppRoutes.logBookHistoryHasilPenangkapan),
            // ),
            // ProfileListTile(
            //   title: Localization.getTroubleshoot(selectedLanguage),
            //   icon: Icons.troubleshoot,
            //   onTap: () => Navigator.pushNamed(
            //       context, AppRoutes.troubleshootMemberPage),
            // ),
            // const Divider(
            //   thickness: 0.5,
            //   color: Colors.black,
            // ),
            // ProfileListTile(
            //   title: Localization.getTroubleshoot(selectedLanguage),
            //   icon: Icons.troubleshoot,
            //   onTap: () => Navigator.pushNamed(
            //       context, AppRoutes.troubleshootMemberPage),
            // ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            ProfileListTile(
              title: Localization.getHelpCenter(selectedLanguage),
              icon: Icons.live_help_outlined,
              onTap: () => Navigator.pushNamed(context, AppRoutes.supportPage),
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            ProfileListTile(
              title: Localization.getSetting(selectedLanguage),
              icon: Icons.settings,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.settingMyProfile),
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            // const Divider(
            //   thickness: 0.5,
            //   color: Colors.black,
            // ),
            // SizedBox(
            //   height: 5,
            // ),
          ],
        ),
      ),
    );
  }
}
