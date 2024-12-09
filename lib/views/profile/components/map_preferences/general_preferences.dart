// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_super_parameters, avoid_print, use_build_context_synchronously

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geotraking/core/components/app_back_button.dart';

class GeneralPreferences extends StatefulWidget {
  const GeneralPreferences({Key? key}) : super(key: key);

  @override
  GeneralPreferencesState createState() => GeneralPreferencesState();
}

class GeneralPreferencesState extends State<GeneralPreferences> {
  String _selectedSpeed = 'Knots';
  String _selectedCoordinate = 'Degrees';
  String _selectedTimezone = 'UTC+7';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedSpeed = prefs.getString('SetSpeedPreferences') ?? 'Knots';
      _selectedCoordinate =
          prefs.getString('SetCoordinatePreferences') ?? 'Degrees';
      _selectedTimezone = prefs.getString('SetTimezonePreferences') ?? 'UTC+7';
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('SetSpeedPreferences', _selectedSpeed);
    await prefs.setString('SetCoordinatePreferences', _selectedCoordinate);
    await prefs.setString('SetTimezonePreferences', _selectedTimezone);

    ElegantNotification.success(
      title: Text('Preferences Saved', style: TextStyle(color: Colors.white)),
      description: Text('Your preferences have been saved successfully.',
          style: TextStyle(color: Colors.white)),
      icon: Icon(Icons.check_circle, color: Colors.white),
      background: Colors.transparent,
      position: Alignment.topCenter,
      animation: AnimationType.fromTop,
      showProgressIndicator: false,
      displayCloseButton: false,
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      borderRadius: BorderRadius.circular(10),
    ).show(context);

