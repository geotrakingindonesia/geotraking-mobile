// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/routes/app_routes.dart';
import 'package:geotraking/views/profile/components/profile_list_tile.dart';

class ProfileAPNMenuOptions extends StatelessWidget {
  const ProfileAPNMenuOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          children: [
            ProfileListTile(
              title: 'Kapal-Ku',
              icon: FontAwesomeIcons.ship,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.myProfileKapalApn),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            ProfileListTile(
              title: 'Track Kapal-Ku',
              icon: FontAwesomeIcons.locationCrosshairs,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.myProfileTrackKapalAPN),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            // SizedBox(
            //   height: 5,
            // ),
            ProfileListTile(
              title: 'Notification',
              icon: Icons.notifications,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.notificationPage),
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            // SizedBox(
            //   height: 5,
            // ),
            ProfileListTile(
              title: 'Pusat Bantuan',
              icon: Icons.live_help_outlined,
              onTap: () => Navigator.pushNamed(context, AppRoutes.supportPage),
            ),
            // SizedBox(
            //   height: 5,
            // ),
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
