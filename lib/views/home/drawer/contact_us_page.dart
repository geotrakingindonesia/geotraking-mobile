// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/constants/app_icons.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final MapController mapController = MapController();

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
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(Localization.getContactUs(_selectedLanguage)),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.cardColor,
      body: FadeInUp(
        duration: Duration(milliseconds: 1000),
        child: Container(
          margin:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 250),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            vertical: AppDefaults.padding * 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: AppDefaults.borderRadius,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppIcons.contactPhone),
                  const SizedBox(width: AppDefaults.padding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '(+62) 21 420-5318/19',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: AppDefaults.padding / 2),
                      Text(
                        '(021) 4205309',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppDefaults.padding),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.contactEmail),
                  const SizedBox(width: AppDefaults.padding),
                  Text(
                    'sales@geosat.co.id',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppDefaults.padding),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.contactMap),
                  const SizedBox(width: AppDefaults.padding),
                  Text(
                    'Jl. Bungur Besar Raya No. 85A\nKemayoran Jakarta 10620',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: mapController,
                        options: const MapOptions(
                          initialCenter:
                              LatLng(-6.165789676357651, 106.84202251363632),
                          initialZoom: 16,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          const MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(
                                    -6.165789676357651, 106.84202251363632),
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