    print(
        'Preferences saved: Speed=$_selectedSpeed, Coordinate=$_selectedCoordinate, Timezone=$_selectedTimezone');
  }

  final Map<String, String> speedOptions = {
    'Knots': 'Knots',
    'Km/h': 'Kilometer per Hour (Km/h)',
    'm/s': 'Meter per Second (m/s)',
    'mp/h': 'Mile per Hour (mp/h)'
  };

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
        centerTitle: false,
      ),
      
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 122, 178, 178),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Units Settings',
                      style: Theme.of(context).textTheme.titleMedium),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedSpeed,
                    items: speedOptions.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    // items: [
                    //   'Knots',
                    //   'Kilometer per Hour (Km/h)',
                    //   'Meter per Second (m/s)',
                    //   'Mile per Hour (mp/h)'
                    // ]
                    //     .map((speed) => DropdownMenuItem(
                    //           value: speed,
                    //           child: Text(speed),
                    //         ))
                    //     .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSpeed = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Speed',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedCoordinate,
                    items: ['Degrees', 'Decimal']
                        .map((coordinate) => DropdownMenuItem(
                              value: coordinate,
                              child: Text(coordinate),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCoordinate = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Coordinate',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 122, 178, 178),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DateTime Settings',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  RadioListTile<String>(
                    title: const Text('UTC (Europe/London)'),
                    value: 'UTC',
                    groupValue: _selectedTimezone,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _selectedTimezone = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('UTC+7 (Asia/Jakarta)'),
                    value: 'UTC+7',
                    groupValue: _selectedTimezone,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _selectedTimezone = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('UTC+8 (Asia/Makassar)'),
                    value: 'UTC+8',
                    groupValue: _selectedTimezone,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _selectedTimezone = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('UTC+9 (Asia/Jayapura)'),
                    value: 'UTC+9',
                    groupValue: _selectedTimezone,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _selectedTimezone = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: _savePreferences,
                        child: Text(
                          'Save',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
        ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       Container(
      //         padding: EdgeInsets.all(16),
      //         margin: EdgeInsets.only(bottom: 16),
      //         decoration: BoxDecoration(
      //           color: Color.fromARGB(255, 122, 178, 178),
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text('Units Settings',
      //                 style: Theme.of(context).textTheme.titleMedium),
      //             Divider(
      //               color: Colors.black,
      //             ),
      //             SizedBox(height: 8),
      //             DropdownButtonFormField<String>(
      //               value: _selectedSpeed,
      //               items: speedOptions.entries.map((entry) {
      //                 return DropdownMenuItem(
      //                   value: entry.key,
      //                   child: Text(entry.value),
      //                 );
      //               }).toList(),
      //               // items: [
      //               //   'Knots',
      //               //   'Kilometer per Hour (Km/h)',
      //               //   'Meter per Second (m/s)',
      //               //   'Mile per Hour (mp/h)'
      //               // ]
      //               //     .map((speed) => DropdownMenuItem(
      //               //           value: speed,
      //               //           child: Text(speed),
      //               //         ))
      //               //     .toList(),
      //               onChanged: (value) {
      //                 setState(() {
      //                   _selectedSpeed = value!;
      //                 });
      //               },
      //               decoration: InputDecoration(
      //                 labelText: 'Speed',
      //                 labelStyle: TextStyle(color: Colors.black),
      //                 border: OutlineInputBorder(
      //                   borderSide: BorderSide(color: Colors.black),
      //                 ),
      //                 enabledBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(color: Colors.black),
      //                 ),
      //                 focusedBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(color: Colors.black, width: 2),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: 8),
      //             DropdownButtonFormField<String>(
      //               value: _selectedCoordinate,
      //               items: ['Degrees', 'Decimal']
      //                   .map((coordinate) => DropdownMenuItem(
      //                         value: coordinate,
      //                         child: Text(coordinate),
      //                       ))
      //                   .toList(),
      //               onChanged: (value) {
      //                 setState(() {
      //                   _selectedCoordinate = value!;
      //                 });
      //               },
      //               decoration: InputDecoration(
      //                 labelText: 'Coordinate',
      //                 labelStyle: TextStyle(color: Colors.black),
      //                 border: OutlineInputBorder(
      //                   borderSide: BorderSide(color: Colors.black),
      //                 ),
      //                 enabledBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(color: Colors.black),
      //                 ),
      //                 focusedBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(color: Colors.black, width: 2),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         padding: EdgeInsets.all(16),
      //         decoration: BoxDecoration(
      //           color: Color.fromARGB(255, 122, 178, 178),
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               'DateTime Settings',
      //               style: Theme.of(context).textTheme.titleMedium,
      //             ),
      //             Divider(
      //               color: Colors.black,
      //             ),
      //             RadioListTile<String>(
      //               title: const Text('UTC (Europe/London)'),
      //               value: 'UTC',
      //               groupValue: _selectedTimezone,
      //               activeColor: Colors.black,
      //               onChanged: (value) {
      //                 setState(() {
      //                   _selectedTimezone = value!;
      //                 });
      //               },
      //             ),
      //             RadioListTile<String>(
      //               title: const Text('UTC+7 (Asia/Jakarta)'),
      //               value: 'UTC+7',
      //               groupValue: _selectedTimezone,
      //               activeColor: Colors.black,
      //               onChanged: (value) {
      //                 setState(() {
      //                   _selectedTimezone = value!;
      //                 });
      //               },
      //             ),
      //             RadioListTile<String>(
      //               title: const Text('UTC+8 (Asia/Makassar)'),
      //               value: 'UTC+8',
      //               groupValue: _selectedTimezone,
      //               activeColor: Colors.black,
      //               onChanged: (value) {
      //                 setState(() {
      //                   _selectedTimezone = value!;
      //                 });
      //               },
      //             ),
      //             RadioListTile<String>(
      //               title: const Text('UTC+9 (Asia/Jayapura)'),
      //               value: 'UTC+9',
      //               groupValue: _selectedTimezone,
      //               activeColor: Colors.black,
      //               onChanged: (value) {
      //                 setState(() {
      //                   _selectedTimezone = value!;
      //                 });
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: 16),
      //       Row(
      //         children: [
      //           Expanded(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.end,
      //               children: [
      //                 ElevatedButton(
      //                   onPressed: _savePreferences,
      //                   child: Text(
      //                     'Save',
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .titleSmall
      //                         ?.copyWith(
      //                             fontWeight: FontWeight.bold,
      //                             color: Colors.white),
      //                   ),
      //                   style: ElevatedButton.styleFrom(
      //                     backgroundColor: Colors.black,
      //                     shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(10),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
