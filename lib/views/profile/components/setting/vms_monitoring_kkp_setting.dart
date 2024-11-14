// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:geotraking/core/components/app_back_button.dart';

// // class VmsMonitoringKkpSetting extends StatefulWidget {
// //   const VmsMonitoringKkpSetting({Key? key}) : super(key: key);

// //   @override
// //   _VmsMonitoringKkpSettingState createState() =>
// //       _VmsMonitoringKkpSettingState();
// // }

// // class _VmsMonitoringKkpSettingState extends State<VmsMonitoringKkpSetting> {
// //   late Future<List<Map<String, dynamic>>> _geosatData;

// //   Future<List<Map<String, dynamic>>> fetchGeosatData() async {
// //     final response = await http.get(Uri.parse(
// //         'https://devspkp.kkp.go.id:10885/monitapidatavms/?IDPROV=GEO0o4yYhwSJWRP89FtfjRx'));

// //     if (response.statusCode == 200) {
// //       // Split the response data into individual JSON objects
// //       final rawData = response.body.split('}{');
// //       final jsonData = rawData.map((entry) {
// //         // Add missing curly braces if needed
// //         final data = entry.startsWith('{') ? entry : '{' + entry;
// //         return jsonDecode(data.endsWith('}') ? data : data + '}');
// //       }).toList();

// //       jsonData.sort((a, b) {
// //         final pingTimeA = a['PING_TIME'];
// //         final pingTimeB = b['PING_TIME'];
// //         return pingTimeB.compareTo(pingTimeA);
// //       });

// //       // Return as a list of maps
// //       return jsonData.cast<Map<String, dynamic>>();
// //     } else {
// //       throw Exception('Failed to load data');
// //     }
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     _geosatData = fetchGeosatData();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         title: Text('Back'),
// //         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
// //               color: Colors.black,
// //             ),
// //         leading: const AppBackButton(),
// //         backgroundColor: Colors.white,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(15),
// //         child: FutureBuilder<List<Map<String, dynamic>>>(
// //           future: _geosatData,
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return Center(child: CircularProgressIndicator());
// //             } else if (snapshot.hasError) {
// //               return Center(child: Text('Error: ${snapshot.error}'));
// //             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //               return Center(child: Text('No data available'));
// //             } else {
// //               return ListView.builder(
// //                 itemCount: snapshot.data!.length,
// //                 itemBuilder: (context, index) {
// //                   final data = snapshot.data![index];
// //                   return Card(
// //                     color: Colors.black54,
// //                     margin: const EdgeInsets.symmetric(vertical: 8),
// //                     child: ListTile(
// //                       title: Text(
// //                         'Provider: ${data["PROVIDER"]}',
// //                         style: TextStyle(color: Colors.white),
// //                       ),
// //                       subtitle: Text(
// //                         'Ping Time: ${data["PING_TIME"]}\n'
// //                         'Transmitters: ${data["TOTAL_TRANSMITTER"]}\n'
// //                         'Total TRX: ${data["TOTAL_TRX"]}',
// //                         style: TextStyle(color: Colors.white),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               );
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/app_back_button.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class VmsMonitoringKkpSetting extends StatefulWidget {
//   const VmsMonitoringKkpSetting({Key? key}) : super(key: key);

//   @override
//   _VmsMonitoringKkpSettingState createState() => _VmsMonitoringKkpSettingState();
// }

// class _VmsMonitoringKkpSettingState extends State<VmsMonitoringKkpSetting> {
//   late final WebSocketChannel _channel;
//   List<Map<String, dynamic>> _geosatData = [];

//   @override
//   void initState() {
//     super.initState();

//     // Establish WebSocket connection
//     _channel = WebSocketChannel.connect(
//       // Uri.parse('https://devspkp.kkp.go.id:10885/monitapidatavms/?IDPROV=GEO0o4yYhwSJWRP89FtfjRx'),
//       Uri.parse('wss://devspkp.kkp.go.id:10885/monitapidatavms/?IDPROV=GEO0o4yYhwSJWRP89FtfjRx'),
//     );

//     // Listen for incoming data and update the state
//     _channel.stream.listen((message) {
//       setState(() {
//         // Decode the incoming message and parse it as JSON
//         final rawData = message.toString().split('}{');
//         final jsonData = rawData.map((entry) {
//           // Add missing curly braces if needed
//           final data = entry.startsWith('{') ? entry : '{' + entry;
//           return jsonDecode(data.endsWith('}') ? data : data + '}');
//         }).toList();

//         // Sort data by PING_TIME in descending order
//         jsonData.sort((a, b) {
//           final pingTimeA = a['PING_TIME'];
//           final pingTimeB = b['PING_TIME'];
//           return pingTimeB.compareTo(pingTimeA); // Sort descending
//         });

//         _geosatData = jsonData.cast<Map<String, dynamic>>();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     // Close the WebSocket connection when the widget is disposed
//     _channel.sink.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Back'),
//         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: Colors.black,
//             ),
//         leading: const AppBackButton(),
//         backgroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: _geosatData.isEmpty
//             ? Center(child: CircularProgressIndicator())
//             : ListView.builder(
//                 itemCount: _geosatData.length,
//                 itemBuilder: (context, index) {
//                   final data = _geosatData[index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       title: Text('Provider: ${data["PROVIDER"]}'),
//                       subtitle: Text(
//                         'Ping Time: ${data["PING_TIME"]}\n'
//                         'Transmitters: ${data["TOTAL_TRANSMITTER"]}\n'
//                         'Total TRX: ${data["TOTAL_TRX"]}',
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:http/http.dart' as http;

class VmsMonitoringKkpSetting extends StatefulWidget {
  @override
  _VmsMonitoringKkpSettingState createState() =>
      _VmsMonitoringKkpSettingState();
}

class _VmsMonitoringKkpSettingState extends State<VmsMonitoringKkpSetting> {
  List<Map<String, dynamic>> geosatData = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startPolling();
  }

  void startPolling() {
    // Fetch data every 5 seconds (you can adjust the interval)
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

        // Check if data has changed before updating the UI
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
        title: Text('Back'),
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
              color: Colors.brown,
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
