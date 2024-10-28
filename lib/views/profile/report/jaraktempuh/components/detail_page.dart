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

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/views/profile/report/jaraktempuh/components/tab_card.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'dart:math';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class DetailPage extends StatelessWidget {
  final List<Map<String, dynamic>>? data;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? vesselName;
  final String? mobileId;

  DetailPage(
      {Key? key,
      this.data,
      this.startDate,
      this.endDate,
      this.vesselName,
      this.mobileId})
      : super(key: key);

  double calculateDistanceNmi(
      double startLat, double startLon, double endLat, double endLon) {
    const R = 3440.07;
    double lat1 = startLat * pi / 180;
    double lon1 = startLon * pi / 180;
    double lat2 = endLat * pi / 180;
    double lon2 = endLon * pi / 180;

    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;

    double a = sin(dlat / 2) * sin(dlat / 2) +
        cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }

  double _calculateTotalDistance() {
    double totalDistance = 0;
    if (data != null) {
      for (var item in data!) {
        double rerataSpeed =
            double.parse(item['average_speed_knots'].toString());
        if (rerataSpeed >= 0.4) {
          double distanceNmi = calculateDistanceNmi(
            double.parse(item['start_latitude']),
            double.parse(item['start_longitude']),
            double.parse(item['end_latitude']),
            double.parse(item['end_longitude']),
          );
          totalDistance += distanceNmi;
        }
      }
    }
    return totalDistance;
  }

  // double _calculateTotalDistance() {
  //   double totalDistance = 0;
  //   if (data != null) {
  //     for (var item in data!) {
  //       double distanceNmi = calculateDistanceNmi(
  //         double.parse(item['start_latitude']),
  //         double.parse(item['start_longitude']),
  //         double.parse(item['end_latitude']),
  //         double.parse(item['end_longitude']),
  //       );
  //       totalDistance += distanceNmi;
  //     }
  //   }
  //   return totalDistance;
  // }

  double _calculateAverageSpeed() {
    double totalSpeed = 0;

    if (data != null && data!.isNotEmpty) {
      for (var item in data!) {
        double rerataSpeed =
            double.parse(item['average_speed_knots'].toString());
        totalSpeed += rerataSpeed;
      }
      return totalSpeed / data!.length;
    }

    return 0;
  }

  Map<String, int> _calculateTotalTime() {
    int totalDays = 0;
    int totalHours = 0;
    int totalMinutes = 0;

    if (data != null) {
      for (var item in data!) {
        DateTime startTime = item['waktu_awal'];
        DateTime endTime = item['waktu_akhir'];

        Duration sailingDuration = endTime.difference(startTime);
        totalDays += sailingDuration.inDays;
        totalHours += sailingDuration.inHours % 24;
        totalMinutes += sailingDuration.inMinutes % 60;
      }
    }

    totalHours += totalMinutes ~/ 60;
    totalMinutes = totalMinutes % 60;

    totalDays += totalHours ~/ 24;
    totalHours = totalHours % 24;

    return {'days': totalDays, 'hours': totalHours, 'minutes': totalMinutes};
  }

  Future<void> _savePdf() async {
    final pdf = pw.Document();

    final ByteData bytes =
        await rootBundle.load('assets/images/logo-geosat.png');
    final Uint8List imageData = bytes.buffer.asUint8List();

    double totalDistance = _calculateTotalDistance();
    Map<String, int> totalTime = _calculateTotalTime();
    double averageSpeed = _calculateAverageSpeed();

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
                    pw.Text('${totalDistance.toStringAsFixed(2)} nmi',
                        style: pw.TextStyle(fontSize: 14)),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Perjalanan: ', style: pw.TextStyle(fontSize: 14)),
                    pw.Text('${data!.length} hari',
                        style: pw.TextStyle(fontSize: 14)),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Waktu Bergerak: ',
                        style: pw.TextStyle(fontSize: 14)),
                    pw.Text(
                      '${totalTime['days']} hari ${totalTime['hours']} jam ${totalTime['minutes']} menit',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Average Speed: ',
                        style: pw.TextStyle(fontSize: 14)),
                    pw.Text(
                      '${averageSpeed.toStringAsFixed(2)} knots',
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
                'Kecepatan (knots)'
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
                data!.length,
                (index) {
                  final item = data![index];
                  double distanceNmi = calculateDistanceNmi(
                    double.parse(item['start_latitude']),
                    double.parse(item['start_longitude']),
                    double.parse(item['end_latitude']),
                    double.parse(item['end_longitude']),
                  );
                  DateTime startTime = item['waktu_awal'];
                  DateTime endTime = item['waktu_akhir'];

                  return [
                    '${DateFormat('dd MMM yyyy').format(item['tgl_aktifasi'])} ${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(endTime)}',
                    distanceNmi.toStringAsFixed(2),
                    item['duration'],
                    item['average_speed_knots'].toString(),
                  ];
                },
              ),
            ),
          ];
        },
      ),
    );

    final directory = await getExternalStorageDirectory();
    final file = File(
        '${directory!.path}/laporan_histori_jarak_tempuh_${vesselName}.pdf');

    await file.writeAsBytes(await pdf.save());

    OpenFile.open(file.path);
  }

  List<FlSpot> _createChartData() {
    List<FlSpot> spots = [];
    for (int index = 0; index < data!.length; index++) {
      final item = data![index];
      double distanceNmi = calculateDistanceNmi(
        double.parse(item['start_latitude']),
        double.parse(item['start_longitude']),
        double.parse(item['end_latitude']),
        double.parse(item['end_longitude']),
      );

      spots.add(FlSpot(index.toDouble(), distanceNmi));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    double totalDistance = _calculateTotalDistance();
    Map<String, int> totalTime = _calculateTotalTime();
    double averageSpeed = _calculateAverageSpeed();
    List<String> labels =
        List.generate(data!.length, (index) => 'H${index + 1}');

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
                                      ': ${totalDistance.toStringAsFixed(2)} nmi',
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
                                      ': ${data!.length} hari',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Waktu Bergerak',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      ': ${totalTime['days']} hari ${totalTime['hours']} jam ${totalTime['minutes']} menit',
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
                                      ': ${averageSpeed.toStringAsFixed(2)} knots',
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
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        final item = data![index];
                        double distanceNmi = calculateDistanceNmi(
                          double.parse(item['start_latitude']),
                          double.parse(item['start_longitude']),
                          double.parse(item['end_latitude']),
                          double.parse(item['end_longitude']),
                        );

                        double rerataSpeed = item['average_speed_knots'] ?? '-';
                        String distanceText = (rerataSpeed < 0.1)
                            ? '- nmi'
                            : '${distanceNmi.toStringAsFixed(2)} nmi';

                        DateTime startTime = item['waktu_awal'];
                        DateTime endTime = item['waktu_akhir'];

                        return TabCard(
                          tanggalBerlayar:
                              '${DateFormat('dd MMM yyyy').format((item['tgl_aktifasi']))} ${DateFormat('hh:mm a').format((startTime))} - ${DateFormat('hh:mm a').format((endTime))}',
                          jarak: distanceText,
                          lamaBerlayar: '${item['duration']}',
                          rerataSpeed:
                              'avg speed ${item['average_speed_knots']} knots',
                          highSpeed: '${item['high_speed_knots']} knots',
                          lowSpeed: '${item['low_speed_knots']} knots',
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
