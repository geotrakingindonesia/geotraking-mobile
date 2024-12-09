import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/custom_tab_label.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_inmarsat.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_iridium.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_starlink.dart';

class TopupPage extends StatefulWidget {
  const TopupPage({super.key});

  @override
  _TopupPageState createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('TopUp'),
          leading: const AppBackButton(),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
              ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 196, 218, 210),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Color.fromARGB(255, 106, 156, 137),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    CustomTabLabel(label: 'Iridium'),
                    CustomTabLabel(label: 'Inmarsat'),
                    CustomTabLabel(label: 'Starlink'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: const TabBarView(
            children: [
              TabIridium(),
              TabInmarsat(),
              TabStarlink(),
            ],
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       BannerRekening(),
      //       Center(
      //         child: Text(
      //           'Ongoing',
      //           style: TextStyle(fontSize: 14),
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       Column(
      //         children: [
      //           ListTile(
      //             title: Text('Iridium'),
      //             leading: Radio<String>(
      //               value: 'Option 1',
      //               groupValue: _selectedPulsa,
      //               onChanged: (value) {
      //                 setState(() {
      //                   _selectedPulsa = value!;
      //                 });
      //               },
      //             ),
      //           ),
      //           ListTile(
      //             title: Text('Inmarsat'),
      //             leading: Radio<String>(
      //               value: 'Option 2',
      //               groupValue: _selectedPulsa,
      //               onChanged: (value) {
      //                 setState(() {
      //                   _selectedPulsa = value!;
      //                 });
      //               },
      //             ),
      //           ),
      //           ListTile(
      //             title: Text('Thuraya'),
      //             leading: Radio<String>(
      //               value: 'Option 3',
      //               groupValue: _selectedPulsa,
      //               onChanged: (value) {
      //                 setState(() {
      //                   _selectedPulsa = value!;
      //                 });
      //               },
      //             ),
      //           ),
      //           ListTile(
      //             title: Text('Starlink'),
      //             leading: Radio<String>(
      //               value: 'Option 4',
      //               groupValue: _selectedPulsa,
      //               onChanged: (value) {
      //                 setState(() {
      //                   _selectedPulsa = value!;
      //                 });
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
      //       SizedBox(height: 20),
      //       if (_selectedPulsa == 'Option 1') ...[
      //         Text('Jenis Pulsa'),
      //         Column(
      //           children: [
      //             ListTile(
      //               title: Text('Postpaid'),
      //               leading: Radio<String>(
      //                 value: 'Option 1',
      //                 groupValue: _selectedJenisPulsa,
      //                 onChanged: (value) {
      //                   setState(() {
      //                     _selectedJenisPulsa = value!;
      //                   });
      //                 },
      //               ),
      //             ),
      //             ListTile(
      //               title: Text('Prepaid'),
      //               leading: Radio<String>(
      //                 value: 'Option 2',
      //                 groupValue: _selectedJenisPulsa,
      //                 onChanged: (value) {
      //                   setState(() {
      //                     _selectedJenisPulsa = value!;
      //                   });
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //       if (_selectedJenisPulsa == 'Option 1') ...[
      //         Text('Jenis Pulsa Lagi'),
      //         DropdownButton<String>(
      //           value: _selectedJenisPulsaLagi,
      //           items: <String>['1 Bulan', '6 Bulan', '1 Tahun']
      //               .map((String value) {
      //             return DropdownMenuItem<String>(
      //               value: value,
      //               child: Text(value),
      //             );
      //           }).toList(),
      //           onChanged: (String? newValue) {
      //             setState(() {
      //               _selectedJenisPulsaLagi = newValue!;
      //             });
      //           },
      //           isExpanded: true,
      //           hint: Text('Select Jenis Pulsa Lagi'),
      //         ),
      //         SizedBox(height: 20),
      //       ],
      //       if (_selectedJenisPulsaLagi == '1 Bulan') ...[
      //         Text('No Telp'),
      //         TextField(
      //           keyboardType: TextInputType.number,
      //           decoration: InputDecoration(
      //             labelText: 'No Telp',
      //             border: OutlineInputBorder(),
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         Text('Nama PT'),
      //         TextField(
      //           keyboardType: TextInputType.text,
      //           decoration: InputDecoration(
      //             labelText: 'Nama PT',
      //             border: OutlineInputBorder(),
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //       ],
      //     ],
      //   ),
      // ),
    );
  }
}



// import 'package:flutter/material.dart';

// class TopupPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.arrow_back),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Prabayar',
//               style: TextStyle(color: Colors.black),
//             ),
//             Text(
//               '0813 8419 7696',
//               style: TextStyle(color: Colors.black54, fontSize: 14),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Tab Bar Section
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//               color: Colors.grey[100],
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // For You Tab
//                   Column(
//                     children: [
//                       Icon(Icons.card_giftcard, color: Colors.orange),
//                       Text(
//                         'For You',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ],
//                   ),
//                   // Internet Tab (Active)
//                   Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding:
//                             EdgeInsets.symmetric(vertical: 6, horizontal: 20),
//                         child: Row(
//                           children: [
//                             Icon(Icons.public, color: Colors.white),
//                             SizedBox(width: 5),
//                             Text(
//                               'Internet',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Video Tab
//                   Column(
//                     children: [
//                       Icon(Icons.ondemand_video, color: Colors.grey),
//                       Text('Video', style: TextStyle(color: Colors.black)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             // Filter section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.settings, color: Colors.black54),
//                   SizedBox(width: 10),
//                   DropdownButton<String>(
//                     value: 'Nama Paket',
//                     onChanged: (value) {},
//                     items: ['Nama Paket']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             // Packages
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Serba Lima Ribu',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 16),

//                   // First Package
//                   packageCard('Serba Lima Ribu', '5 GB', '1 Hari', 'Rp5.000'),
//                   packageCard('Paket Internet', '6 GB', '1 Hari', 'Rp6.000'),
//                   packageCard('Paket Internet', '8 GB', '1 Hari', 'Rp7.000'),

//                   // See All Button
//                   SizedBox(height: 8),
//                   Center(
//                     child: TextButton(
//                       onPressed: () {},
//                       child: Text(
//                         'Lihat Semua',
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   ),

//                   // Promo Section
//                   SizedBox(height: 16),
//                   Text(
//                     'Super Seru',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   promoCard(
//                       'Super Seru', '80 GB', '28 Hari', 'Rp100.000', 'Voucher 1 Kupon'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget packageCard(String title, String data, String duration, String price) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         title: Text(title),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('$data $duration'),
//             SizedBox(height: 5),
//             Text('$data Utama'),
//           ],
//         ),
//         trailing: Text(
//           price,
//           style: TextStyle(color: Colors.red),
//         ),
//       ),
//     );
//   }

//   Widget promoCard(
//       String title, String data, String duration, String price, String voucher) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         leading: Container(
//           padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//           decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Text(
//             'Promo',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         title: Text(title),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('$data $duration'),
//             SizedBox(height: 5),
//             Row(
//               children: [
//                 Text('$data Utama'),
//                 SizedBox(width: 8),
//                 Text(voucher),
//               ],
//             ),
//           ],
//         ),
//         trailing: Text(
//           price,
//           style: TextStyle(color: Colors.red),
//         ),
//       ),
//     );
//   }
// }
