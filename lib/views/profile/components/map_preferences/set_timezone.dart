import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/views/entrypoint/entrypoint_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetTimezone extends StatefulWidget {
  const SetTimezone({Key? key}) : super(key: key);

  @override
  SetTimezoneState createState() => SetTimezoneState();
}

class SetTimezoneState extends State<SetTimezone> {
  String _optionalTool = 'UTC (Europe/London)';
  final List<String> _tool = ['UTC (Europe/London)', 'UTC+7 (Asia/Jakarta)', 'UTC+8 (Asia/Makassar)', 'UTC+9 (Asia/Jayapura)'];

  @override
  void initState() {
    super.initState();
    _loadToolFromSharedPreferences();
  }

  Future<void> _saveToolToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('SetTimezonePreference', _optionalTool);
  }

  Future<void> _loadToolFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _optionalTool = prefs.getString('SetTimezonePreference') ?? 'Hide';
    });
  }

  Future<void> _showConfirmationDialog(String value) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text('Do you agree to change timezone?'),
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
