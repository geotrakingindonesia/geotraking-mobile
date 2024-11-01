// // // // // // import 'package:flutter/material.dart';

// // // // // // class DetailPage extends StatelessWidget {
// // // // // //   final List<Map<String, dynamic>>? data;

// // // // // //   const DetailPage({Key? key, this.data}) : super(key: key);

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //         title: Text('Detail Jarak Tempuh'),
// // // // // //       ),
// // // // // //       body: data != null && data!.isNotEmpty
// // // // // //           ? ListView.builder(
// // // // // //               itemCount: data!.length,
// // // // // //               itemBuilder: (context, index) {
// // // // // //                 final item = data![index];
// // // // // //                 return ListTile(
// // // // // //                   title: Text('Tanggal: ${item['tgl_aktifasi']}'),
// // // // // //                   subtitle: Column(
// // // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                     children: [
// // // // // //                       Text('Latitude: ${item['latitude']}'),
// // // // // //                       Text('Longitude: ${item['longitude']}'),
// // // // // //                       Text('Speed: ${item['speed']}'),
// // // // // //                       Text('data type: ${item['data_type']}'),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                 );
// // // // // //               },
// // // // // //             )
// // // // // //           : Center(
// // // // // //               child: Text('Tidak ada data untuk ditampilkan'),
// // // // // //             ),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // // import 'dart:math';
// // // // // import 'package:flutter/material.dart';

// // // // // class DetailPage extends StatelessWidget {
// // // // //   final List<Map<String, dynamic>>? data;

// // // // //   const DetailPage({Key? key, this.data}) : super(key: key);

// // // // //   double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
// // // // //     const double R = 3440.065; // Radius Bumi dalam nautical miles

// // // // //     double dLat = _toRadians(lat2 - lat1);
// // // // //     double dLon = _toRadians(lon2 - lon1);

// // // // //     double a = sin(dLat / 2) * sin(dLat / 2) +
// // // // //         cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
// // // // //             sin(dLon / 2) * sin(dLon / 2);
// // // // //     double c = 2 * atan2(sqrt(a), sqrt(1 - a));

// // // // //     return R * c; // Jarak dalam nautical miles
// // // // //   }

// // // // //   double _toRadians(double degrees) {
// // // // //     return degrees * (pi / 180);
// // // // //   }

// // // // //   Map<String, dynamic> _calculateTotalDistance() {
// // // // //     double totalDistance = 0;
// // // // //     Map<String, double> dailyDistances = {};
// // // // //     Map<String, List<Map<String, dynamic>>> dailyData = {};

// // // // //     // Mengelompokkan data berdasarkan tanggal
// // // // //     for (var item in data!) {
// // // // //       String date = item['tgl_aktifasi'].toString().split(' ')[0];
// // // // //       if (!dailyData.containsKey(date)) {
// // // // //         dailyData[date] = [];
// // // // //       }
// // // // //       dailyData[date]!.add(item);
// // // // //     }

// // // // //     // Menghitung jarak untuk setiap kelompok tanggal
// // // // //     for (var entry in dailyData.entries) {
// // // // //       var items = entry.value;
// // // // //       Map<String, dynamic>? startPoint;
// // // // //       Map<String, dynamic>? endPoint;

// // // // //       // Mencari titik awal dan akhir
// // // // //       for (var item in items) {
// // // // //         if (item['data_type'] == 1) {
// // // // //           startPoint = item;
// // // // //         } else if (item['data_type'] == 2) {
// // // // //           endPoint = item;
// // // // //         }
// // // // //       }

// // // // //       // Jika keduanya ditemukan, hitung jarak
// // // // //       if (startPoint != null && endPoint != null) {
// // // // //         double distance = _calculateDistance(
// // // // //           double.parse(startPoint['latitude'].toString()),
// // // // //           double.parse(startPoint['longitude'].toString()),
// // // // //           double.parse(endPoint['latitude'].toString()),
// // // // //           double.parse(endPoint['longitude'].toString()),
// // // // //         );

// // // // //         // Tambahkan jarak ke keseluruhan
// // // // //         totalDistance += distance;

// // // // //         // Simpan jarak harian
// // // // //         dailyDistances[entry.key] = (dailyDistances[entry.key] ?? 0) + distance;
// // // // //       }
// // // // //     }

// // // // //     return {'totalDistance': totalDistance, 'dailyDistances': dailyDistances};
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     Map<String, dynamic> distances = _calculateTotalDistance();
// // // // //     double totalDistance = distances['totalDistance'];
// // // // //     Map<String, double> dailyDistances = distances['dailyDistances'];

// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Detail Jarak Tempuh'),
// // // // //       ),
// // // // //       body: data != null && data!.isNotEmpty
// // // // //           ? Column(
// // // // //               children: [
// // // // //                 Padding(
// // // // //                   padding: const EdgeInsets.all(16.0),
// // // // //                   child: Text(
// // // // //                     'Total Jarak Tempuh: ${totalDistance.toStringAsFixed(2)} nmi',
// // // // //                     style: TextStyle(fontSize: 20),
// // // // //                   ),
// // // // //                 ),

// // // // //                 Expanded(
// // // // //                   child: ListView.builder(
// // // // //                     itemCount: dailyDistances.keys.length,
// // // // //                     itemBuilder: (context, index) {
// // // // //                       String date = dailyDistances.keys.elementAt(index);
// // // // //                       return ListTile(
// // // // //                         title: Text('Tanggal: $date'),
// // // // //                         subtitle: Text('Jarak: ${dailyDistances[date]?.toStringAsFixed(2)} nmi'),
// // // // //                       );
// // // // //                     },
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             )
// // // // //           : Center(
// // // // //               child: Text('Tidak ada data untuk ditampilkan'),
// // // // //             ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'dart:math';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:intl/intl.dart';

// // // // class DetailPage extends StatelessWidget {
// // // //   final List<Map<String, dynamic>>? data;

// // // //   const DetailPage({Key? key, this.data}) : super(key: key);

// // // //   double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
// // // //     const double R = 3440.065; // Radius Bumi dalam nautical miles

// // // //     double dLat = _toRadians(lat2 - lat1);
// // // //     double dLon = _toRadians(lon2 - lon1);

// // // //     double a = sin(dLat / 2) * sin(dLat / 2) +
// // // //         cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
// // // //             sin(dLon / 2) * sin(dLon / 2);
// // // //     double c = 2 * atan2(sqrt(a), sqrt(1 - a));

// // // //     return R * c; // Jarak dalam nautical miles
// // // //   }

// // // //   double _toRadians(double degrees) {
// // // //     return degrees * (pi / 180);
// // // //   }

// // // //   Map<String, dynamic> _calculateTotalDistance() {
// // // //     double totalDistance = 0;
// // // //     Map<String, double> dailyDistances = {};
// // // //     Map<String, String> dateRanges = {}; // Untuk menyimpan rentang tanggal

// // // //     // Mengelompokkan data berdasarkan tanggal
// // // //     for (var item in data!) {
// // // //       String date = item['tgl_aktifasi'].toString().split(' ')[0];
// // // //       String time = item['tgl_aktifasi'].toString().split(' ')[1];

// // // //       if (!dateRanges.containsKey(date)) {
// // // //         dateRanges[date] = '$time - $time'; // Inisialisasi dengan waktu pertama
// // // //       } else {
// // // //         // Update rentang waktu
// // // //         String existingRange = dateRanges[date]!;
// // // //         String startTime = existingRange.split(' - ')[0]; // ambil waktu pertama
// // // //         dateRanges[date] = '$startTime - $time'; // Update waktu akhir
// // // //       }
// // // //     }

// // // //     // Menghitung jarak untuk setiap kelompok tanggal
// // // //     for (var entry in dateRanges.entries) {
// // // //       String date = entry.key;
// // // //       Map<String, dynamic>? startPoint;
// // // //       Map<String, dynamic>? endPoint;

// // // //       // Mencari titik awal dan akhir
// // // //       for (var item in data!) {
// // // //         if (item['tgl_aktifasi'].toString().split(' ')[0] == date) {
// // // //           if (item['data_type'] == 1) {
// // // //             startPoint = item;
// // // //           } else if (item['data_type'] == 2) {
// // // //             endPoint = item;
// // // //           }
// // // //         }
// // // //       }

// // // //       // Jika keduanya ditemukan, hitung jarak
// // // //       if (startPoint != null && endPoint != null) {
// // // //         double distance = _calculateDistance(
// // // //           double.parse(startPoint['latitude'].toString()),
// // // //           double.parse(startPoint['longitude'].toString()),
// // // //           double.parse(endPoint['latitude'].toString()),
// // // //           double.parse(endPoint['longitude'].toString()),
// // // //         );

// // // //         // Tambahkan jarak ke total keseluruhan
// // // //         totalDistance += distance;

// // // //         // Simpan jarak harian
// // // //         dailyDistances[date] = (dailyDistances[date] ?? 0) + distance;
// // // //       }
// // // //     }

// // // //     return {'totalDistance': totalDistance, 'dailyDistances': dailyDistances, 'dateRanges': dateRanges};
// // // //   }

// // // //   String _formatDateRange(String date, String timeRange) {
// // // //     DateTime startDateTime = DateTime.parse(date + ' ' + timeRange.split(' - ')[0]);
// // // //     DateTime endDateTime = DateTime.parse(date + ' ' + timeRange.split(' - ')[1]);

// // // //     DateFormat dateFormat = DateFormat('dd MMM yyyy hh:mm a');
// // // //     return '${dateFormat.format(startDateTime)} - ${dateFormat.format(endDateTime)}';
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     Map<String, dynamic> distances = _calculateTotalDistance();
// // // //     double totalDistance = distances['totalDistance'];
// // // //     Map<String, double> dailyDistances = distances['dailyDistances'];
// // // //     Map<String, String> dateRanges = distances['dateRanges'];

// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Detail Jarak Tempuh'),
// // // //       ),
// // // //       body: data != null && data!.isNotEmpty
// // // //           ? Column(
// // // //               children: [
// // // //                 Padding(
// // // //                   padding: const EdgeInsets.all(16.0),
// // // //                   child: Text(
// // // //                     'Total Jarak Tempuh: ${totalDistance.toStringAsFixed(2)} nmi',
// // // //                     style: TextStyle(fontSize: 20),
// // // //                   ),
// // // //                 ),
// // // //                 Padding(
// // // //                   padding: const EdgeInsets.all(16.0),
// // // //                   child: Text(
// // // //                     'Jarak Tempuh Per Hari:',
// // // //                     style: TextStyle(fontSize: 20),
// // // //                   ),
// // // //                 ),
// // // //                 Expanded(
// // // //                   child: ListView.builder(
// // // //                     itemCount: dailyDistances.keys.length,
// // // //                     itemBuilder: (context, index) {
// // // //                       String date = dailyDistances.keys.elementAt(index);
// // // //                       String timeRange = dateRanges[date] ?? '';

// // // //                       return ListTile(
// // // //                         title: Text('${_formatDateRange(date, timeRange)}'),
// // // //                         subtitle: Text('Jarak: ${dailyDistances[date]?.toStringAsFixed(2)} nmi'),
// // // //                       );
// // // //                     },
// // // //                   ),
// // // //                 ),
// // // //               ],
// // // //             )
// // // //           : Center(
// // // //               child: Text('Tidak ada data untuk ditampilkan'),
// // // //             ),
// // // //     );
// // // //   }
// // // // }

// // // import 'dart:math';
// // // import 'package:flutter/material.dart';
// // // import 'package:geotraking/core/components/app_back_button.dart';
// // // import 'package:geotraking/views/profile/report/jaraktempuh/components/tab_card.dart';
// // // import 'package:intl/intl.dart';

// // // class DetailPage extends StatelessWidget {
// // //   final List<Map<String, dynamic>>? data;
// // //   final DateTime? startDate;
// // //   final DateTime? endDate;

// // //   const DetailPage({
// // //     Key? key,
// // //     this.data,
// // //     this.startDate,
// // //     this.endDate,
// // //   }) : super(key: key);

// // //   double _calculateDistance(
// // //       double lat1, double lon1, double lat2, double lon2) {
// // //     const double R = 3440.065;

// // //     double dLat = _toRadians(lat2 - lat1);
// // //     double dLon = _toRadians(lon2 - lon1);

// // //     double a = sin(dLat / 2) * sin(dLat / 2) +
// // //         cos(_toRadians(lat1)) *
// // //             cos(_toRadians(lat2)) *
// // //             sin(dLon / 2) *
// // //             sin(dLon / 2);
// // //     double c = 2 * atan2(sqrt(a), sqrt(1 - a));

// // //     return R * c;
// // //   }

// // //   double _toRadians(double degrees) {
// // //     return degrees * (pi / 180);
// // //   }

// // //   Map<String, dynamic> _calculateTotalDistance() {
// // //     double totalDistance = 0;
// // //     Map<String, double> dailyDistances = {};
// // //     Map<String, String> dateRanges = {};

