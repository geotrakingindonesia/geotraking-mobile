// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/app_back_button.dart';
// import 'package:geotraking/core/constants/app_defaults.dart';
// import 'package:geotraking/views/home/categories/topup/components/tab_card.dart';

// class TabSeeAll extends StatelessWidget {
//   final List<Map<String, dynamic>> topUpData;
//   final String title;
//   final String imageUrl;

//   const TabSeeAll({
//     Key? key,
//     required this.topUpData,
//     required this.title,
//     required this.imageUrl,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('$title'),
//         leading: const AppBackButton(),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: Colors.black,
//             ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black54,
//                       blurRadius: 10.0,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: AppDefaults.borderRadius,
//                   child: CachedNetworkImage(
//                     imageUrl: imageUrl,
//                     width: double.infinity,
//                     fit: BoxFit.contain,
//                     placeholder: (context, url) => Container(
//                       width: double.infinity,
//                       height: double.infinity,
//                       color: Colors.white,
//                       child: Center(child: CircularProgressIndicator()),
//                     ),
//                     errorWidget: (context, url, error) => Container(
//                       color: Colors.white,
//                       child: Icon(Icons.error, color: Colors.red),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(10),
//               itemCount: topUpData.length,
//               itemBuilder: (context, index) {
//                 final topUp = topUpData[index];
//                 return TabCard(
//                   namaPaket: topUp['nama_paket'],
//                   kuota: topUp['kuota'],
//                   masaAktif: topUp['masa_aktif'],
//                   harga: topUp['harga'],
//                   typeSatelit: topUp['type_satelit'],
//                   jenisSatelit: topUp['jenis_satelit'],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       // body: ListView.builder(
//       //   padding: const EdgeInsets.all(10),
//       //   itemCount: topUpData.length,
//       //   itemBuilder: (context, index) {
//       //     final topUp = topUpData[index];
//       //     return TabCard(
//       //       namaPaket: topUp['nama_paket'],
//       //       kuota: topUp['kuota'],
//       //       masaAktif: topUp['masa_aktif'],
//       //       harga: topUp['harga'],
//       //       typeSatelit: topUp['type_satelit'],
//       //       jenisSatelit: topUp['jenis_satelit'],
//       //     );
//       //   },
//       // ),
//     );
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_card.dart';

class TabSeeAll extends StatelessWidget {
  final List<Map<String, dynamic>> topUpData;
  final String title;
  final String imageUrl;

  const TabSeeAll({
    Key? key,
    required this.topUpData,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('$title'),
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      body: Column(
        children: [
          // Container for the image
          FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 300)), // Simulate a delay if needed
            builder: (context, snapshot) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        // height: 200, // Adjust the height as needed
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // ListView for top-up data
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: topUpData.length,
              itemBuilder: (context, index) {
                final topUp = topUpData[index];
                return TabCard(
                  namaPaket: topUp['nama_paket'],
                  kuota: topUp['kuota'],
                  masaAktif: topUp['masa_aktif'],
                  harga: topUp['harga'],
                  typeSatelit: topUp['type_satelit'],
                  jenisSatelit: topUp['jenis_satelit'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
