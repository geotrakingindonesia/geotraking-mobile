import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/views/entrypoint/entrypoint_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetFormatSpeed extends StatefulWidget {
  const SetFormatSpeed({Key? key}) : super(key: key);

  @override
  SetFormatSpeedState createState() => SetFormatSpeedState();
}

class SetFormatSpeedState extends State<SetFormatSpeed> {
  String _optionalTool = 'Nautical Miles Per Hour (Knots)';
  final List<String> _tool = ['Nautical Miles Per Hour (Knots)', 'Kilometer Miles Per Hour (Kmh), Feet Per Hour (Knots)'];

  @override
  void initState() {
    super.initState();
    _loadToolFromSharedPreferences();
  }

  Future<void> _saveToolToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('SetFormatSpeedPreference', _optionalTool);
  }

  Future<void> _loadToolFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _optionalTool = prefs.getString('SetFormatSpeedPreference') ?? 'Hide';
    });
  }

  Future<void> _showConfirmationDialog(String value) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text('Do you agree to change format speed?'),
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
