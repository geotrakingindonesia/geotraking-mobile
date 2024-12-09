// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/app_back_button.dart';
// import 'package:geotraking/core/constants/constants.dart';
// import 'package:geotraking/views/profile/log/components/tab_card_vessel.dart';

// class LogbookHistoryHasilPenangkapanPage extends StatelessWidget {
//   const LogbookHistoryHasilPenangkapanPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.cardColor,
//       appBar: AppBar(
//         leading: const AppBackButton(),
//         title: Text('History Hasil Tangkapan'),
//         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: Colors.black,
//             ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TabCardVessel(
//                 namaKapal: 'Kapal A',
//                 tanggalTangkap: '20 January 2024',
//                 beratIkan: '50 kg',
//               ),
//               TabCardVessel(
//                 namaKapal: 'Kapal B',
//                 tanggalTangkap: '20 January 2024',
//                 beratIkan: '50 kg',
//               ),
//               TabCardVessel(
//                 namaKapal: 'Kapal C',
//                 tanggalTangkap: '20 January 2024',
//                 beratIkan: '50 kg',
//               ),
//               TabCardVessel(
//                 namaKapal: 'Kapal D',
//                 tanggalTangkap: '20 January 2024',
//                 beratIkan: '50 kg',
//               ),
//               TabCardVessel(
//                 namaKapal: 'Kapal E',
//                 tanggalTangkap: '20 January 2024',
//                 beratIkan: '50 kg',
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

class LogbookHistoryHasilPenangkapanPage extends StatefulWidget {
  const LogbookHistoryHasilPenangkapanPage({
    Key? key,
  }) : super(key: key);

  @override
  _LogbookHistoryHasilPenangkapanPageState createState() => _LogbookHistoryHasilPenangkapanPageState();
}

class _LogbookHistoryHasilPenangkapanPageState extends State<LogbookHistoryHasilPenangkapanPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedYear = '2024';

  void _openYearSidebar() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text('History Hasil Tangkapan'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        // actions: [
        //   Row(
        //     children: [
        //       IconButton(
        //         icon: Icon(Icons.calendar_today),
        //         onPressed: _openYearSidebar,
        //       ),
        //       GestureDetector(
        //         onTap: _openYearSidebar,
        //         child: Padding(
        //           padding: const EdgeInsets.only(right: 16.0),
        //           child: Text(
        //             selectedYear,
        //             style: TextStyle(fontSize: 18, color: Colors.black),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      // endDrawer: Drawer(
      //   width: MediaQuery.of(context).size.width * 0.30,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       DrawerHeader(
      //         padding: const EdgeInsets.all(15),
      //         decoration: BoxDecoration(color: Colors.blue),
      //         child: Text(
      //           'Pilih Tahun',
      //           style: TextStyle(fontSize: 24, color: Colors.white),
      //         ),
      //       ),
      //       ListTile(
      //         title: Text('2021'),
      //         onTap: () {
      //           setState(() {
      //             selectedYear = '2021';
      //           });
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: Text('2022'),
      //         onTap: () {
      //           setState(() {
      //             selectedYear = '2022';
      //           });
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: Text('2023'),
      //         onTap: () {
      //           setState(() {
      //             selectedYear = '2023';
      //           });
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: Text('2024'),
      //         onTap: () {
      //           setState(() {
      //             selectedYear = '2024';
      //           });
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
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
