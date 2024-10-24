// // ignore_for_file: prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/app_back_button.dart';
// import 'package:geotraking/core/services/vessel/vessel_service.dart';
// import 'package:intl/intl.dart';

// class TabDownloadHistoryTraking extends StatefulWidget {
//   final String mobileId;
//   final List<dynamic> historyData;

//   TabDownloadHistoryTraking(
//       {required this.mobileId, required this.historyData});

//   @override
//   _TabDownloadHistoryTrakingState createState() =>
//       _TabDownloadHistoryTrakingState();
// }

// String _formatLatitude(double lat) {
//   int degrees = lat.toInt();
//   double minutes = (lat - degrees) * 60;
//   int minutesInt = minutes.toInt();
//   double seconds = (minutes - minutesInt) * 60;
//   return '${degrees.abs()} ${degrees < 0 ? 'S' : 'N'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
// }

// String _formatLongitude(double lon) {
//   int degrees = lon.toInt();
//   double minutes = (lon - degrees) * 60;
//   int minutesInt = minutes.toInt();
//   double seconds = (minutes - minutesInt) * 60;
//   return '${degrees.abs()} ${degrees < 0 ? 'W' : 'E'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
// }

// class _TabDownloadHistoryTrakingState extends State<TabDownloadHistoryTraking> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Back'),
//         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: Colors.black,
//             ),
//         leading: const AppBackButton(),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
//               child: Text(
//                 'Histori Traking',
//                 style: TextStyle(color: Colors.black, fontSize: 24),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15),
//               child: Divider(
//                 thickness: 0.5,
//                 color: Colors.black,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: FutureBuilder<Map<String, dynamic>?>(
//                 future: VesselService().searchDataKapal(widget.mobileId),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Id Kapal',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['idfull']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Nama Kapal',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['nama_kapal']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Tipe',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['type']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Kategori',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['kategori']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'SN',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['sn']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'IMEI',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['imei']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Owner',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['custamer']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Received Date',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${DateFormat('dd MMM yyyy (HH:mm:ss)').format(
//                                   DateTime.parse('${snapshot.data!['received']}'))}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Broadcast Date',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${DateFormat('dd MMM yyyy (HH:mm:ss)').format(
//                                   DateTime.parse('${snapshot.data!['broadcast']}'))}',
//                                 // ': ${snapshot.data!['broadcast']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Speed',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['speed_kn']} Knot/${snapshot.data!['speed_kmh']} Kmh',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Heading',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['heading']}°',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Latitude',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${_formatLatitude(double.parse(snapshot.data!['lat']))}',
//                                 // ': ${snapshot.data!['lat']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Longitude',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${_formatLongitude(double.parse(snapshot.data!['lon']))}',
//                                 // ': ${snapshot.data!['lon']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Power Source',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['powerstatus']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Power Value',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 ': ${snapshot.data!['externalvoltage']}',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   } else {
//                     return Text('Loading...');
//                   }
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Table(
//                 border: TableBorder.all(),
//                 children: [
//                   TableRow(
//                     children: [
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.all(3),
//                           child: Text(
//                             'TimeDate',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.all(3),
//                           child: Text(
//                             'Latitude',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.all(3),
//                           child: Text(
//                             'Longitude',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.all(3),
//                           child: Text(
//                             'Heading',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.all(3),
//                           child: Text(
//                             'Speed',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   ...widget.historyData.map((data) {
//                     return TableRow(
//                       children: [
//                         TableCell(
//                           child: Padding(
//                             padding: const EdgeInsets.all(3),
//                             child: Text(
//                               DateFormat('dd MMMM yyyy (HH:mm:ss)').format(
//                                   DateTime.parse('${data['timestamp']}')),
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: Padding(
//                             padding: const EdgeInsets.all(3),
//                             child: Text(
//                               _formatLatitude(double.parse(data['latitude'])),
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: Padding(
//                             padding: const EdgeInsets.all(3),
//                             child: Text(
//                               _formatLongitude(double.parse(data['longitude'])),
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: Padding(
//                             padding: const EdgeInsets.all(3),
//                             child: Text(
//                               '${data['heading']}°',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: Padding(
//                             padding: const EdgeInsets.all(3),
//                             child: Text(
//                               '${data['speed_kn']} Knot/${data['speed_kmh']} Kmh',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }).toList(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class TabDownloadHistoryTraking extends StatefulWidget {
  final String mobileId;
  final List<dynamic> historyData;

  TabDownloadHistoryTraking(
      {required this.mobileId, required this.historyData});

  @override
  _TabDownloadHistoryTrakingState createState() =>
      _TabDownloadHistoryTrakingState();
}

String _formatLatitude(double lat) {
  int degrees = lat.toInt();
  double minutes = (lat - degrees) * 60;
  int minutesInt = minutes.toInt();
  double seconds = (minutes - minutesInt) * 60;
  return '${degrees.abs()} ${degrees < 0 ? 'S' : 'N'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
}

String _formatLongitude(double lon) {
  int degrees = lon.toInt();
  double minutes = (lon - degrees) * 60;
  int minutesInt = minutes.toInt();
  double seconds = (minutes - minutesInt) * 60;
  return '${degrees.abs()} ${degrees < 0 ? 'W' : 'E'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
}

class _TabDownloadHistoryTrakingState extends State<TabDownloadHistoryTraking> {
  Future<void> _createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Histori Traking', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),  
              pw.Table.fromTextArray(
                headers: [
                  'Received',
                  'Broadcast',
                  'Latitude',
                  'Longitude',
                  'Heading',
                  'Speed'
                ],
                data: widget.historyData.map((data) {
                  return [
                    DateFormat('dd MMMM yyyy (HH:mm:ss)')
                        .format(DateTime.parse('${data['timestamp']}')),
                    DateFormat('dd MMMM yyyy (HH:mm:ss)')
                        .format(DateTime.parse('${data['broadcast']}')),
                    _formatLatitude(double.parse(data['latitude'])),
                    _formatLongitude(double.parse(data['longitude'])),
                    '${data['heading']}°',
                    '${data['speed_kn']} Knot/${data['speed_kmh']} Kmh',
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/tracking_history.pdf');

    await file.writeAsBytes(await pdf.save());

    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        leading: const AppBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Histori Traking',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  ElevatedButton.icon(
                    onPressed: _createPdf,
                    icon: Icon(Icons.download),
                    label: Text('Download PDF'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
            ),
            // Remainder of the widget tree...
            Padding(
              padding: const EdgeInsets.all(15),
              child: FutureBuilder<Map<String, dynamic>?>(
                future: VesselService().searchDataKapal(widget.mobileId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Id Kapal',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['idfull']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Nama Kapal',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['nama_kapal']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tipe',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['type']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Kategori',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['kategori']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'SN',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['sn']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'IMEI',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['imei']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Owner',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['custamer']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Received Date',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${DateFormat('dd MMM yyyy (HH:mm:ss)').format(DateTime.parse('${snapshot.data!['received']}'))}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Broadcast Date',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${DateFormat('dd MMM yyyy (HH:mm:ss)').format(DateTime.parse('${snapshot.data!['broadcast']}'))}',
                                // ': ${snapshot.data!['broadcast']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Speed',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['speed_kn']} Knot/${snapshot.data!['speed_kmh']} Kmh',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Heading',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['heading']}°',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Latitude',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${_formatLatitude(double.parse(snapshot.data!['lat']))}',
                                // ': ${snapshot.data!['lat']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Longitude',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${_formatLongitude(double.parse(snapshot.data!['lon']))}',
                                // ': ${snapshot.data!['lon']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Power Source',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['powerstatus']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Power Value',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ': ${snapshot.data!['externalvoltage']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Text('Loading...');
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            'Received',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            'Broadcast',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            'Latitude',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            'Longitude',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            'Heading',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            'Speed',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...widget.historyData.map((data) {
                    return TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              DateFormat('dd MMMM yyyy (HH:mm:ss)').format(
                                  DateTime.parse('${data['timestamp']}')),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              DateFormat('dd MMMM yyyy (HH:mm:ss)').format(
                                  DateTime.parse('${data['broadcast']}')),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              _formatLatitude(double.parse(data['latitude'])),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              _formatLongitude(double.parse(data['longitude'])),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              '${data['heading']}°',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              '${data['speed_kn']} Knot/${data['speed_kmh']} Kmh',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
