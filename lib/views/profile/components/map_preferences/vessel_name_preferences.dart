// import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/app_back_button.dart';
// import 'package:geotraking/views/entrypoint/entrypoint_ui.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class VesselName extends StatefulWidget {
//   const VesselName({Key? key}) : super(key: key);

//   @override
//   VesselNameState createState() => VesselNameState();
// }

// class VesselNameState extends State<VesselName> {
//   String _optionalTool = 'Hide';
//   final List<String> _tool = ['Hide', 'Show'];

//   @override
//   void initState() {
//     super.initState();
//     _loadToolFromSharedPreferences();
//   }

//   Future<void> _saveToolToSharedPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('vesselNamePreference', _optionalTool);
//   }

//   Future<void> _loadToolFromSharedPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _optionalTool = prefs.getString('vesselNamePreference') ?? 'Hide';
//     });
//   }

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
//       body: Padding(
//         padding: const EdgeInsets.only(
//           left: 15,
//           right: 15,
//           top: 15,
//         ),
//         child: Column(
//           children: _tool.map((tool) {
//             return RadioListTile<String>(
//               title: Text(tool),
//               value: tool,
//               groupValue: _optionalTool,
//               onChanged: (value) {
//                 setState(() {
//                   _optionalTool = value!;
//                 });
//                 _saveToolToSharedPreferences();
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const EntryPointUI(),
//                   ),
//                 );
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/views/entrypoint/entrypoint_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VesselName extends StatefulWidget {
  const VesselName({Key? key}) : super(key: key);

  @override
  VesselNameState createState() => VesselNameState();
}

class VesselNameState extends State<VesselName> {
  String _optionalTool = 'Hide';
  final List<String> _tool = ['Hide', 'Show'];

  @override
  void initState() {
    super.initState();
    _loadToolFromSharedPreferences();
  }

  Future<void> _saveToolToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('vesselNamePreference', _optionalTool);
  }

  Future<void> _loadToolFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _optionalTool = prefs.getString('vesselNamePreference') ?? 'Hide';
    });
  }

  Future<void> _showConfirmationDialog(String value) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text(
            value == 'Show'
                ? 'Do you agree to display the vessel name on the map?'
                : 'Do you agree to hide the vessel name on the map?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _optionalTool = value;
                });
                _saveToolToSharedPreferences();
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EntryPointUI(),
                  ),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
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
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
        ),
        child: Column(
          children: _tool.map((tool) {
            return RadioListTile<String>(
              title: Text(tool),
              value: tool,
              groupValue: _optionalTool,
              onChanged: (value) {
                _showConfirmationDialog(value!);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