// // //     for (var item in data!) {
// // //       String date = item['tgl_aktifasi'].toString().split(' ')[0];
// // //       String time = item['tgl_aktifasi'].toString().split(' ')[1];

// // //       if (!dateRanges.containsKey(date)) {
// // //         dateRanges[date] = '$time - $time';
// // //       } else {
// // //         String existingRange = dateRanges[date]!;
// // //         String startTime = existingRange.split(' - ')[0];
// // //         dateRanges[date] = '$startTime - $time';
// // //       }
// // //     }

// // //     for (var entry in dateRanges.entries) {
// // //       String date = entry.key;
// // //       Map<String, dynamic>? startPoint;
// // //       Map<String, dynamic>? endPoint;

// // //       for (var item in data!) {
// // //         if (item['tgl_aktifasi'].toString().split(' ')[0] == date) {
// // //           if (item['data_type'] == 1) {
// // //             startPoint = item;
// // //           } else if (item['data_type'] == 2) {
// // //             endPoint = item;
// // //           }
// // //         }
// // //       }

// // //       if (startPoint != null && endPoint != null) {
// // //         double distance = _calculateDistance(
// // //           double.parse(startPoint['latitude'].toString()),
// // //           double.parse(startPoint['longitude'].toString()),
// // //           double.parse(endPoint['latitude'].toString()),
// // //           double.parse(endPoint['longitude'].toString()),
// // //         );

// // //         totalDistance += distance;

// // //         dailyDistances[date] = (dailyDistances[date] ?? 0) + distance;
// // //       }
// // //     }

// // //     return {
// // //       'totalDistance': totalDistance,
// // //       'dailyDistances': dailyDistances,
// // //       'dateRanges': dateRanges
// // //     };
// // //   }

// // //   String _formatDateRange(String date, String timeRange) {
// // //     DateTime startDateTime =
// // //         DateTime.parse(date + ' ' + timeRange.split(' - ')[0]);
// // //     String endTime = timeRange.split(' - ')[1];

// // //     DateFormat dateFormat = DateFormat('dd MMM yyyy hh:mm a');
// // //     String formattedStartDate = dateFormat.format(startDateTime);

// // //     DateTime endDateTime = DateTime.parse(date + ' ' + endTime);
// // //     String formattedEndTime = DateFormat('hh:mm a').format(endDateTime);

// // //     return '$formattedStartDate - $formattedEndTime';
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     Map<String, dynamic> distances = _calculateTotalDistance();
// // //     double totalDistance = distances['totalDistance'];
// // //     Map<String, double> dailyDistances = distances['dailyDistances'];
// // //     Map<String, String> dateRanges = distances['dateRanges'];

// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: AppBar(
// // //         title: Text('Back'),
// // //         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
// // //               color: Colors.black,
// // //             ),
// // //         leading: const AppBackButton(),
// // //         backgroundColor: Colors.white,
// // //       ),
// // //       body: data != null && data!.isNotEmpty
// // //           ? Padding(
// // //               padding: const EdgeInsets.all(15),
// // //               child: Column(
// // //                 children: [
// // //                   Container(
// // //                     padding: const EdgeInsets.all(5),
// // //                     margin: const EdgeInsets.all(5),
// // //                     decoration: BoxDecoration(
// // //                       color: Color.fromARGB(255, 127, 183, 126),
// // //                       borderRadius: BorderRadius.circular(8),
// // //                       boxShadow: [
// // //                         BoxShadow(
// // //                           color: Colors.grey.withOpacity(0.3),
// // //                           spreadRadius: 2,
// // //                           blurRadius: 5,
// // //                           offset: Offset(0, 2),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     child: Padding(
// // //                       padding: const EdgeInsets.all(10),
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           Row(
// // //                         crossAxisAlignment: CrossAxisAlignment.center,
// // //                         children: [
// // //                           Icon(
// // //                             Icons.calendar_today,
// // //                             color: Colors.white,
// // //                             size: 24,
// // //                           ),
// // //                           SizedBox(width: 8),
// // //                           Text(
// // //                             '${startDate != null && endDate != null ? "${DateFormat('dd MMM yyyy').format(startDate!)} - ${DateFormat('dd MMM yyyy').format(endDate!)}" : "No date selected"}',
// // //                             style: TextStyle(
// // //                               fontSize: 18,
// // //                               color: Colors.white,
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                           Divider(
// // //                             thickness: 0.5,
// // //                             color: Colors.white60,
// // //                           ),
// // //                           Column(
// // //                             children: [
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'Total Jarak Tempuh',
// // //                                       style: TextStyle(color: Colors.white60),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       ': ${totalDistance.toStringAsFixed(2)} nmi',
// // //                                       style: TextStyle(color: Colors.white60),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                               Row(
// // //                                 children: [
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       'Total Waktu Berlayar',
// // //                                       style: TextStyle(color: Colors.white60),
// // //                                     ),
// // //                                   ),
// // //                                   Expanded(
// // //                                     child: Text(
// // //                                       ':',
// // //                                       style: TextStyle(color: Colors.white60),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   Expanded(
// // //                     child: ListView.builder(
// // //                       itemCount: dailyDistances.keys.length,
// // //                       itemBuilder: (context, index) {
// // //                         String date = dailyDistances.keys.elementAt(index);
// // //                         String timeRange = dateRanges[date] ?? '';
// // //                         return TabCard(
// // //                           tanggalBerlayar:
// // //                               '${_formatDateRange(date, timeRange)}',
// // //                           jarak:
// // //                               '${dailyDistances[date]?.toStringAsFixed(2)} nmi',
// // //                           lamaBerlayar: '-',
// // //                         );
// // //                       },
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             )
// // //           : Center(
// // //               child: Text('Tidak ada data untuk ditampilkan'),
// // //             ),
// // //     );
// // //   }
// // // }

// // // // import 'dart:math';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:geotraking/core/components/app_back_button.dart';
// // // // import 'package:geotraking/views/profile/report/jaraktempuh/components/tab_card.dart';
// // // // import 'package:intl/intl.dart';

// // // // class DetailPage extends StatelessWidget {
// // // //   final List<Map<String, dynamic>>? data;
// // // //   final DateTime? startDate;
// // // //   final DateTime? endDate;

// // // //   const DetailPage({
// // // //     Key? key,
// // // //     this.data,
// // // //     this.startDate,
// // // //     this.endDate,
// // // //   }) : super(key: key);

// // // //   double _calculateDistance(
// // // //       double lat1, double lon1, double lat2, double lon2) {
// // // //     const double R = 3440.065;

// // // //     double dLat = _toRadians(lat2 - lat1);
// // // //     double dLon = _toRadians(lon2 - lon1);

// // // //     double a = sin(dLat / 2) * sin(dLat / 2) +
// // // //         cos(_toRadians(lat1)) *
// // // //             cos(_toRadians(lat2)) *
// // // //             sin(dLon / 2) *
// // // //             sin(dLon / 2);
// // // //     double c = 2 * atan2(sqrt(a), sqrt(1 - a));

// // // //     return R * c;
// // // //   }

// // // //   double _toRadians(double degrees) {
// // // //     return degrees * (pi / 180);
// // // //   }

// // // //   Map<String, dynamic> _calculateTotalDistance() {
// // // //     double totalDistance = 0;
// // // //     Map<String, double> dailyDistances = {};
// // // //     Map<String, String> dateRanges = {};
// // // //     Map<String, Duration> dailySailingTime =
// // // //         {}; // Tambahkan ini untuk waktu berlayar per hari

// // // //     for (var item in data!) {
// // // //       String date = item['tgl_aktifasi'].toString().split(' ')[0];
// // // //       String time = item['tgl_aktifasi'].toString().split(' ')[1];

// // // //       if (!dateRanges.containsKey(date)) {
// // // //         dateRanges[date] = '$time - $time';
// // // //       } else {
// // // //         String existingRange = dateRanges[date]!;
// // // //         String startTime = existingRange.split(' - ')[0];
// // // //         dateRanges[date] = '$startTime - $time';
// // // //       }
// // // //     }

// // // //     for (var entry in dateRanges.entries) {
// // // //       String date = entry.key;
// // // //       Map<String, dynamic>? startPoint;
// // // //       Map<String, dynamic>? endPoint;

// // // //       for (var item in data!) {
// // // //         if (item['tgl_aktifasi'].toString().split(' ')[0] == date) {
// // // //           if (item['data_type'] == 1) {
// // // //             startPoint = item;
// // // //           } else if (item['data_type'] == 2) {
// // // //             endPoint = item;
// // // //           }
// // // //         }
// // // //       }

// // // //       if (startPoint != null && endPoint != null) {
// // // //         double distance = _calculateDistance(
// // // //           double.parse(startPoint['latitude'].toString()),
// // // //           double.parse(startPoint['longitude'].toString()),
// // // //           double.parse(endPoint['latitude'].toString()),
// // // //           double.parse(endPoint['longitude'].toString()),
// // // //         );

// // // //         totalDistance += distance;
// // // //         dailyDistances[date] = (dailyDistances[date] ?? 0) + distance;

// // // //         // Menghitung waktu berlayar per hari
// // // //         DateTime startDateTime = DateTime.parse(startPoint['tgl_aktifasi']);
// // // //         DateTime endDateTime = DateTime.parse(endPoint['tgl_aktifasi']);
// // // //         dailySailingTime[date] = endDateTime.difference(startDateTime);
// // // //       }
// // // //     }

// // // //     return {
// // // //       'totalDistance': totalDistance,
// // // //       'dailyDistances': dailyDistances,
// // // //       'dateRanges': dateRanges,
// // // //       'dailySailingTime': dailySailingTime, // Tambahkan ini ke hasil return
// // // //     };
// // // //   }

// // // //   String _formatDateRange(String date, String timeRange) {
// // // //     DateTime startDateTime =
// // // //         DateTime.parse(date + ' ' + timeRange.split(' - ')[0]);
// // // //     String endTime = timeRange.split(' - ')[1];

// // // //     DateFormat dateFormat = DateFormat('dd MMM yyyy hh:mm a');
// // // //     String formattedStartDate = dateFormat.format(startDateTime);

// // // //     DateTime endDateTime = DateTime.parse(date + ' ' + endTime);
// // // //     String formattedEndTime = DateFormat('hh:mm a').format(endDateTime);

// // // //     return '$formattedStartDate - $formattedEndTime';
// // // //   }

// // // //   String _formatTotalSailingTime() {
// // // //     Duration totalDuration = endDate!.difference(startDate!);
// // // //     return '${totalDuration.inHours} jam ${totalDuration.inMinutes.remainder(60)} menit';
// // // //   }

// // // //   String _formatDailySailingTime(Duration duration) {
// // // //     return '${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit';
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     Map<String, dynamic> distances = _calculateTotalDistance();
// // // //     double totalDistance = distances['totalDistance'];
// // // //     Map<String, double> dailyDistances = distances['dailyDistances'];
// // // //     Map<String, String> dateRanges = distances['dateRanges'];
// // // //     Map<String, Duration> dailySailingTime =
// // // //         distances['dailySailingTime']; // Ambil waktu berlayar per hari

// // // //     return Scaffold(
// // // //       backgroundColor: Colors.white,
// // // //       appBar: AppBar(
// // // //         title: Text('Back'),
// // // //         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
// // // //               color: Colors.black,
// // // //             ),
// // // //         leading: const AppBackButton(),
// // // //         backgroundColor: Colors.white,
// // // //       ),
// // // //       body: data != null && data!.isNotEmpty
// // // //           ? Padding(
// // // //               padding: const EdgeInsets.all(15),
// // // //               child: Column(
// // // //                 children: [
// // // //                   Container(
// // // //                     padding: const EdgeInsets.all(5),
// // // //                     margin: const EdgeInsets.all(5),
// // // //                     decoration: BoxDecoration(
// // // //                       color: Color.fromARGB(255, 127, 183, 126),
// // // //                       borderRadius: BorderRadius.circular(8),
// // // //                       boxShadow: [
// // // //                         BoxShadow(
// // // //                           color: Colors.grey.withOpacity(0.3),
// // // //                           spreadRadius: 2,
// // // //                           blurRadius: 5,
// // // //                           offset: Offset(0, 2),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                     child: Padding(
// // // //                       padding: const EdgeInsets.all(10),
// // // //                       child: Column(
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           Text(
// // // //                             'Tanggal: ${DateFormat('dd MMM yyyy').format(startDate!)} - ${DateFormat('dd MMM yyyy').format(endDate!)}',
// // // //                             style: TextStyle(
// // // //                               fontSize: 18,
// // // //                               color: Colors.white,
// // // //                             ),
// // // //                           ),
// // // //                           Divider(
// // // //                             thickness: 0.5,
// // // //                             color: Colors.white60,
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                   Container(
// // // //                     padding: const EdgeInsets.all(5),
// // // //                     margin: const EdgeInsets.all(5),
// // // //                     decoration: BoxDecoration(
// // // //                       color: Color.fromARGB(255, 127, 183, 126),
// // // //                       borderRadius: BorderRadius.circular(8),
// // // //                       boxShadow: [
// // // //                         BoxShadow(
// // // //                           color: Colors.grey.withOpacity(0.3),
// // // //                           spreadRadius: 2,
// // // //                           blurRadius: 5,
// // // //                           offset: Offset(0, 2),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                     child: Padding(
// // // //                       padding: const EdgeInsets.all(10),
// // // //                       child: Column(
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           Text(
// // // //                             'Data Jarak Tempuh',
// // // //                             style: TextStyle(
// // // //                               fontSize: 18,
// // // //                               color: Colors.white,
// // // //                             ),
// // // //                           ),
// // // //                           Divider(
// // // //                             thickness: 0.5,
// // // //                             color: Colors.white60,
// // // //                           ),
// // // //                           Column(
// // // //                             children: [
// // // //                               Row(
// // // //                                 children: [
// // // //                                   Expanded(
// // // //                                     child: Text(
// // // //                                       'Total Jarak',
// // // //                                       style: TextStyle(color: Colors.white60),
// // // //                                     ),
// // // //                                   ),
// // // //                                   Expanded(
// // // //                                     child: Text(
// // // //                                       ': ${totalDistance.toStringAsFixed(2)} nmi',
// // // //                                       style: TextStyle(color: Colors.white60),
// // // //                                     ),
// // // //                                   ),
// // // //                                 ],
// // // //                               ),
// // // //                               Row(
// // // //                                 children: [
// // // //                                   Expanded(
// // // //                                     child: Text(
// // // //                                       'Waktu Berlayar',
// // // //                                       style: TextStyle(color: Colors.white60),
// // // //                                     ),
// // // //                                   ),
// // // //                                   Expanded(
// // // //                                     child: Text(
// // // //                                       ': ${_formatTotalSailingTime()}',
// // // //                                       style: TextStyle(color: Colors.white60),
// // // //                                     ),
// // // //                                   ),
// // // //                                 ],
// // // //                               ),
// // // //                             ],
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                   Expanded(
// // // //                     child: ListView.builder(
// // // //                       itemCount: dailyDistances.keys.length,
// // // //                       itemBuilder: (context, index) {
// // // //                         String date = dailyDistances.keys.elementAt(index);
// // // //                         String timeRange = dateRanges[date] ?? '';
// // // //                         Duration sailingTime =
// // // //                             dailySailingTime[date] ?? Duration.zero;

// // // //                         return TabCard(
// // // //                           tanggalBerlayar: date,
// // // //                           jarak: dailyDistances[date]!.toStringAsFixed(2),
// // // //                           lamaBerlayar: _formatDailySailingTime(sailingTime),
// // // //                         );
// // // //                       },
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             )
// // // //           : const Center(
// // // //               child: Text('Tidak ada data tersedia'),
// // // //             ),
// // // //     );
// // // //   }
// // // // }

// // import 'package:flutter/material.dart';
// // import 'package:geotraking/core/components/app_back_button.dart';
// // import 'package:geotraking/views/profile/report/jaraktempuh/components/tab_card.dart';
// // import 'package:intl/intl.dart';
// // import 'dart:math';

// // class DetailPage extends StatelessWidget {
// //   final List<Map<String, dynamic>>? data;
// //   final DateTime? startDate;
// //   final DateTime? endDate;

// //   const DetailPage({
// //     Key? key,
// //     this.data,
// //     this.startDate,
// //     this.endDate,
// //   }) : super(key: key);

// //   double _calculateDistance(
// //       double lat1, double lon1, double lat2, double lon2) {
// //     const double R = 3440.065;

// //     double dLat = _toRadians(lat2 - lat1);
// //     double dLon = _toRadians(lon2 - lon1);

// //     double a = sin(dLat / 2) * sin(dLat / 2) +
// //         cos(_toRadians(lat1)) *
// //             cos(_toRadians(lat2)) *
// //             sin(dLon / 2) *
// //             sin(dLon / 2);
// //     double c = 2 * atan2(sqrt(a), sqrt(1 - a));

// //     return R * c;
// //   }

// //   double _toRadians(double degrees) {
// //     return degrees * (pi / 180);
// //   }

// //   Map<String, dynamic> _calculateTotalDistance() {
// //     double totalDistance = 0;
// //     Map<String, double> dailyDistances = {};
// //     Map<String, String> dateRanges = {};
// //     Map<String, Duration> dailyDurations = {};

// //     for (var item in data!) {
// //       String date = item['tgl_aktifasi'].toString().split(' ')[0];
// //       String time = item['tgl_aktifasi'].toString().split(' ')[1];

// //       if (!dateRanges.containsKey(date)) {
// //         dateRanges[date] = '$time - $time';
// //       } else {
// //         String existingRange = dateRanges[date]!;
// //         String startTime = existingRange.split(' - ')[0];
// //         dateRanges[date] = '$startTime - $time';
// //       }
// //     }

// //     for (var entry in dateRanges.entries) {
// //       String date = entry.key;
// //       Map<String, dynamic>? startPoint;
// //       Map<String, dynamic>? endPoint;

// //       for (var item in data!) {
// //         if (item['tgl_aktifasi'].toString().split(' ')[0] == date) {
// //           if (item['data_type'] == 1) {
// //             startPoint = item;
// //           } else if (item['data_type'] == 2) {
// //             endPoint = item;
// //           }
// //         }
// //       }

// //       if (startPoint != null && endPoint != null) {
// //         double distance = _calculateDistance(
// //           double.parse(startPoint['latitude'].toString()),
// //           double.parse(startPoint['longitude'].toString()),
// //           double.parse(endPoint['latitude'].toString()),
// //           double.parse(endPoint['longitude'].toString()),
// //         );

// //         totalDistance += distance;
// //         dailyDistances[date] = (dailyDistances[date] ?? 0) + distance;

// //         String startTime = startPoint['tgl_aktifasi'].toString().split(' ')[1];
// //         String endTime = endPoint['tgl_aktifasi'].toString().split(' ')[1];
// //         Duration duration = _calculateDuration(startTime, endTime);
// //         dailyDurations[date] = duration;
// //       }
// //     }

// //     return {
// //       'totalDistance': totalDistance,
// //       'dailyDistances': dailyDistances,
// //       'dateRanges': dateRanges,
// //       'dailyDurations': dailyDurations,
// //     };
// //   }

// //   Map<String, int> _calculateTotalSailingTime(Map<String, String> dateRanges) {
// //     int totalMinutes = 0;

// //     for (String timeRange in dateRanges.values) {
// //       String startTime = timeRange.split(' - ')[0];
// //       String endTime = timeRange.split(' - ')[1];

// //       DateTime startDateTime = DateTime.parse("2000-01-01 $startTime");
// //       DateTime endDateTime = DateTime.parse("2000-01-01 $endTime");

// //       totalMinutes += endDateTime.difference(startDateTime).inMinutes;
// //     }

// //     int days = totalMinutes ~/ (24 * 60);
// //     totalMinutes %= (24 * 60);
// //     int hours = totalMinutes ~/ 60;
// //     int minutes = totalMinutes % 60;

// //     return {
// //       'days': days,
// //       'hours': hours,
// //       'minutes': minutes,
// //     };
// //   }

// //   Duration _calculateDuration(String startTime, String endTime) {
// //     DateTime startDateTime = DateFormat("HH:mm:ss").parse(startTime);
// //     DateTime endDateTime = DateFormat("HH:mm:ss").parse(endTime);
// //     return endDateTime.difference(startDateTime);
// //   }

// //   String _formatDuration(Duration duration) {
// //     String twoDigits(int n) => n.toString().padLeft(2, '0');
// //     String twoDigitHours = twoDigits(duration.inHours);
// //     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
// //     return '$twoDigitHours jam $twoDigitMinutes menit';
// //   }

// //   String _formatDateRange(String date, String timeRange) {
// //     DateTime startDateTime =
// //         DateTime.parse(date + ' ' + timeRange.split(' - ')[0]);
// //     String endTime = timeRange.split(' - ')[1];

// //     DateFormat dateFormat = DateFormat('dd MMM yyyy hh:mm a');
// //     String formattedStartDate = dateFormat.format(startDateTime);

// //     DateTime endDateTime = DateTime.parse(date + ' ' + endTime);
// //     String formattedEndTime = DateFormat('hh:mm a').format(endDateTime);

// //     return '$formattedStartDate - $formattedEndTime';
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     Map<String, dynamic> distances = _calculateTotalDistance();
// //     double totalDistance = distances['totalDistance'];
// //     Map<String, double> dailyDistances = distances['dailyDistances'];
// //     Map<String, String> dateRanges = distances['dateRanges'];
// //     Map<String, Duration> dailyDurations = distances['dailyDurations'];

// //     Map<String, int> totalSailingTime = _calculateTotalSailingTime(dateRanges);

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
// //       body: data != null && data!.isNotEmpty
// //           ? Padding(
// //               padding: const EdgeInsets.all(15),
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(5),
// //                     margin: const EdgeInsets.all(5),
// //                     decoration: BoxDecoration(
// //                       color: Color.fromARGB(255, 127, 183, 126),
// //                       borderRadius: BorderRadius.circular(8),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.grey.withOpacity(0.3),
// //                           spreadRadius: 2,
// //                           blurRadius: 5,
// //                           offset: Offset(0, 2),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(10),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Row(
// //                             crossAxisAlignment: CrossAxisAlignment.center,
// //                             children: [
// //                               Icon(
// //                                 Icons.calendar_today,
// //                                 color: Colors.white,
// //                                 size: 24,
// //                               ),
// //                               SizedBox(width: 8),
// //                               Text(
// //                                 '${startDate != null && endDate != null ? "${DateFormat('dd MMM yyyy').format(startDate!)} - ${DateFormat('dd MMM yyyy').format(endDate!)}" : "No date selected"}',
// //                                 style: TextStyle(
// //                                   fontSize: 18,
// //                                   color: Colors.white,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           Divider(
// //                             thickness: 0.5,
// //                             color: Colors.white60,
// //                           ),
// //                           Column(
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'Total Jarak Tempuh',
// //                                       style: TextStyle(color: Colors.white60),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       ': ${totalDistance.toStringAsFixed(2)} nmi',
// //                                       style: TextStyle(color: Colors.white60),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Text(
// //                                       'Total Waktu Berlayar',
// //                                       style: TextStyle(color: Colors.white60),
// //                                     ),
// //                                   ),
// //                                   Expanded(
// //                                     child: Text(
// //                                       // ':',
// //                                       ': ${totalSailingTime['days']} hari ${totalSailingTime['hours']} jam ${totalSailingTime['minutes']} menit',
// //                                       style: TextStyle(color: Colors.white60),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   Expanded(
// //                     child: ListView.builder(
// //                       itemCount: dailyDistances.keys.length,
// //                       itemBuilder: (context, index) {
// //                         String date = dailyDistances.keys.elementAt(index);
// //                         String timeRange = dateRanges[date] ?? '';
// //                         Duration duration =
// //                             dailyDurations[date] ?? Duration.zero;

// //                         return TabCard(
// //                           tanggalBerlayar:
// //                               '${_formatDateRange(date, timeRange)}',
// //                           jarak:
// //                               '${dailyDistances[date]?.toStringAsFixed(2)} nmi',
// //                           lamaBerlayar: _formatDuration(duration),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             )
// //           : Center(
// //               child: Text('Tidak ada data untuk ditampilkan'),
// //             ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/app_back_button.dart';
// import 'package:geotraking/views/profile/report/jaraktempuh/components/tab_card.dart';
// import 'package:intl/intl.dart';
// import 'dart:math';

// double calculateDistanceNmi(
//     double startLat, double startLon, double endLat, double endLon) {
//   const R = 3440.07;
//   double lat1 = startLat * pi / 180;
//   double lon1 = startLon * pi / 180;
//   double lat2 = endLat * pi / 180;
//   double lon2 = endLon * pi / 180;

//   double dlat = lat2 - lat1;
//   double dlon = lon2 - lon1;

//   double a = sin(dlat / 2) * sin(dlat / 2) +
//       cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);
//   double c = 2 * atan2(sqrt(a), sqrt(1 - a));

//   return R * c;
// }

// class DetailPage extends StatelessWidget {
//   final List<Map<String, dynamic>>? data;
//   final DateTime? startDate;
//   final DateTime? endDate;

//   DetailPage({Key? key, this.data, this.startDate, this.endDate})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double totalDistance = 0;
//     int totalHours = 0;
//     int totalMinutes = 0;

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
//       body: data != null && data!.isNotEmpty
//           ? Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(5),
//                     margin: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: Color.fromARGB(255, 127, 183, 126),
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.calendar_today,
//                                 color: Colors.white,
//                                 size: 24,
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 '${startDate != null && endDate != null ? "${DateFormat('dd MMM yyyy').format(startDate!)} - ${DateFormat('dd MMM yyyy').format(endDate!)}" : "No date selected"}',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Divider(
//                             thickness: 0.5,
//                             color: Colors.white60,
//                           ),
//                           Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'Total Jarak Tempuh',
//                                       style: TextStyle(color: Colors.white60),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       ': ${totalDistance.toStringAsFixed(2)} nmi',
//                                       style: TextStyle(color: Colors.white60),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'Total Waktu Berlayar',
//                                       style: TextStyle(color: Colors.white60),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       ': ${totalHours} jam ${totalMinutes} menit',
//                                       style: TextStyle(color: Colors.white60),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: data!.length,
//                       itemBuilder: (context, index) {
//                         final item = data![index];
//                         double distanceNmi = calculateDistanceNmi(
//                           double.parse(item['start_latitude']),
//                           double.parse(item['start_longitude']),
//                           double.parse(item['end_latitude']),
//                           double.parse(item['end_longitude']),
//                         );

//                         totalDistance += distanceNmi;
//                         DateTime startTime = item['waktu_awal'];
//                         DateTime endTime = item['waktu_akhir'];

//                         Duration sailingDuration =
//                             endTime.difference(startTime);

//                         totalHours += sailingDuration.inHours;
//                         totalMinutes += sailingDuration.inMinutes % 60;

//                         return TabCard(
//                           tanggalBerlayar:
//                               '${DateFormat('dd MMM yyyy').format((item['tgl_aktifasi']))} ${DateFormat('hh:mm a').format((item['waktu_awal']))} - ${DateFormat('hh:mm a').format((item['waktu_akhir']))}',
//                           jarak: '${distanceNmi.toStringAsFixed(2)} nmi',
//                           lamaBerlayar: '${item['duration']}',
//                           rerataSpeed:
//                               '${item['average_speed_kmh']} kmh - ${item['average_speed_knots']} knots',
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : Center(
//               child: Text('Tidak ada data untuk ditampilkan'),
//             ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/views/profile/components/modal/mileage/components/mileage_location_page.dart';
import 'package:geotraking/views/profile/components/modal/mileage/components/tab_card.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_file/open_file.dart';
import 'dart:math';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class MileageDetailPage extends StatelessWidget {
  final List<Map<String, dynamic>>? data;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? vesselName;
  final String? mobileId;

  MileageDetailPage(
      {Key? key,
      this.data,
      this.startDate,
      this.endDate,
      this.vesselName,
      this.mobileId})
      : super(key: key);

  // Fungsi untuk menghitung jarak antara dua titik dalam nautical miles
  double calculateDistanceNmi(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusNmi = 3440.07; // Radius bumi dalam nautical miles

    double dLat = (lat2 - lat1) * (pi / 180.0);
    double dLon = (lon2 - lon1) * (pi / 180.0);

    // Konversi koordinat ke radian
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180.0)) *
            cos(lat2 * (pi / 180.0)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadiusNmi * c;
  }

// Fungsi untuk menghitung total jarak tempuh
  // double calculateTotalDistance(List<Map<String, dynamic>> data) {
  //   double totalDistance = 0;

  //   for (int i = 0; i < data.length - 1; i++) {
  //     var current = data[i];
  //     var next = data[i + 1];

  //     double speed = double.parse(current['speed_kn'].toString());

  //     // Hanya hitung jika kecepatan lebih dari 0.1 knots
  //     if (speed > 0.1) {
  //       double startLat = double.parse(current['latitude'].toString());
  //       double startLon = double.parse(current['longitude'].toString());
  //       double endLat = double.parse(next['latitude'].toString());
  //       double endLon = double.parse(next['longitude'].toString());

  //       // Tambahkan jarak antara titik saat ini dan titik berikutnya
  //       double distanceNmi =
  //           calculateDistanceNmi(startLat, startLon, endLat, endLon);
  //       totalDistance += distanceNmi;
  //     }
  //   }

  //   return totalDistance;
  // }

// // Fungsi untuk menghitung total jarak tempuh
//   double calculateTotalDistance(List<Map<String, dynamic>> locations) {
//     double totalDistance = 0;

//     for (int i = 0; i < locations.length - 1; i++) {
//       var current = locations[i];
//       var next = locations[i + 1];

//       // Mengambil latitude dan longitude, dengan konversi ke double jika perlu
//       double startLat = double.tryParse(current['latitude'].toString()) ?? 0.0;
//       double startLon = double.tryParse(current['longitude'].toString()) ?? 0.0;
//       double endLat = double.tryParse(next['latitude'].toString()) ?? 0.0;
//       double endLon = double.tryParse(next['longitude'].toString()) ?? 0.0;

//       // Hitung jarak
//       double distanceNmi =
//           calculateDistanceNmi(startLat, startLon, endLat, endLon);
//       totalDistance += distanceNmi;
//     }

//     return totalDistance;
//   }

// Fungsi untuk menghitung total jarak tempuh
  double calculateTotalDistance(List<Map<String, dynamic>> locations) {
    double totalDistance = 0;

    for (int i = 0; i < locations.length - 1; i++) {
      var current = locations[i];
      var next = locations[i + 1];

      // Mengambil latitude dan longitude, dengan konversi ke double jika perlu
      double startLat = double.tryParse(current['latitude'].toString()) ?? 0.0;
      double startLon = double.tryParse(current['longitude'].toString()) ?? 0.0;
      double endLat = double.tryParse(next['latitude'].toString()) ?? 0.0;
      double endLon = double.tryParse(next['longitude'].toString()) ?? 0.0;

      // Mengambil speed_kn, dengan konversi ke double jika perlu
      double speed = double.tryParse(current['speed_kn'].toString()) ?? 0.0;

      // Hitung jarak hanya jika speed_kn >= 0.1
      if (speed >= 0.1) {
        double distanceNmi =
            calculateDistanceNmi(startLat, startLon, endLat, endLon);
        totalDistance += distanceNmi;
      }
    }

    return totalDistance;
  }

// Fungsi untuk memproses data kapal
  // List<Map<String, String>> processVesselData(List<Map<String, dynamic>> data) {
  //   Map<String, DateTime> minTimestamps = {};
  //   Map<String, DateTime> maxTimestamps = {};
  //   Map<String, double> totalSpeeds = {};
  //   Map<String, int> entryCounts = {};
  //   Map<String, double> minSpeeds = {};
  //   Map<String, double> maxSpeeds = {};
  //   Map<String, List<Map<String, dynamic>>> dailyLocations = {};

  //   // Proses data untuk mendapatkan min dan max timestamp, kecepatan, dan lokasi untuk setiap tanggal
  //   for (var row in data) {
  //     String receivedString = row['received'];
  //     DateTime received;

  //     // Coba parsing tanggal
  //     try {
  //       received = DateTime.parse(receivedString);
  //     } catch (e) {
  //       print('Error parsing date: $receivedString');
  //       continue; // Lewati jika tidak bisa diparse
  //     }

  //     String dateKey = DateFormat('yyyy-MM-dd').format(received);

  //     // Update min dan max timestamp untuk setiap tanggal
  //     if (!minTimestamps.containsKey(dateKey) ||
  //         received.isBefore(minTimestamps[dateKey]!)) {
  //       minTimestamps[dateKey] = received;
  //     }
  //     if (!maxTimestamps.containsKey(dateKey) ||
  //         received.isAfter(maxTimestamps[dateKey]!)) {
  //       maxTimestamps[dateKey] = received;
  //     }

  //     // Simpan lokasi untuk menghitung jarak
  //     if (!dailyLocations.containsKey(dateKey)) {
  //       dailyLocations[dateKey] = [];
  //     }
  //     dailyLocations[dateKey]!.add({
  //       'latitude': double.tryParse(row['latitude'].toString()) ?? 0.0,
  //       'longitude': double.tryParse(row['longitude'].toString()) ?? 0.0,
  //       'received': received,
  //       'speed_kn': double.tryParse(row['speed_kn'].toString()) ?? 0.0,
  //     });

  //     // Jumlahkan kecepatan dan hitung entri untuk perhitungan kecepatan rata-rata
  //     double speed = double.tryParse(row['speed_kn'].toString()) ?? 0.0;
  //     totalSpeeds[dateKey] = (totalSpeeds[dateKey] ?? 0.0) + speed;
  //     entryCounts[dateKey] =
  //         (entryCounts[dateKey] ?? 1) + 1; // Hindari pembagian dengan nol

  //     // Update kecepatan min dan max
  //     if (!minSpeeds.containsKey(dateKey) || speed < minSpeeds[dateKey]!) {
  //       minSpeeds[dateKey] = speed;
  //     }
  //     if (!maxSpeeds.containsKey(dateKey) || speed > maxSpeeds[dateKey]!) {
  //       maxSpeeds[dateKey] = speed;
  //     }
  //   }

  //   // Siapkan data yang telah diproses untuk ditampilkan
  //   List<Map<String, String>> processedData = [];
  //   for (var date in minTimestamps.keys) {
  //     String formattedDate =
  //         DateFormat('dd MMM yyyy').format(minTimestamps[date]!);
  //     String jamAwal = DateFormat('hh:mm a').format(minTimestamps[date]!);
  //     String jamAkhir = DateFormat('hh:mm a').format(maxTimestamps[date]!);

  //     // Hitung durasi
  //     Duration duration = maxTimestamps[date]!.difference(minTimestamps[date]!);
  //     String formattedDuration =
  //         '${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit';

  //     // Hitung kecepatan rata-rata
  //     double totalSpeed = totalSpeeds[date] ?? 0.0;
  //     int count = entryCounts[date] ?? 1; // Hindari pembagian dengan nol
  //     double averageSpeed = totalSpeed / count;
  //     String formattedAverageSpeed =
  //         'avg speed ${averageSpeed.toStringAsFixed(2)} knots';

  //     // Dapatkan kecepatan min dan max
  //     double minSpeed = minSpeeds[date] ?? 0.0;
  //     double maxSpeed = maxSpeeds[date] ?? 0.0;

  //     // Hitung total jarak untuk hari ini
  //     double totalDistance = calculateTotalDistance(dailyLocations[date]!);

  //     processedData.add({
  //       'formattedDate': formattedDate,
  //       'jamAwal': jamAwal,
  //       'jamAkhir': jamAkhir,
  //       'duration': formattedDuration,
  //       'averageSpeed': formattedAverageSpeed,
  //       'minSpeed': '${minSpeed.toStringAsFixed(2)} knots',
  //       'maxSpeed': '${maxSpeed.toStringAsFixed(2)} knots',
  //       'totalDistance': (totalDistance > 0.0)
  //           ? '${totalDistance.toStringAsFixed(2)} nmi'
  //           : 'N/A',
  //     });
  //   }
  //   return processedData;
  // }

  // // Fungsi untuk menghitung total jarak tempuh
//   double calculateTotalDistance(List<Map<String, dynamic>> locations) {
//     double totalDistance = 0;

//     for (int i = 0; i < locations.length - 1; i++) {
//       var current = locations[i];
//       var next = locations[i + 1];

//       // Mengambil latitude dan longitude, dengan konversi ke double jika perlu
//       double startLat = double.tryParse(current['latitude'].toString()) ?? 0.0;
//       double startLon = double.tryParse(current['longitude'].toString()) ?? 0.0;
//       double endLat = double.tryParse(next['latitude'].toString()) ?? 0.0;
//       double endLon = double.tryParse(next['longitude'].toString()) ?? 0.0;

//       // Mengambil kecepatan dan pastikan dalam bentuk double
//       double speedCurrent =
//           double.tryParse(current['speed_kn'].toString()) ?? 0.0;
//       double speedNext = double.tryParse(next['speed_kn'].toString()) ?? 0.0;

//       // Hitung jarak hanya jika kedua kecepatan lebih dari 0.1 knots
//       if (speedCurrent > 0.1 && speedNext > 0.1) {
//         double distanceNmi =
//             calculateDistanceNmi(startLat, startLon, endLat, endLon);
//         totalDistance += distanceNmi;
//       }
//     }

//     return totalDistance;
//   }

// // Fungsi untuk memproses data kapal
//   List<Map<String, String>> processVesselData(List<Map<String, dynamic>> data) {
//     Map<String, DateTime> minTimestamps = {};
//     Map<String, DateTime> maxTimestamps = {};
//     Map<String, double> totalSpeeds = {};
//     Map<String, int> entryCounts = {};
//     Map<String, double> minSpeeds = {};
//     Map<String, double> maxSpeeds = {};
//     Map<String, List<Map<String, dynamic>>> dailyLocations = {};

//     // Proses data untuk mendapatkan min dan max timestamp, kecepatan, dan lokasi untuk setiap tanggal
//     for (var row in data) {
//       DateTime received = DateTime.parse(row['received']);
//       String dateKey = DateFormat('yyyy-MM-dd').format(received);

//       // Update min dan max timestamp untuk setiap tanggal
//       if (!minTimestamps.containsKey(dateKey) ||
//           received.isBefore(minTimestamps[dateKey]!)) {
//         minTimestamps[dateKey] = received;
//       }
//       if (!maxTimestamps.containsKey(dateKey) ||
//           received.isAfter(maxTimestamps[dateKey]!)) {
//         maxTimestamps[dateKey] = received;
//       }

//       // Simpan lokasi untuk menghitung jarak
//       if (!dailyLocations.containsKey(dateKey)) {
//         dailyLocations[dateKey] = [];
//       }
//       dailyLocations[dateKey]!.add({
//         'latitude': double.tryParse(row['latitude'].toString()) ?? 0.0,
//         'longitude': double.tryParse(row['longitude'].toString()) ?? 0.0,
//         'received': received,
//         'speed_kn': double.tryParse(row['speed_kn'].toString()) ?? 0.0,
//       });

//       // Jumlahkan kecepatan dan hitung entri untuk perhitungan kecepatan rata-rata
//       double speed = double.tryParse(row['speed_kn'].toString()) ?? 0.0;
//       totalSpeeds[dateKey] = (totalSpeeds[dateKey] ?? 0.0) + speed;
//       entryCounts[dateKey] =
//           (entryCounts[dateKey] ?? 1) + 1; // Hindari pembagian dengan nol

//       // Update kecepatan min dan max
//       if (!minSpeeds.containsKey(dateKey) || speed < minSpeeds[dateKey]!) {
//         minSpeeds[dateKey] = speed;
//       }
//       if (!maxSpeeds.containsKey(dateKey) || speed > maxSpeeds[dateKey]!) {
//         maxSpeeds[dateKey] = speed;
//       }
//     }

//     // Siapkan data yang telah diproses untuk ditampilkan
//     List<Map<String, String>> processedData = [];
//     for (var date in minTimestamps.keys) {
//       String formattedDate =
//           DateFormat('dd MMM yyyy').format(minTimestamps[date]!);
//       String jamAwal = DateFormat('hh:mm a').format(minTimestamps[date]!);
//       String jamAkhir = DateFormat('hh:mm a').format(maxTimestamps[date]!);

//       // Hitung durasi
//       Duration duration = maxTimestamps[date]!.difference(minTimestamps[date]!);
//       String formattedDuration =
//           '${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit';

//       // Hitung kecepatan rata-rata
//       double totalSpeed = totalSpeeds[date] ?? 0.0;
//       int count = entryCounts[date] ?? 1; // Hindari pembagian dengan nol
//       double averageSpeed = totalSpeed / count;
//       String formattedAverageSpeed =
//           'avg speed ${averageSpeed.toStringAsFixed(2)} knots';

//       // Dapatkan kecepatan min dan max
//       double minSpeed = minSpeeds[date] ?? 0.0;
//       double maxSpeed = maxSpeeds[date] ?? 0.0;

//       // Hitung total jarak untuk hari ini
//       double totalDistance = calculateTotalDistance(dailyLocations[date]!);

//       processedData.add({
//         'formattedDate': formattedDate,
//         'jamAwal': jamAwal,
//         'jamAkhir': jamAkhir,
//         'duration': formattedDuration,
//         'averageSpeed': formattedAverageSpeed,
//         'minSpeed': '${minSpeed.toStringAsFixed(2)} knots',
//         'maxSpeed': '${maxSpeed.toStringAsFixed(2)} knots',
//         'totalDistance': (totalDistance > 0.0)
//             ? '${totalDistance.toStringAsFixed(2)} nmi'
//             : 'N/A',
//       });
//     }
//     return processedData;
//   }

  // Menghitung jumlah hari unik dari data
  int calculateUniqueDays(List<Map<String, dynamic>> data) {
    // Menggunakan Set untuk menyimpan tanggal unik
    Set<String> uniqueDates = {};

    for (var entry in data) {
      // Mendapatkan tanggal dari varTimestamp
      String dateOnly = DateFormat('yyyy-MM-dd').format(entry['received']);
      uniqueDates.add(dateOnly); // Menambahkan tanggal ke dalam Set
    }

    return uniqueDates.length; // Mengembalikan jumlah tanggal unik
  }

  // hitung total average speed
  double _calculateAverageSpeed() {
    double totalSpeed = 0;
    int count = 0;

    if (data != null && data!.isNotEmpty) {
      for (var item in data!) {
        double speedKn = double.parse(item['speed_kn'].toString());

        // Hanya menghitung speed_kn yang lebih dari 0.1
        if (speedKn > 0.1) {
          totalSpeed += speedKn;
          count++;
        }
      }

      // Menghitung rata-rata jika ada kecepatan yang memenuhi kondisi
      return count > 0 ? totalSpeed / count : 0;
    }

    return 0;
  }

  // List<Map<String, String>> processVesselData(List<Map<String, dynamic>> data) {
  //   Map<String, DateTime> minTimestamps = {};
  //   Map<String, DateTime> maxTimestamps = {};

  //   // Process the data to get min and max timestamps for each date
  //   for (var row in data) {
  //     DateTime received = row['received'];
  //     String dateKey = DateFormat('yyyy-MM-dd').format(received);

  //     // Update min and max timestamps for each date
  //     if (!minTimestamps.containsKey(dateKey) ||
  //         received.isBefore(minTimestamps[dateKey]!)) {
  //       minTimestamps[dateKey] = received;
  //     }

  //     if (!maxTimestamps.containsKey(dateKey) ||
  //         received.isAfter(maxTimestamps[dateKey]!)) {
  //       maxTimestamps[dateKey] = received;
  //     }
  //   }

  //   // Prepare processed data for display
  //   List<Map<String, String>> processedData = [];
  //   for (var date in minTimestamps.keys) {
  //     String formattedDate =
  //         DateFormat('dd MMM yyyy').format(DateTime.parse(date));
  //     String jamAwal = DateFormat('hh:mm a').format(minTimestamps[date]!);
  //     String jamAkhir = DateFormat('hh:mm a').format(maxTimestamps[date]!);

  //     processedData.add({
  //       'formattedDate': formattedDate,
  //       'jamAwal': jamAwal,
  //       'jamAkhir': jamAkhir,
  //     });
  //   }

  //   return processedData;
  // }

  // List<Map<String, String>> processVesselData(List<Map<String, dynamic>> data) {
  //   Map<String, DateTime> minTimestamps = {};
  //   Map<String, DateTime> maxTimestamps = {};

  //   // Process the data to get min and max timestamps for each date
  //   for (var row in data) {
  //     DateTime received = row['received'];
  //     String dateKey = DateFormat('yyyy-MM-dd').format(received);

  //     // Update min and max timestamps for each date
  //     if (!minTimestamps.containsKey(dateKey) ||
  //         received.isBefore(minTimestamps[dateKey]!)) {
  //       minTimestamps[dateKey] = received;
  //     }

  //     if (!maxTimestamps.containsKey(dateKey) ||
  //         received.isAfter(maxTimestamps[dateKey]!)) {
  //       maxTimestamps[dateKey] = received;
  //     }
  //   }

  //   // Prepare processed data for display
  //   List<Map<String, String>> processedData = [];
  //   for (var date in minTimestamps.keys) {
  //     String formattedDate =
  //         DateFormat('dd MMM yyyy').format(minTimestamps[date]!);
  //     String jamAwal = DateFormat('hh:mm a').format(minTimestamps[date]!);
  //     String jamAkhir = DateFormat('hh:mm a').format(maxTimestamps[date]!);

  //     // Calculate duration
  //     Duration duration = maxTimestamps[date]!.difference(minTimestamps[date]!);
  //     String formattedDuration =
  //         '${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit';

  //     processedData.add({
  //       'formattedDate': formattedDate,
  //       'jamAwal': jamAwal,
  //       'jamAkhir': jamAkhir,
  //       'duration': formattedDuration,
  //     });
  //   }

  //   return processedData;
  // }

  // List<Map<String, String>> processVesselData(List<Map<String, dynamic>> data) {
  //   Map<String, DateTime> minTimestamps = {};
  //   Map<String, DateTime> maxTimestamps = {};
  //   Map<String, double> totalDistances = {}; // For speed if needed
  //   Map<String, double> totalSpeeds = {}; // Total speed per date
  //   Map<String, int> entryCounts = {}; // Count of entries per date

  //   // Process the data to get min and max timestamps and total speeds for each date
  //   for (var row in data) {
  //     DateTime received = row['received'];
  //     String dateKey = DateFormat('yyyy-MM-dd').format(received);

  //     // Update min and max timestamps for each date
  //     if (!minTimestamps.containsKey(dateKey) ||
  //         received.isBefore(minTimestamps[dateKey]!)) {
  //       minTimestamps[dateKey] = received;
  //     }

  //     if (!maxTimestamps.containsKey(dateKey) ||
  //         received.isAfter(maxTimestamps[dateKey]!)) {
  //       maxTimestamps[dateKey] = received;
  //     }

  //     // Sum speeds and count entries for average speed calculation
  //     double speed = row['speed_kn']?.toDouble() ??
  //         0.0; // Assuming speed_kn is the key for speed
  //     totalSpeeds[dateKey] = (totalSpeeds[dateKey] ?? 0.0) + speed;
  //     entryCounts[dateKey] = (entryCounts[dateKey] ?? 0) + 1;
  //   }

  //   // Prepare processed data for display
  //   List<Map<String, String>> processedData = [];
  //   for (var date in minTimestamps.keys) {
  //     String formattedDate =
  //         DateFormat('dd MMM yyyy').format(minTimestamps[date]!);
  //     String jamAwal = DateFormat('hh:mm a').format(minTimestamps[date]!);
  //     String jamAkhir = DateFormat('hh:mm a').format(maxTimestamps[date]!);

  //     // Calculate duration
  //     Duration duration = maxTimestamps[date]!.difference(minTimestamps[date]!);
  //     String formattedDuration =
  //         '${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit';

  //     // Calculate average speed
  //     double totalSpeed = totalSpeeds[date] ?? 0.0;
  //     int count = entryCounts[date] ?? 1; // Avoid division by zero
  //     double averageSpeed = totalSpeed / count;
  //     String formattedAverageSpeed =
  //         '${averageSpeed.toStringAsFixed(2)} knots'; // Adjust units as necessary

  //     processedData.add({
  //       'formattedDate': formattedDate,
  //       'jamAwal': jamAwal,
  //       'jamAkhir': jamAkhir,
  //       'duration': formattedDuration,
  //       'averageSpeed': formattedAverageSpeed,
  //     });
  //   }

  //   return processedData;
  // }

  // List<Map<String, String>> processVesselData(List<Map<String, dynamic>> data) {
  //   Map<String, DateTime> minTimestamps = {};
  //   Map<String, DateTime> maxTimestamps = {};
  //   Map<String, double> totalSpeeds = {}; // Total speed per date
  //   Map<String, int> entryCounts = {}; // Count of entries per date
  //   Map<String, double> minSpeeds = {}; // Minimum speed per date
  //   Map<String, double> maxSpeeds = {}; // Maximum speed per date

  //   // Process the data to get min and max timestamps and total speeds for each date
  //   for (var row in data) {
  //     DateTime received = row['received'];
  //     String dateKey = DateFormat('yyyy-MM-dd').format(received);

  //     // Update min and max timestamps for each date
  //     if (!minTimestamps.containsKey(dateKey) ||
  //         received.isBefore(minTimestamps[dateKey]!)) {
  //       minTimestamps[dateKey] = received;
  //     }

  //     if (!maxTimestamps.containsKey(dateKey) ||
  //         received.isAfter(maxTimestamps[dateKey]!)) {
  //       maxTimestamps[dateKey] = received;
  //     }

  //     // Sum speeds and count entries for average speed calculation
  //     double speed = row['speed_kn']?.toDouble() ??
  //         0.0; // Assuming speed_kn is the key for speed
  //     totalSpeeds[dateKey] = (totalSpeeds[dateKey] ?? 0.0) + speed;
  //     entryCounts[dateKey] = (entryCounts[dateKey] ?? 0) + 1;

  //     // Update min and max speeds
  //     if (!minSpeeds.containsKey(dateKey) || speed < minSpeeds[dateKey]!) {
  //       minSpeeds[dateKey] = speed;
  //     }

  //     if (!maxSpeeds.containsKey(dateKey) || speed > maxSpeeds[dateKey]!) {
  //       maxSpeeds[dateKey] = speed;
  //     }
  //   }

  //   // Prepare processed data for display
  //   List<Map<String, String>> processedData = [];
  //   for (var date in minTimestamps.keys) {
  //     String formattedDate =
  //         DateFormat('dd MMM yyyy').format(minTimestamps[date]!);
  //     String jamAwal = DateFormat('hh:mm a').format(minTimestamps[date]!);
  //     String jamAkhir = DateFormat('hh:mm a').format(maxTimestamps[date]!);

  //     // Calculate duration
  //     Duration duration = maxTimestamps[date]!.difference(minTimestamps[date]!);
  //     String formattedDuration =
  //         '${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit';

  //     // Calculate average speed
  //     double totalSpeed = totalSpeeds[date] ?? 0.0;
  //     int count = entryCounts[date] ?? 1; // Avoid division by zero
  //     double averageSpeed = totalSpeed / count;
  //     String formattedAverageSpeed =
  //         'avg speed  ${averageSpeed.toStringAsFixed(2)} knots'; // Adjust units as necessary

  //     // Get min and max speeds
  //     double minSpeed = minSpeeds[date] ?? 0.0;
  //     double maxSpeed = maxSpeeds[date] ?? 0.0;

  //     processedData.add({
  //       'formattedDate': formattedDate,
  //       'jamAwal': jamAwal,
  //       'jamAkhir': jamAkhir,
  //       'duration': formattedDuration,
  //       'averageSpeed': formattedAverageSpeed,
  //       'minSpeed': '${minSpeed.toStringAsFixed(2)} knots', // Format as needed
  //       'maxSpeed': '${maxSpeed.toStringAsFixed(2)} knots', // Format as needed
  //     });
  //   }

  //   return processedData;
  // }

  // List<Map<String, String>> processVesselData(List<Map<String, dynamic>> data) {
  //   Map<String, DateTime> minTimestamps = {};
  //   Map<String, DateTime> maxTimestamps = {};
  //   Map<String, double> totalSpeeds = {}; // Total speed per date
  //   Map<String, int> entryCounts = {}; // Count of entries per date
  //   Map<String, double> minSpeeds = {}; // Minimum speed per date
  //   Map<String, double> maxSpeeds = {}; // Maximum speed per date
  //   Map<String, List<Map<String, dynamic>>> dailyLocations =
  //       {}; // Store lat/lon per day

  //   // Process the data to get min and max timestamps, speeds, and locations for each date
  //   for (var row in data) {
  //     DateTime received = row['received'];
  //     String dateKey = DateFormat('yyyy-MM-dd').format(received);

  //     // Update min and max timestamps for each date
  //     if (!minTimestamps.containsKey(dateKey) ||
  //         received.isBefore(minTimestamps[dateKey]!)) {
  //       minTimestamps[dateKey] = received;
  //     }

  //     if (!maxTimestamps.containsKey(dateKey) ||
  //         received.isAfter(maxTimestamps[dateKey]!)) {
  //       maxTimestamps[dateKey] = received;
  //     }

  //     // Store locations for calculating distance
  //     if (!dailyLocations.containsKey(dateKey)) {
  //       dailyLocations[dateKey] = [];
  //     }
  //     dailyLocations[dateKey]!.add({
  //       'latitude': (row['latitude'] is String)
  //           ? double.tryParse(row['latitude'])
  //           : row['latitude'],
  //       'longitude': (row['longitude'] is String)
  //           ? double.tryParse(row['longitude'])
  //           : row['longitude'],
  //       'received': received,
  //       'speed_kn': (row['speed_kn'] is String)
  //           ? double.tryParse(row['speed_kn'])
  //           : row['speed_kn'],
  //     });

  //     // Sum speeds and count entries for average speed calculation
  //     double speed = (row['speed_kn'] is String)
  //         ? double.tryParse(row['speed_kn']) ?? 0.0
  //         : (row['speed_kn']?.toDouble() ?? 0.0);
  //     totalSpeeds[dateKey] = (totalSpeeds[dateKey] ?? 0.0) + speed;
  //     entryCounts[dateKey] = (entryCounts[dateKey] ?? 0) + 1;

  //     // Update min and max speeds
  //     if (!minSpeeds.containsKey(dateKey) || speed < minSpeeds[dateKey]!) {
  //       minSpeeds[dateKey] = speed;
  //     }

  //     if (!maxSpeeds.containsKey(dateKey) || speed > maxSpeeds[dateKey]!) {
  //       maxSpeeds[dateKey] = speed;
  //     }
  //   }

  //   // Prepare processed data for display
  //   List<Map<String, String>> processedData = [];
  //   for (var date in minTimestamps.keys) {
  //     String formattedDate =
  //         DateFormat('dd MMM yyyy').format(minTimestamps[date]!);
  //     String jamAwal = DateFormat('hh:mm a').format(minTimestamps[date]!);
  //     String jamAkhir = DateFormat('hh:mm a').format(maxTimestamps[date]!);

  //     // Calculate duration
  //     Duration duration = maxTimestamps[date]!.difference(minTimestamps[date]!);
  //     String formattedDuration =
  //         '${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit';

  //     // Calculate average speed
  //     double totalSpeed = totalSpeeds[date] ?? 0.0;
  //     int count = entryCounts[date] ?? 1; // Avoid division by zero
  //     double averageSpeed = totalSpeed / count;
  //     String formattedAverageSpeed =
  //         'avg speed ${averageSpeed.toStringAsFixed(2)} knots';

  //     // Get min and max speeds
  //     double minSpeed = minSpeeds[date] ?? 0.0;
  //     double maxSpeed = maxSpeeds[date] ?? 0.0;

  //     // Calculate distance from the first point of today to the first point of the next day if average speed > 0.1
  //     double totalDistance = 0.0;
  //     if (averageSpeed > 0.1 && dailyLocations.containsKey(date)) {
  //       var firstPointToday = dailyLocations[date]!.firstWhere(
  //           (location) => location['received'] == minTimestamps[date]);
  //       var nextDateKey = DateFormat('yyyy-MM-dd')
  //           .format(minTimestamps[date]!.add(Duration(days: 1)));
  //       if (dailyLocations.containsKey(nextDateKey)) {
  //         var firstPointNextDay = dailyLocations[nextDateKey]!.firstWhere(
  //             (location) => location['received'] == minTimestamps[nextDateKey]);

  //         // Calculate the distance
  //         totalDistance = calculateDistanceNmi(
  //           firstPointToday['latitude'],
  //           firstPointToday['longitude'],
  //           firstPointNextDay['latitude'],
  //           firstPointNextDay['longitude'],
  //         );
  //       }
  //     }

  //     processedData.add({
  //       'formattedDate': formattedDate,
  //       'jamAwal': jamAwal,
  //       'jamAkhir': jamAkhir,
  //       'duration': formattedDuration,
  //       'averageSpeed': formattedAverageSpeed,
  //       'minSpeed': '${minSpeed.toStringAsFixed(2)} knots', // Format as needed
  //       'maxSpeed': '${maxSpeed.toStringAsFixed(2)} knots', // Format as needed
  //       'totalDistance': (averageSpeed > 0.1)
  //           ? '${totalDistance.toStringAsFixed(2)} nmi'
  //           : 'N/A',
  //     });
  //   }

  //   return processedData;
  // }

  // List<Map<String, String>> processVesselData(List<Map<String, dynamic>> data) {
  //   // Maps to hold timestamps, speeds, and locations for processing
  //   Map<String, DateTime> minTimestamps = {};
  //   Map<String, DateTime> maxTimestamps = {};
  //   Map<String, double> totalSpeeds = {};
  //   Map<String, int> entryCounts = {};
  //   Map<String, double> minSpeeds = {};
  //   Map<String, double> maxSpeeds = {};
  //   Map<String, List<Map<String, dynamic>>> dailyLocations = {};

  //   // Process the data to get min and max timestamps, speeds, and locations for each date
  //   for (var row in data) {
  //     DateTime received = row['received'];
  //     String dateKey = DateFormat('yyyy-MM-dd').format(received);

  //     // Update min and max timestamps for each date
  //     if (!minTimestamps.containsKey(dateKey) ||
  //         received.isBefore(minTimestamps[dateKey]!)) {
  //       minTimestamps[dateKey] = received;
  //     }
  //     if (!maxTimestamps.containsKey(dateKey) ||
  //         received.isAfter(maxTimestamps[dateKey]!)) {
  //       maxTimestamps[dateKey] = received;
  //     }

  //     // Store locations for calculating distance
  //     if (!dailyLocations.containsKey(dateKey)) {
  //       dailyLocations[dateKey] = [];
  //     }
  //     dailyLocations[dateKey]!.add({
  //       'latitude': (row['latitude'] is String)
  //           ? double.tryParse(row['latitude'])
  //           : row['latitude'],
  //       'longitude': (row['longitude'] is String)
  //           ? double.tryParse(row['longitude'])
  //           : row['longitude'],
  //       'received': received,
  //       'speed_kn': (row['speed_kn'] is String)
  //           ? double.tryParse(row['speed_kn'])
  //           : row['speed_kn'],
  //     });

  //     // Sum speeds and count entries for average speed calculation
  //     double speed = (row['speed_kn'] is String)
  //         ? double.tryParse(row['speed_kn']) ?? 0.0
  //         : (row['speed_kn']?.toDouble() ?? 0.0);
  //     totalSpeeds[dateKey] = (totalSpeeds[dateKey] ?? 0.0) + speed;
  //     entryCounts[dateKey] = (entryCounts[dateKey] ?? 0) + 1;

  //     // Update min and max speeds
  //     if (!minSpeeds.containsKey(dateKey) || speed < minSpeeds[dateKey]!) {
  //       minSpeeds[dateKey] = speed;
  //     }
  //     if (!maxSpeeds.containsKey(dateKey) || speed > maxSpeeds[dateKey]!) {
  //       maxSpeeds[dateKey] = speed;
  //     }
  //   }

  //   // Prepare processed data for display
  //   List<Map<String, String>> processedData = [];
  //   for (var date in minTimestamps.keys) {
  //     String formattedDate =
  //         DateFormat('dd MMM yyyy').format(minTimestamps[date]!);
  //     String jamAwal = DateFormat('hh:mm a').format(minTimestamps[date]!);
  //     String jamAkhir = DateFormat('hh:mm a').format(maxTimestamps[date]!);

  //     // Calculate duration
  //     Duration duration = maxTimestamps[date]!.difference(minTimestamps[date]!);
  //     String formattedDuration =
  //         '${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit';

  //     // Calculate average speed
  //     double totalSpeed = totalSpeeds[date] ?? 0.0;
  //     int count = entryCounts[date] ?? 1; // Avoid division by zero
  //     double averageSpeed = totalSpeed / count;
  //     String formattedAverageSpeed =
  //         'avg speed ${averageSpeed.toStringAsFixed(2)} knots';

  //     // Get min and max speeds
  //     double minSpeed = minSpeeds[date] ?? 0.0;
  //     double maxSpeed = maxSpeeds[date] ?? 0.0;

  //     // Calculate total distance for the day
  //     double totalDistance = 0.0;

  //     if (dailyLocations.containsKey(date)) {
  //       var locations = dailyLocations[date]!;

  //       // Hitung jarak dari titik awal ke semua titik pada hari ini
  //       for (int i = 0; i < locations.length - 1; i++) {
  //         var current = locations[i];
  //         var next = locations[i + 1];

  //         double startLat = current['latitude'];
  //         double startLon = current['longitude'];
  //         double endLat = next['latitude'];
  //         double endLon = next['longitude'];

  //         double distanceNmi =
  //             calculateDistanceNmi(startLat, startLon, endLat, endLon);
  //         totalDistance += distanceNmi;
  //       }

  //       // Hitung jarak dari titik terakhir hari ini ke titik awal hari berikutnya
  //       String nextDateKey = DateFormat('yyyy-MM-dd')
  //           .format(minTimestamps[date]!.add(Duration(days: 1)));
  //       if (dailyLocations.containsKey(nextDateKey)) {
  //         var firstPointNextDay = dailyLocations[nextDateKey]!.firstWhere(
  //             (location) => location['received'] == minTimestamps[nextDateKey]);

  //         var lastPointToday = locations.last;
  //         double endLat = lastPointToday['latitude'];
  //         double endLon = lastPointToday['longitude'];

  //         // Hitung jarak ke titik awal hari berikutnya
  //         double distanceToNextDay = calculateDistanceNmi(
  //           endLat,
  //           endLon,
  //           firstPointNextDay['latitude'],
  //           firstPointNextDay['longitude'],
  //         );
  //         totalDistance += distanceToNextDay;
  //       }
  //     }

  //     processedData.add({
  //       'formattedDate': formattedDate,
  //       'jamAwal': jamAwal,
  //       'jamAkhir': jamAkhir,
  //       'duration': formattedDuration,
  //       'averageSpeed': formattedAverageSpeed,
  //       'minSpeed': '${minSpeed.toStringAsFixed(2)} knots',
  //       'maxSpeed': '${maxSpeed.toStringAsFixed(2)} knots',
  //       'totalDistance': (averageSpeed > 0.1)
  //           ? '${totalDistance.toStringAsFixed(2)} nmi'
  //           : 'N/A',
  //     });

  //     print('Total distance for $date: $totalDistance nmi');
  //   }
  //   return processedData;
  // }

  // List<Map<String, String>> processVesselData(List<Map<String, dynamic>> data) {
  //   // Maps to hold timestamps, speeds, and locations for processing
  //   Map<String, DateTime> minTimestamps = {};
  //   Map<String, DateTime> maxTimestamps = {};
  //   Map<String, double> totalSpeeds = {};
  //   Map<String, int> entryCounts = {};
  //   Map<String, double> minSpeeds = {};
  //   Map<String, double> maxSpeeds = {};
  //   Map<String, List<Map<String, dynamic>>> dailyLocations = {};

  //   // Process the data to get min and max timestamps, speeds, and locations for each date
  //   for (var row in data) {
  //     DateTime received = row['received'];
  //     String dateKey = DateFormat('yyyy-MM-dd').format(received);

  //     // Update min and max timestamps for each date
  //     if (!minTimestamps.containsKey(dateKey) ||
  //         received.isBefore(minTimestamps[dateKey]!)) {
  //       minTimestamps[dateKey] = received;
  //     }
  //     if (!maxTimestamps.containsKey(dateKey) ||
  //         received.isAfter(maxTimestamps[dateKey]!)) {
  //       maxTimestamps[dateKey] = received;
  //     }

  //     // Store locations for calculating distance
  //     if (!dailyLocations.containsKey(dateKey)) {
  //       dailyLocations[dateKey] = [];
  //     }
  //     dailyLocations[dateKey]!.add({
  //       'latitude': (row['latitude'] is String)
  //           ? double.tryParse(row['latitude'])
  //           : row['latitude'],
  //       'longitude': (row['longitude'] is String)
  //           ? double.tryParse(row['longitude'])
  //           : row['longitude'],
  //       'received': received,
  //       'speed_kn': (row['speed_kn'] is String)
  //           ? double.tryParse(row['speed_kn'])
  //           : row['speed_kn'],
  //     });

  //     // Sum speeds and count entries for average speed calculation
  //     double speed = (row['speed_kn'] is String)
  //         ? double.tryParse(row['speed_kn']) ?? 0.0
  //         : (row['speed_kn']?.toDouble() ?? 0.0);
  //     totalSpeeds[dateKey] = (totalSpeeds[dateKey] ?? 0.0) + speed;
  //     entryCounts[dateKey] = (entryCounts[dateKey] ?? 0) + 1;

  //     // Update min and max speeds
  //     if (!minSpeeds.containsKey(dateKey) || speed < minSpeeds[dateKey]!) {
  //       minSpeeds[dateKey] = speed;
  //     }
  //     if (!maxSpeeds.containsKey(dateKey) || speed > maxSpeeds[dateKey]!) {
  //       maxSpeeds[dateKey] = speed;
  //     }
  //   }

  //   // Prepare processed data for display
  //   List<Map<String, String>> processedData = [];
  //   for (var date in minTimestamps.keys) {
  //     String formattedDate =
  //         DateFormat('dd MMM yyyy').format(minTimestamps[date]!);
  //     String jamAwal = DateFormat('hh:mm a').format(minTimestamps[date]!);
  //     String jamAkhir = DateFormat('hh:mm a').format(maxTimestamps[date]!);

  //     // Calculate duration
  //     Duration duration = maxTimestamps[date]!.difference(minTimestamps[date]!);
  //     String formattedDuration =
  //         '${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit';

  //     // Calculate average speed
  //     double totalSpeed = totalSpeeds[date] ?? 0.0;
  //     int count = entryCounts[date] ?? 1; // Avoid division by zero
  //     double averageSpeed = totalSpeed / count;
  //     String formattedAverageSpeed =
  //         'avg speed ${averageSpeed.toStringAsFixed(2)} knots';

  //     // Get min and max speeds
  //     double minSpeed = minSpeeds[date] ?? 0.0;
  //     double maxSpeed = maxSpeeds[date] ?? 0.0;

  //     // Calculate total distance for the day
  //     double totalDistance = 0.0;

  //     if (dailyLocations.containsKey(date)) {
  //       var locations = dailyLocations[date]!;

  //       // Hitung jarak dari titik awal ke semua titik pada hari ini
  //       for (int i = 0; i < locations.length - 1; i++) {
  //         var current = locations[i];
  //         var next = locations[i + 1];

  //         double startLat = current['latitude'];
  //         double startLon = current['longitude'];
  //         double endLat = next['latitude'];
  //         double endLon = next['longitude'];

  //         double speedCurrent = current['speed_kn'] ?? 0.0;
  //         double speedNext = next['speed_kn'] ?? 0.0;

  //         // Calculate distance only if both speeds are greater than 0.1 knots
  //         if (speedCurrent > 0.1 && speedNext > 0.1) {
  //           double distanceNmi =
  //               calculateDistanceNmi(startLat, startLon, endLat, endLon);
  //           totalDistance += distanceNmi;
  //         }
  //       }

  //       // Hitung jarak dari titik terakhir hari ini ke titik awal hari berikutnya
  //       String nextDateKey = DateFormat('yyyy-MM-dd')
  //           .format(minTimestamps[date]!.add(Duration(days: 1)));
  //       if (dailyLocations.containsKey(nextDateKey)) {
  //         var firstPointNextDay = dailyLocations[nextDateKey]!.firstWhere(
  //             (location) => location['received'] == minTimestamps[nextDateKey]);

  //         var lastPointToday = locations.last;
  //         double endLat = lastPointToday['latitude'];
  //         double endLon = lastPointToday['longitude'];

  //         // Hitung jarak ke titik awal hari berikutnya jika speed terakhir lebih dari 0.1 knots
  //         if (lastPointToday['speed_kn'] > 0.1) {
  //           // Hitung jarak ke titik awal hari berikutnya
  //           double distanceToNextDay = calculateDistanceNmi(
  //             endLat,
  //             endLon,
  //             firstPointNextDay['latitude'],
  //             firstPointNextDay['longitude'],
  //           );
  //           totalDistance += distanceToNextDay;
  //         }
  //       }
  //     }

  //     processedData.add({
  //       'formattedDate': formattedDate,
  //       'jamAwal': jamAwal,
  //       'jamAkhir': jamAkhir,
  //       'duration': formattedDuration,
  //       'averageSpeed': formattedAverageSpeed,
  //       'minSpeed': '${minSpeed.toStringAsFixed(2)} knots',
  //       'maxSpeed': '${maxSpeed.toStringAsFixed(2)} knots',
  //       'totalDistance': (totalDistance > 0.0)
  //           ? '${totalDistance.toStringAsFixed(2)} nmi'
  //           : 'N/A',
  //     });
  //   }
  //   return processedData;
  // }

  List<Map<String, String>> processVesselData(List<Map<String, dynamic>> data) {
    // Maps to hold timestamps, speeds, and locations for processing
    Map<String, DateTime> minTimestamps = {};
    Map<String, DateTime> maxTimestamps = {};
    Map<String, double> totalSpeeds = {};
    Map<String, int> entryCounts = {};
    Map<String, double> minSpeeds = {};
    Map<String, double> maxSpeeds = {};
    Map<String, List<Map<String, dynamic>>> dailyLocations = {};

    // Process the data to get min and max timestamps, speeds, and locations for each date
    for (var row in data) {
      DateTime received = row['received'];
      String dateKey = DateFormat('yyyy-MM-dd').format(received);

      // Update min and max timestamps for each date
      if (!minTimestamps.containsKey(dateKey) ||
          received.isBefore(minTimestamps[dateKey]!)) {
        minTimestamps[dateKey] = received;
      }
      if (!maxTimestamps.containsKey(dateKey) ||
          received.isAfter(maxTimestamps[dateKey]!)) {
        maxTimestamps[dateKey] = received;
      }

      // Store locations for calculating distance
      if (!dailyLocations.containsKey(dateKey)) {
        dailyLocations[dateKey] = [];
      }
      dailyLocations[dateKey]!.add({
        'latitude': (row['latitude'] is String)
            ? double.tryParse(row['latitude'])
            : row['latitude'],
        'longitude': (row['longitude'] is String)
            ? double.tryParse(row['longitude'])
            : row['longitude'],
        'received': received,
        'speed_kn': (row['speed_kn'] is String)
            ? double.tryParse(row['speed_kn'])
            : row['speed_kn'],
      });

      // Sum speeds and count entries for average speed calculation
      double speed = (row['speed_kn'] is String)
          ? double.tryParse(row['speed_kn']) ?? 0.0
          : (row['speed_kn']?.toDouble() ?? 0.0);
      totalSpeeds[dateKey] = (totalSpeeds[dateKey] ?? 0.0) + speed;
      entryCounts[dateKey] = (entryCounts[dateKey] ?? 0) + 1;

      // Update min and max speeds
      if (!minSpeeds.containsKey(dateKey) || speed < minSpeeds[dateKey]!) {
        minSpeeds[dateKey] = speed;
      }
      if (!maxSpeeds.containsKey(dateKey) || speed > maxSpeeds[dateKey]!) {
        maxSpeeds[dateKey] = speed;
      }
    }

    // Prepare processed data for display
    List<Map<String, String>> processedData = [];
    for (var date in minTimestamps.keys) {
      String formattedDate =
          DateFormat('dd MMM yyyy').format(minTimestamps[date]!);
      String jamAwal = DateFormat('hh:mm a').format(minTimestamps[date]!);
      String jamAkhir = DateFormat('hh:mm a').format(maxTimestamps[date]!);

      // Calculate duration
      Duration duration = maxTimestamps[date]!.difference(minTimestamps[date]!);
      String formattedDuration =
          '${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit';

      // Calculate average speed
      double totalSpeed = totalSpeeds[date] ?? 0.0;
      int count = entryCounts[date] ?? 1; // Avoid division by zero
      double averageSpeed = totalSpeed / count;
      String formattedAverageSpeed =
          'avg speed ${averageSpeed.toStringAsFixed(2)} knots';

      // Get min and max speeds
      double minSpeed = minSpeeds[date] ?? 0.0;
      double maxSpeed = maxSpeeds[date] ?? 0.0;

      // Calculate total distance for the day
      double totalDistance = calculateTotalDistance(dailyLocations[date]!);

      processedData.add({
        'formattedDate': formattedDate,
        'jamAwal': jamAwal,
        'jamAkhir': jamAkhir,
        'duration': formattedDuration,
        'averageSpeed': formattedAverageSpeed,
        'minSpeed': '${minSpeed.toStringAsFixed(2)} knots',
        'maxSpeed': '${maxSpeed.toStringAsFixed(2)} knots',
        'totalDistance': (totalDistance > 0.0)
            ? '${totalDistance.toStringAsFixed(2)} nmi'
            : 'N/A',
      });
    }
    return processedData;
  }

  double calculateTotalDistancePerDay(List<Map<String, String>> processedData) {
    double totalDistance = 0.0;

    // Iterate through each processed data entry and sum the distances
    for (var entry in processedData) {
      String distanceString = entry['totalDistance'] ?? '0.0 nmi';
      double distance = double.tryParse(distanceString.split(' ')[0]) ??
          0.0; // Extract the numeric part
      totalDistance += distance;
    }

    return totalDistance;
  }

  // String calculateTotalDurationPerDay(List<Map<String, String>> processedData) {
  //   int totalMinutes = 0;

  //   // Iterate through each processed data entry and sum the durations
  //   for (var entry in processedData) {
  //     // Parse the duration string into total minutes
  //     String durationString = entry['duration'] ?? '0 jam 0 menit';
  //     RegExp regex = RegExp(r'(\d+)\s+jam\s+(\d+)\s+menit');
  //     var match = regex.firstMatch(durationString);

  //     if (match != null) {
  //       int hours = int.parse(match.group(1)!);
  //       int minutes = int.parse(match.group(2)!);
  //       totalMinutes +=
  //           (hours * 60) + minutes; // Convert hours to minutes and add
  //     }
  //   }

  //   // Convert total minutes back to hours and minutes
  //   int totalHours = totalMinutes ~/ 60;
  //   int remainingMinutes = totalMinutes % 60;

  //   return '$totalHours jam ${remainingMinutes} menit';
  // }

  String calculateTotalDurationPerDay(List<Map<String, String>> processedData) {
    int totalMinutes = 0;

    // Iterate through each processed data entry and sum the durations
    for (var entry in processedData) {
      // Parse the duration string into total minutes
      String durationString = entry['duration'] ?? '0 jam 0 menit';
      RegExp regex = RegExp(r'(\d+)\s+jam\s+(\d+)\s+menit');
      var match = regex.firstMatch(durationString);

      if (match != null) {
        int hours = int.parse(match.group(1)!);
        int minutes = int.parse(match.group(2)!);
        totalMinutes +=
            (hours * 60) + minutes; // Convert hours to minutes and add
      }
    }

    // Convert total minutes back to days, hours, and minutes
    int totalDays = totalMinutes ~/ (24 * 60); // 1 day = 1440 minutes
    int remainingHours = (totalMinutes % (24 * 60)) ~/ 60; // Remaining hours
    int remainingMinutes = totalMinutes % 60; // Remaining minutes

    return '$totalDays hari $remainingHours jam $remainingMinutes menit';
  }

  double calculateAverageSpeedPerDay(List<Map<String, String>> processedData) {
    double totalSpeed = 0.0;
    int totalEntries = 0;

    // Iterate through each processed data entry and sum the average speeds
    for (var entry in processedData) {
      // Extract the average speed from the entry
      String averageSpeedString = entry['averageSpeed'] ?? '0.0 knots';
      double averageSpeed = double.tryParse(averageSpeedString.split(' ')[2]) ??
          0.0; // Extract the numeric part
      totalSpeed += averageSpeed;

      // Count the number of entries to calculate the overall average
      totalEntries += 1;
    }

    // Calculate overall average speed
    double overallAverageSpeed =
        (totalEntries > 0) ? (totalSpeed / totalEntries) : 0.0;

    return overallAverageSpeed;
  }

  // tanggal
  // Map<String, Map<String, DateTime>> _getEarliestAndLatestTimesByDate(
  //     List<Map<String, dynamic>> data) {
  //   Map<String, Map<String, DateTime>> timeByDate = {};

  //   for (var item in data) {
  //     DateTime receivedTime = item['received'];
  //     String dateKey = DateFormat('yyyy-MM-dd').format(receivedTime);

  //     if (timeByDate.containsKey(dateKey)) {
  //       // Periksa apakah waktu saat ini adalah waktu awal atau akhir
  //       if (receivedTime.isBefore(timeByDate[dateKey]!['start']!)) {
  //         timeByDate[dateKey]!['start'] = receivedTime;
  //       }
  //       if (receivedTime.isAfter(timeByDate[dateKey]!['end']!)) {
  //         timeByDate[dateKey]!['end'] = receivedTime;
  //       }
  //     } else {
  //       // Tambahkan tanggal baru dengan waktu awal dan akhir sebagai waktu yang sama
  //       timeByDate[dateKey] = {'start': receivedTime, 'end': receivedTime};
  //     }
  //   }

  //   return timeByDate;
  // }

  // double calculateDistanceNmi(
  //     double startLat, double startLon, double endLat, double endLon) {
  //   const R = 3440.07; // jari jari bumi dlm mil laut
  //   double lat1 = startLat * pi / 180;
  //   double lon1 = startLon * pi / 180;
  //   double lat2 = endLat * pi / 180;
  //   double lon2 = endLon * pi / 180;

  //   double dlat = lat2 - lat1;
  //   double dlon = lon2 - lon1;

  //   double a = sin(dlat / 2) * sin(dlat / 2) +
  //       cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);
  //   double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  //   return R * c;
  // }

  // double _calculateTotalDistance() {
  //   double totalDistance = 0;
  //   if (data != null) {
  //     for (var item in data!) {
  //       double rerataSpeed =
  //           double.parse(item['average_speed_knots'].toString());
  //       if (rerataSpeed >= 0.4) {
  //         double distanceNmi = calculateDistanceNmi(
  //           double.parse(item['start_latitude']),
  //           double.parse(item['start_longitude']),
  //           double.parse(item['end_latitude']),
  //           double.parse(item['end_longitude']),
  //         );
  //         totalDistance += distanceNmi;
  //       }
  //     }
  //   }
  //   return totalDistance;
  // }

  // double _calculateTotalDistance() {
  //   double totalDistance = 0;

  //   if (data != null) {
  //     for (var index = 0; index < data!.length; index++) {
  //       var item = data![index];
  //       double rerataSpeed =
  //           double.parse(item['average_speed_knots'].toString());

  //       // Hitung jarak dari titik awal ke titik akhir untuk item saat ini
  //       if (rerataSpeed >= 0.1) {
  //         double distanceNmi = calculateDistanceNmi(
  //           double.parse(item['start_latitude']),
  //           double.parse(item['start_longitude']),
  //           double.parse(item['end_latitude']),
  //           double.parse(item['end_longitude']),
  //         );
  //         totalDistance += distanceNmi;

  //         // Jika ada item berikutnya, hitung jarak dari titik akhir item saat ini ke titik awal item berikutnya
  //         if (index < data!.length - 1) {
  //           var nextItem = data![index + 1];
  //           double distanceToNextStart = calculateDistanceNmi(
  //             double.parse(item['end_latitude']),
  //             double.parse(item['end_longitude']),
  //             double.parse(nextItem['start_latitude']),
  //             double.parse(nextItem['start_longitude']),
  //           );
  //           totalDistance += distanceToNextStart;
  //         }
  //       }
  //     }
  //   }

  //   return totalDistance;
  // }

  // double _calculateAverageSpeed() {
  //   double totalSpeed = 0;

  //   if (data != null && data!.isNotEmpty) {
  //     for (var item in data!) {

  //       double rerataSpeed =
  //           double.parse(item['speed_kn'].toString());
  //       totalSpeed += rerataSpeed;
  //     }
  //     return totalSpeed / data!.length;
  //   }

  //   return 0;
  // }

  // Map<String, int> _calculateTotalTime() {
  //   int totalDays = 0;
  //   int totalHours = 0;
  //   int totalMinutes = 0;

  //   if (data != null) {
  //     for (var item in data!) {
  //       DateTime startTime = item['waktu_awal'];
  //       DateTime endTime = item['waktu_akhir'];

  //       Duration sailingDuration = endTime.difference(startTime);
  //       totalDays += sailingDuration.inDays;
  //       totalHours += sailingDuration.inHours % 24;
  //       totalMinutes += sailingDuration.inMinutes % 60;
  //     }
  //   }

  //   totalHours += totalMinutes ~/ 60;
  //   totalMinutes = totalMinutes % 60;

  //   totalDays += totalHours ~/ 24;
  //   totalHours = totalHours % 24;

  //   return {'days': totalDays, 'hours': totalHours, 'minutes': totalMinutes};
  // }

  Future<void> _savePdf() async {
    final pdf = pw.Document();

    final ByteData bytes =
        await rootBundle.load('assets/images/logo-geosat.png');
    final Uint8List imageData = bytes.buffer.asUint8List();

    // double totalDistance = _calculateTotalDistance();
    // Map<String, int> totalTime = _calculateTotalTime();
    // double averageSpeed = _calculateAverageSpeed();

    List<Map<String, String>> processedData = processVesselData(data!);
    String totalDuration = calculateTotalDurationPerDay(processedData);

    double averageDailySpeed = calculateAverageSpeedPerDay(processedData);

    double totalDailyDistance = calculateTotalDistancePerDay(processedData);

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
                    pw.Text('Laporan Jarak Tempuh Kapal',
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
                    pw.Text(
                      '${startDate != null && endDate != null ? "${DateFormat('dd MMM yyyy').format(startDate!)} - ${DateFormat('dd MMM yyyy').format(endDate!)}" : "No date selected"}',
                      style: pw.TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                pw.Divider(),
                pw.Row(
                  children: [
                    pw.Text('Nama Kapal: ', style: pw.TextStyle(fontSize: 14)),
                    pw.Text(vesselName ?? '',
                        style: pw.TextStyle(fontSize: 14)),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Jarak Tempuh: ',
                        style: pw.TextStyle(fontSize: 14)),
                    // pw.Text('${totalDistance.toStringAsFixed(2)} nmi',
                    pw.Text('${totalDailyDistance.toStringAsFixed(2)} nmi',
                        style: pw.TextStyle(fontSize: 14)),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Perjalanan: ', style: pw.TextStyle(fontSize: 14)),
                    pw.Text('${calculateUniqueDays(data!)} hari',
                        style: pw.TextStyle(fontSize: 14)),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Periode Traking: ',
                        style: pw.TextStyle(fontSize: 14)),
                    pw.Text(
                      ': $totalDuration',
                      // '${totalTime['days']} hari ${totalTime['hours']} jam ${totalTime['minutes']} menit',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Average Speed: ',
                        style: pw.TextStyle(fontSize: 14)),
                    pw.Text(
                      // '${averageSpeed.toStringAsFixed(2)} knots',
                      '${averageDailySpeed.toStringAsFixed(2)} knots',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text('Detail Perjalanan', style: pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 5),
              ],
            ),
            pw.TableHelper.fromTextArray(
              headers: [
                'Tanggal',
                'Jarak (nmi)',
                'Durasi',
                'Kecepatan Rata-rata(knots)'
              ],
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellAlignment: pw.Alignment.center,
              cellStyle: pw.TextStyle(fontSize: 10),
              columnWidths: {
                0: pw.FixedColumnWidth(100),
                1: pw.FixedColumnWidth(60),
                2: pw.FixedColumnWidth(60),
                3: pw.FixedColumnWidth(60),
              },
              data: List<List<String>>.generate(
                processedData.length,
                (index) {
                  final item = processedData[index];
                  // double distanceNmi = calculateDistanceNmi(
                  //   double.parse(item['start_latitude']),
                  //   double.parse(item['start_longitude']),
                  //   double.parse(item['end_latitude']),
                  //   double.parse(item['end_longitude']),
                  // );
                  // DateTime startTime = item['waktu_awal'];
                  // DateTime endTime = item['waktu_akhir'];

                  // double distanceNmi = calculateDistanceNmi(
                  //   double.parse(item['start_latitude']),
                  //   double.parse(item['start_longitude']),
                  //   double.parse(item['end_latitude']),
                  //   double.parse(item['end_longitude']),
                  // );

                  // double rerataSpeed = item['average_speed_knots'] ?? -1;
                  // double distanceTextValue =
                  //     (rerataSpeed < 0.1) ? 0.0 : distanceNmi;

                  // // DateTime startTime = item['waktu_awal'];
                  // // DateTime endTime = item['waktu_akhir'];

                  // double distanceToNextStart = 0.0;
                  // if (index < data!.length - 1) {
                  //   final nextItem = data![index + 1];
                  //   distanceToNextStart = calculateDistanceNmi(
                  //     double.parse(item['end_latitude']),
                  //     double.parse(item['end_longitude']),
                  //     double.parse(nextItem['start_latitude']),
                  //     double.parse(nextItem['start_longitude']),
                  //   );
                  // }

                  // // Jumlahkan distanceText dengan distanceToNextStart
                  // double totalDistance =
                  //     distanceTextValue + distanceToNextStart;

                  return [
                    '${item['formattedDate']}',
                    // '${DateFormat('dd MMM yyyy').format(item['tgl_aktifasi'])}',
                    // distanceNmi.toStringAsFixed(2),
                    '${item['totalDistance']}',
                    '${item['duration']}',
                    '${item['averageSpeed']}',
                    // totalDistance.toStringAsFixed(2),
                    // item['duration'],
                    // item['average_speed_knots'].toString(),
                  ];
                },
              ),
            ),
          ];
        },
      ),
    );

    final directory = await getExternalStorageDirectory();
    final file =
        File('${directory!.path}/laporan_jarak_tempuh_${vesselName}.pdf');

    await file.writeAsBytes(await pdf.save());

    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    double totalDistance = calculateTotalDistance(data!);
    double averageSpeed = _calculateAverageSpeed();
    List<Map<String, String>> processedData = processVesselData(data!);
    String totalDuration = calculateTotalDurationPerDay(processedData);

    double averageDailySpeed = calculateAverageSpeedPerDay(processedData);

    double totalDailyDistance = calculateTotalDistancePerDay(processedData);

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
                ElevatedButton.icon(
                  onPressed: _savePdf,
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
                ),
              ],
            ),
          ),
        ],
      ),
      body: data != null && data!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 127, 183, 126),
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
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '${startDate != null && endDate != null ? "${DateFormat('dd MMM yyyy').format(startDate!)} - ${DateFormat('dd MMM yyyy').format(endDate!)}" : "No date selected"}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.location_on,
                                    color: Colors.white60,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           MileageLocationPage(
                                    //             data: data,
                                    //           )),
                                    // );
                                  },
                                  tooltip: 'Go to Location',
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.white60,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.ship,
                                color: Colors.white70,
                                size: 14,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${vesselName}',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Jarak Tempuh',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      ': ${totalDailyDistance.toStringAsFixed(2)} nmi',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Perjalanan',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      ': ${calculateUniqueDays(data!)} hari',
                                      // ': ${data!.length} hari',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Periode Traking',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      ': $totalDuration',
                                      // ': ${totalTime['days']} hari ${totalTime['hours']} jam ${totalTime['minutes']} menit',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Average Speed',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      // ': ${averageSpeed.toStringAsFixed(2)} knots',
                                      ': ${averageDailySpeed.toStringAsFixed(2)} knots',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: processedData.length,
                      itemBuilder: (context, index) {
                        final item = processedData[index];

                        return TabCard(
                          tanggalBerlayar:
                              '${item['formattedDate']} ${item['jamAwal']} - ${item['jamAkhir']}',
                          jarak: '${item['totalDistance']}',
                          lamaBerlayar: '${item['duration']}',
                          rerataSpeed: '${item['averageSpeed']}',
                          highSpeed: '${item['maxSpeed']}',
                          lowSpeed: '${item['minSpeed']}',
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Text('Tidak ada data untuk ditampilkan'),
            ),
    );
  }
}
