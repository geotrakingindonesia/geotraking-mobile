// import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/app_back_button.dart';

// class GeneralPreferences extends StatefulWidget {
//   const GeneralPreferences({Key? key}) : super(key: key);

//   @override
//   GeneralPreferencesState createState() => GeneralPreferencesState();
// }

// class GeneralPreferencesState extends State<GeneralPreferences> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Back'),
//         leading: const AppBackButton(),
//         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: Colors.black,
//             ),
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';

class GeneralPreferences extends StatefulWidget {
  const GeneralPreferences({Key? key}) : super(key: key);

  @override
  GeneralPreferencesState createState() => GeneralPreferencesState();
}

class GeneralPreferencesState extends State<GeneralPreferences> {
  // Dropdown selected values
  String _selectedDistance = 'Kilometers';
  String _selectedSpeed = 'Knots';
  String _selectedCoordinate = 'Degrees';

  // Radio selected value
  String _selectedTimezone = 'UTC';

  void _savePreferences() {
    // Add your save logic here
    print(
        'Preferences saved: Distance=$_selectedDistance, Speed=$_selectedSpeed, Coordinate=$_selectedCoordinate, Timezone=$_selectedTimezone');
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First box for Units Test
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Units Settings',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  // SizedBox(height: 8),
                  // // Distance Select
                  // DropdownButtonFormField<String>(
                  //   value: _selectedDistance,
                  //   items: ['Kilometers', 'Miles']
                  //       .map((distance) => DropdownMenuItem(
                  //             value: distance,
                  //             child: Text(distance),
                  //           ))
                  //       .toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _selectedDistance = value!;
                  //     });
                  //   },
                  //   decoration: InputDecoration(
                  //     labelText: 'Distance',
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),
                  SizedBox(height: 8),
                  // Speed Select
                  DropdownButtonFormField<String>(
                    value: _selectedSpeed,
                    items: ['Knots', 'Kilometer per Hour (Km/h)', 'Meter per Second (m/s)', 'Mile per Hour (mp/h)']
                        .map((speed) => DropdownMenuItem(
                              value: speed,
                              child: Text(speed),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSpeed = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Speed',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Coordinate Select
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            // Second box for Date Settings
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DateTime Settings',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  // UTC Radio Options
                  RadioListTile<String>(
                    title: const Text('UTC (Europe/London)'),
                    value: 'UTC',
                    groupValue: _selectedTimezone,
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
                    onChanged: (value) {
                      setState(() {
                        _selectedTimezone = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16), // Spacing between boxes and button
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
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // onUpdateProfile(_avatar);
                      //     onUpdateProfile();
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.black,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      //   child: Text(
                      //     'Update Profile',
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .titleSmall
                      //         ?.copyWith(
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
              // ElevatedButton(
              //   onPressed: _savePreferences,
              //   child: Text('Save'),
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              //     textStyle: TextStyle(fontSize: 16),
              //   ),
              // ),
          ],
        ),
      ),
    );
  }
}
