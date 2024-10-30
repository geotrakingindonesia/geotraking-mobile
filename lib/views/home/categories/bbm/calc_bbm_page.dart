// ignore_for_file: library_private_types_in_public_api, unnecessary_brace_in_string_interps, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/custom_tab_label.dart';
// import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/views/home/categories/bbm/components/bbm_kapal.dart';
import 'package:geotraking/views/home/categories/bbm/components/bbm_kapal_jam.dart';
import 'package:geotraking/views/home/categories/bbm/components/solar_manual.dart';

class CalculateBbmPage extends StatefulWidget {
  const CalculateBbmPage({super.key});

  @override
  _CalculateBbmPageState createState() => _CalculateBbmPageState();
}

class _CalculateBbmPageState extends State<CalculateBbmPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Hitung BBM Kapal'),
          titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
              ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 196, 218, 210),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Color.fromARGB(255, 106, 156, 137),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    CustomTabLabel(label: 'Solar Manual'),
                    CustomTabLabel(label: 'Cara Cepat'),
                    CustomTabLabel(label: 'Per-Jam'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          color: AppColors.cardColor,
          child: const TabBarView(
            children: [
              SolarManualPage(),
              BbmKapalPage(),
              BbmKapalPerJamPage(),
            ],
          ),
        ),
      ),
    );
  }
}
