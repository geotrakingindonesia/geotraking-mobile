// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/routes/app_routes.dart';
import 'package:geotraking/core/services/vessel_service.dart';

import 'profile_list_tile.dart';

class ProfileMemberMenuOptions extends StatefulWidget {
  final String selectedLanguage;
  const ProfileMemberMenuOptions({
    Key? key,
    required this.selectedLanguage,
  }) : super(key: key);
  @override
  _ProfileMemberMenuOptionsState createState() =>
      _ProfileMemberMenuOptionsState();
}

class _ProfileMemberMenuOptionsState extends State<ProfileMemberMenuOptions> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          children: [
            ProfileListTile(
              title: Localization.getKapalKu(widget.selectedLanguage),
              icon: FontAwesomeIcons.ship,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.myProfileKapal),
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            ProfileListTile(
              title: Localization.getTrackKapalKu(widget.selectedLanguage),
              icon: FontAwesomeIcons.locationCrosshairs,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.myProfileTrackKapal),
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            ProfileListTile(
              title: Localization.getTroubleshoot(widget.selectedLanguage),
              icon: Icons.troubleshoot,
              onTap: () => Navigator.pushNamed(
                  context, AppRoutes.troubleshootMemberPage),
            ),
            // const Divider(
            //   thickness: 0.5,
            //   color: Colors.black,
            // ),
            // ProfileListTile(
            //   title: Localization.getTransaction(widget.selectedLanguage),
            //   icon: FontAwesomeIcons.moneyBillWave,
            //   onTap: () =>
            //       Navigator.pushNamed(context, AppRoutes.transactionPage),
            // ),
            
          ],
        ),
      ),
    );
  }
}
