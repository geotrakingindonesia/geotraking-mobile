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
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class TabDownloadHistoryTraking extends StatefulWidget {
  final String mobileId;
  final List<dynamic> historyData;

  TabDownloadHistoryTraking({
    required this.mobileId,
    required this.historyData,
  });

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
  Future<void> _createPdf(String vesselName) async {
    final pdf = pw.Document();

    final ByteData bytes =
        await rootBundle.load('assets/images/logo-geosat.png');
    final Uint8List imageData = bytes.buffer.asUint8List();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Histori Traking',
                        style: pw.TextStyle(
                            fontSize: 22, fontWeight: pw.FontWeight.bold)),
                    pw.Image(
                      pw.MemoryImage(imageData),
                      width: 100,
                      height: 50,
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Text('Nama Kapal: ', style: pw.TextStyle(fontSize: 14)),
                    pw.Text(vesselName, style: pw.TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 25),
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
          ];
        },
      ),
    );

    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/tracking_history.pdf');

    await file.writeAsBytes(await pdf.save());

    OpenFile.open(file.path);
  }

  Future<Map<String, int>> _calculateSpeedKnCounts(
      List<dynamic> historyData) async {
    int zeroCount = 0;
    int nonZeroCount = 0;

    for (var data in historyData) {
      final speedKn = double.tryParse(data['speed_kn'].toString()) ?? 0.0;
      if (speedKn == 0) {
        zeroCount++;
      } else {
        nonZeroCount++;
      }
    }

    return {
      'zero': zeroCount,
      'nonZero': nonZeroCount,
    };
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder<Map<String, dynamic>?>(
                  future: VesselService().searchDataKapal(widget.mobileId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ElevatedButton.icon(
                        onPressed: () async {
                          if (snapshot.data != null) {
                            await _createPdf('${snapshot.data!['nama_kapal']}');
                          }
                        },
                        icon: Icon(
                          Icons.save,
                          size: 24,
                          color: Colors.white60,
                        ),
                        label: Text(
                          'Pdf',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white60,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54,
                        ),
                      );
                    } else {
                      return Text('Loading...');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: FutureBuilder<Map<String, dynamic>?>(
                future: VesselService().searchDataKapal(widget.mobileId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 127, 183, 126),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Histori Traking (${snapshot.data!['idfull']})',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.white60,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.ship,
                                  color: Colors.white70,
                                  size: 14,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${snapshot.data!['nama_kapal']}',
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'SN',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ': ${snapshot.data!['sn']}',
                                        style: const TextStyle(
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'IMEI',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ': ${snapshot.data!['imei']}',
                                        style: const TextStyle(
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Tipe',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ': ${snapshot.data!['type']}',
                                        style: const TextStyle(
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Kategori',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ': ${snapshot.data!['kategori']}',
                                        style: const TextStyle(
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Text('Loading...');
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: FutureBuilder<Map<String, int>>(
                future: _calculateSpeedKnCounts(widget.historyData),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final data = snapshot.data!;
                    final speedKnZero = data['zero']!;
                    final speedKnNonZero = data['nonZero']!;
                    return SizedBox(
                      height: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      color: Colors.red,
                                      value: speedKnZero.toDouble(),
                                      title: '',
                                    ),
                                    PieChartSectionData(
                                      color: Colors.green,
                                      value: speedKnNonZero.toDouble(),
                                      title: '',
                                    ),
                                  ],
                                  centerSpaceRadius: 20,
                                  sectionsSpace: 2,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '0 Speed: $speedKnZero',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '>0 Speed: $speedKnNonZero',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: Table(
                  border: TableBorder.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1.5),
                    3: FlexColumnWidth(1.5),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                      ),
                      children: [
                        _buildTableHeaderCell('Received'),
                        _buildTableHeaderCell('Broadcast'),
                        _buildTableHeaderCell('Latitude'),
                        _buildTableHeaderCell('Longitude'),
                        _buildTableHeaderCell('Heading'),
                        _buildTableHeaderCell('Speed'),
                      ],
                    ),
                    ...widget.historyData.asMap().entries.map((entry) {
                      final index = entry.key;
                      final data = entry.value;
                      return TableRow(
                        decoration: BoxDecoration(
                          color: index.isEven
                              ? Colors.white
                              : Colors.blueGrey.shade50,
                        ),
                        children: [
                          _buildTableDataCell(
                              DateFormat('dd MMM yyyy (HH:mm:ss)').format(
                                  DateTime.parse('${data['timestamp']}'))),
                          _buildTableDataCell(
                              DateFormat('dd MMM yyyy (HH:mm:ss)').format(
                                  DateTime.parse('${data['broadcast']}'))),
                          _buildTableDataCell(
                              _formatLatitude(double.parse(data['latitude']))),
                          _buildTableDataCell(_formatLongitude(
                              double.parse(data['longitude']))),
                          _buildTableDataCell('${data['heading']}°'),
                          _buildTableDataCell(
                              '${data['speed_kn']} Knot/${data['speed_kmh']} Kmh'),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTableHeaderCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey.shade900,
      ),
    ),
  );
}

Widget _buildTableDataCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black87,
      ),
    ),
  );
}
