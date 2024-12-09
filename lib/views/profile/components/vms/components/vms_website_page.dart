// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:http/http.dart' as http;

class VmsWebsitePage extends StatefulWidget {
  const VmsWebsitePage({super.key});

  @override
  _VmsWebsitePageState createState() =>
      _VmsWebsitePageState();
}

class _VmsWebsitePageState extends State<VmsWebsitePage> {
  List<Map<String, dynamic>> geosatData = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startPolling();
  }

  void startPolling() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      await fetchData();
    });
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'https://devspkp.kkp.go.id:10885/monitapidatavms/?IDPROV=GEO0o4yYhwSJWRP89FtfjRx');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> newData = parseData(response.body);

        if (!listEquals(geosatData, newData)) {
          setState(() {
            geosatData = newData;
          });
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  List<Map<String, dynamic>> parseData(String responseBody) {
    final rawData = responseBody.split('}{');

    final jsonData = rawData.map((entry) {
      final data = entry.startsWith('{') ? entry : '{' + entry;
      return jsonDecode(data.endsWith('}') ? data : data + '}');
    }).toList();

    jsonData.sort((a, b) {
      final pingTimeA = a['PING_TIME'];
      final pingTimeB = b['PING_TIME'];
      return pingTimeB.compareTo(pingTimeA);
    });

    return jsonData.cast<Map<String, dynamic>>();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Website KKP'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: geosatData.length,
          itemBuilder: (context, index) {
            final item = geosatData[index];
            return Card(
              color: Color.fromARGB(255, 127, 183, 126),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  'Provider: ${item["PROVIDER"]}',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Ping Time: ${item["PING_TIME"]}\n'
                  'Transmitters: ${item["TOTAL_TRANSMITTER"]}\n'
                  'Total TRX: ${item["TOTAL_TRX"]}',
                  style: TextStyle(color: Colors.white60),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
