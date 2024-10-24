// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/app_back_button.dart';
// import 'package:geotraking/views/profile/log/components/tab_card.dart';
// import 'package:fl_chart/fl_chart.dart';

// class LogbookHasilPenangkapanPage extends StatefulWidget {
//   LogbookHasilPenangkapanPage();

//   @override
//   _LogbookHasilPenangkapanPageState createState() =>
//       _LogbookHasilPenangkapanPageState();
// }

// class _LogbookHasilPenangkapanPageState
//     extends State<LogbookHasilPenangkapanPage> {
//   Map<String, double> dataMap = {
//     "Salmon": 50,
//     "Tuna": 45,
//     "Tongkol": 80,
//     "Bandeng": 120,
//     "Kembung": 200,
//   };

//   var data = [50.0, 45.0, 80.0, 120.0, 96.0, 104.0];

//   final List<String> labels = ['P1', 'P2', 'P3', 'P4', 'P5', 'P6'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Hasil Tangkapan'),
//         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: Colors.black,
//             ),
//         leading: const AppBackButton(),
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(5),
//                 margin: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 127, 183, 126),
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Data Keberangkatan',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Divider(
//                         thickness: 0.5,
//                         color: Colors.white60,
//                       ),
//                       Column(
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   'Id Kapal',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   ': 12345',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   'Nama Kapal',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   ': Kapal A',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   'Tanggal Berangkat',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   ': 10 January 2024',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   'Nahkoda',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   ': Capt. Budi',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   'ABK',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   ': Budi, Andi, Asep, Ucup, Kipli, Denis, Sumanto, Susanto, Mulyono, Brian, Hunori',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   'Area Penangkapan',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   ': WppRi-571',
//                                   style: TextStyle(color: Colors.white60),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 15),
//               TabCard(
//                 penangkapan: 'Penangkapan 1',
//                 namaIkan: 'Salmon',
//                 tanggalTangkap: '20 January 2024',
//                 beratIkan: '50 kg',
//                 zoneWpp: 'WppRI-571',
//               ),
//               TabCard(
//                 penangkapan: 'Penangkapan 2',
//                 namaIkan: 'Tuna',
//                 tanggalTangkap: '28 February 2024',
//                 beratIkan: '45 kg',
//                 zoneWpp: 'WppRI-571',
//               ),
//               TabCard(
//                 penangkapan: 'Penangkapan 3',
//                 namaIkan: 'Tongkol',
//                 tanggalTangkap: '13 June 2024',
//                 beratIkan: '80 kg',
//                 zoneWpp: 'WppRI-713',
//               ),
//               TabCard(
//                 penangkapan: 'Penangkapan 4',
//                 namaIkan: 'Bandeng',
//                 tanggalTangkap: '3 April 2024',
//                 beratIkan: '120 kg',
//                 zoneWpp: 'WppRI-572',
//               ),
//               TabCard(
//                 penangkapan: 'Penangkapan 5',
//                 namaIkan: 'Kembung',
//                 tanggalTangkap: '6 Mei 2024',
//                 beratIkan: '96 kg',
//                 zoneWpp: 'WppRI-711',
//               ),
//               TabCard(
//                 penangkapan: 'Penangkapan 6',
//                 namaIkan: 'Kembung',
//                 tanggalTangkap: '26 Mei 2024',
//                 beratIkan: '104 kg',
//                 zoneWpp: 'WppRI-711',
//               ),
//               Container(
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     children: [
//                       Container(
//                         height: 200,
//                         width: 200,
//                         child: PieChart(
//                           PieChartData(
//                             sections: List.generate(dataMap.length, (index) {
//                               final entry = dataMap.entries.elementAt(index);
//                               return PieChartSectionData(
//                                 color: Colors
//                                     .primaries[index % Colors.primaries.length],
//                                 value: entry.value,
//                                 title: '${entry.value.toInt()}',
//                                 titleStyle: TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               );
//                             }),
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Expanded(
//                         child: Column(
//                           children: List.generate(dataMap.length, (index) {
//                             final entry = dataMap.entries.elementAt(index);
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: 16,
//                                   height: 16,
//                                   color: Colors.primaries[
//                                       index % Colors.primaries.length],
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   '${entry.key}',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ],
//                             );
//                           }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 height: 200,
//                 child: Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: LineChart(
//                     LineChartData(
//                       gridData: FlGridData(show: false),
//                       titlesData: FlTitlesData(
//                         bottomTitles: AxisTitles(
//                           sideTitles: SideTitles(
//                             showTitles: true,
//                             getTitlesWidget: (value, _) {
//                               int index = value.toInt();
//                               if (index >= 0 && index < labels.length) {
//                                 return Text(labels[index],
//                                     style: TextStyle(fontSize: 12));
//                               }
//                               return Container();
//                             },
//                             interval: 1,
//                           ),
//                         ),
//                         leftTitles: AxisTitles(
//                           sideTitles: SideTitles(
//                             showTitles: true,
//                             reservedSize: 40,
//                             getTitlesWidget: (value, meta) {
//                               return Text(
//                                 value.toInt().toString(),
//                                 style: const TextStyle(
//                                     fontSize: 12, color: Colors.black),
//                               );
//                             },
//                           ),
//                         ),
//                         topTitles: AxisTitles(
//                           sideTitles: SideTitles(showTitles: false),
//                         ),
//                         rightTitles: AxisTitles(
//                           sideTitles: SideTitles(showTitles: false),
//                         ),
//                       ),
//                       lineBarsData: [
//                         LineChartBarData(
//                           isCurved: true,
//                           spots: data
//                               .asMap()
//                               .entries
//                               .map((entry) =>
//                                   FlSpot(entry.key.toDouble(), entry.value))
//                               .toList(),
//                           isStrokeCapRound: true,
//                           barWidth: 4,
//                           belowBarData: BarAreaData(
//                             show: true,
//                             color: Colors.blue.withOpacity(0.3),
//                           ),
//                           dotData: FlDotData(
//                             show: true,
//                           ),
//                           color: Colors.blue,
//                         ),
//                       ],
//                       borderData: FlBorderData(
//                         show: true,
//                         border: Border.all(
//                             color: Colors.black.withOpacity(0.1), width: 1),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/constants.dart';
import 'package:geotraking/views/profile/log/components/tab_card_vessel.dart';

class LogbookHasilPenangkapanPage extends StatefulWidget {
  const LogbookHasilPenangkapanPage({
    Key? key,
  }) : super(key: key);

  @override
  _LogbookHasilPenangkapanPageState createState() =>
      _LogbookHasilPenangkapanPageState();
}

class _LogbookHasilPenangkapanPageState
    extends State<LogbookHasilPenangkapanPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text('Hasil Tangkapan'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: Text(
        //       '2024',
        //       style: TextStyle(fontSize: 18, color: Colors.black),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabCardVessel(
                namaKapal: 'Kapal A',
                tanggalTangkap: '20 January 2024',
                beratIkan: '50 kg',
              ),
              // TabCardVessel(
              //   namaKapal: 'Kapal B',
              //   tanggalTangkap: '20 January 2024',
              //   beratIkan: '50 kg',
              // ),
              // TabCardVessel(
              //   namaKapal: 'Kapal C',
              //   tanggalTangkap: '20 January 2024',
              //   beratIkan: '50 kg',
              // ),
              // TabCardVessel(
              //   namaKapal: 'Kapal D',
              //   tanggalTangkap: '20 January 2024',
              //   beratIkan: '50 kg',
              // ),
              // TabCardVessel(
              //   namaKapal: 'Kapal E',
              //   tanggalTangkap: '20 January 2024',
              //   beratIkan: '50 kg',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
