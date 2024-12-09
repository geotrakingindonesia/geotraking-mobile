import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';

class SetGeofencing extends StatefulWidget {
  const SetGeofencing({Key? key}) : super(key: key);

  @override
  SetGeofencingState createState() => SetGeofencingState();
}

class SetGeofencingState extends State<SetGeofencing> {
  
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
