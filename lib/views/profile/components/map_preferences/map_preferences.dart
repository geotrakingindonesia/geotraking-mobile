import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';

class MapPreferences extends StatefulWidget {
  const MapPreferences({Key? key}) : super(key: key);

  @override
  MapPreferencesState createState() => MapPreferencesState();
}

class MapPreferencesState extends State<MapPreferences> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Back'),
        leading: const AppBackButton(),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
