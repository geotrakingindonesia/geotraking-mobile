// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/views/profile/apn/components/profile_kapal_apn_list.dart';

class ProfileKapalAPNPage extends StatefulWidget {
  const ProfileKapalAPNPage({super.key});

  @override
  _ProfileKapalAPNPageState createState() => _ProfileKapalAPNPageState();
}

class _ProfileKapalAPNPageState extends State<ProfileKapalAPNPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        title: const Text('Kapal-Ku (APN)'),
        leading: const AppBackButton(),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      body: const ProfileKapalAPNList(),
    );
  }
}