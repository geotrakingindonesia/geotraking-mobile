import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AirtimeDataModal extends StatelessWidget {
  final Future<List<Map<String, dynamic>>?> future;

  AirtimeDataModal({required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>>? airtimeData = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'List Airtime',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Airtime Start:',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Airtime End:',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  ...airtimeData!.map<Widget>((data) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                DateFormat('dd MMMM yyyy').format(
                                  DateTime.parse('${data['airtime_start']}'),
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                DateFormat('dd MMMM yyyy').format(
                                  DateTime.parse('${data['airtime_end']}'),
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        } else {
          return Center(child: Container());
        }
      },
    );
  }
}
