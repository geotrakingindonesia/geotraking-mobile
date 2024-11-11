// import 'package:flutter/material.dart';
// import 'package:geotraking/core/constants/app_defaults.dart';
// import 'package:geotraking/core/services/topup_service.dart';
// import 'package:geotraking/views/home/categories/topup/components/tab_card.dart';
// class TabStarlink extends StatefulWidget {
//   const TabStarlink({Key? key}) : super(key: key);

//   @override
//   _TabStarlinkState createState() => _TabStarlinkState();
// }

// class _TabStarlinkState extends State<TabStarlink> {
//   final TopupService _topupService = TopupService();
//   List<Map<String, dynamic>>? _topUpDataStarlinkMaritime;
//   List<Map<String, dynamic>>? _topUpDataStarlinkLand;

//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }

//   Future<void> _fetchData() async {
//     try {
//       final topUpDataStarlinkMaritime =
//           await _topupService.getDataTopUp(typeSatelit: 3, jenisSatelit: 1);
//       final topUpDataStarlinkLand =
//           await _topupService.getDataTopUp(typeSatelit: 3, jenisSatelit: 2);
//       setState(() {
//         _topUpDataStarlinkMaritime = topUpDataStarlinkMaritime;
//         _topUpDataStarlinkLand = topUpDataStarlinkLand;
//       });
//     } catch (e) {
//       setState(() {
//         print('load err');
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black54,
//                         blurRadius: 10.0,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Container(
//                     child: ClipRRect(
//                       borderRadius: AppDefaults.borderRadius,
//                       child: Image.asset(
//                         'assets/images/banner_starlink.jpeg',
//                         width: double.infinity,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20,),
//             Container(
//               margin: EdgeInsets.only(left: 5),
//               child: Text(
//                 'Starlink Maritime',
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             _topUpDataStarlinkMaritime != null
//                 ? Column(
//                     children: _topUpDataStarlinkMaritime!.map((topUp) {
//                       return TabCard(
//                         namaPaket: topUp['nama_paket'],
//                         kuota: topUp['kuota'],
//                         masaAktif: topUp['masa_aktif'],
//                         harga: topUp['harga'],
//                         typeSatelit: topUp['type_satelit'],
//                         jenisSatelit: topUp['jenis_satelit'],
//                       );
//                     }).toList(),
//                   )
//                 : Center(child: CircularProgressIndicator()),
//             SizedBox(height: 20,),
//             Container(
//               margin: EdgeInsets.only(left: 5),
//               child: Text(
//                 'Starlink Land',
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             _topUpDataStarlinkLand != null
//                 ? Column(
//                     children: _topUpDataStarlinkLand!.map((topUp) {
//                       return TabCard(
//                         namaPaket: topUp['nama_paket'],
//                         kuota: topUp['kuota'],
//                         masaAktif: topUp['masa_aktif'],
//                         harga: topUp['harga'],
//                         typeSatelit: topUp['type_satelit'],
//                         jenisSatelit: topUp['jenis_satelit'],
//                       );
//                     }).toList(),
//                   )
//                 : Center(child: CircularProgressIndicator()),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/services/topup_service.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_card.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_see_all.dart';

class TabStarlink extends StatefulWidget {
  const TabStarlink({Key? key}) : super(key: key);

  @override
  _TabStarlinkState createState() => _TabStarlinkState();
}

class _TabStarlinkState extends State<TabStarlink> {
  final TopupService _topupService = TopupService();
  List<Map<String, dynamic>>? _topUpDataStarlinkMaritime;
  List<Map<String, dynamic>>? _topUpDataStarlinkLand;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final topUpDataStarlinkMaritime =
          await _topupService.getDataTopUp(typeSatelit: 3, jenisSatelit: 1);
      final topUpDataStarlinkLand =
          await _topupService.getDataTopUp(typeSatelit: 3, jenisSatelit: 2);
      setState(() {
        _topUpDataStarlinkMaritime = topUpDataStarlinkMaritime;
        _topUpDataStarlinkLand = topUpDataStarlinkLand;
      });
    } catch (e) {
      setState(() {
        print('load err');
      });
    }
  }

  String _convertDriveLink(String driveUrl) {
    final fileId = driveUrl.split('/d/')[1].split('/')[0];
    return 'https://drive.google.com/uc?export=view&id=$fileId';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            const SizedBox(height: 20),
            _buildSectionTitle('Starlink Maritime'),
            _topUpDataStarlinkMaritime != null
                ? _buildTopUpSection(
                    _topUpDataStarlinkMaritime!, 'Starlink Maritime')
                : const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 20),
            _buildSectionTitle('Starlink Land'),
            _topUpDataStarlinkLand != null
                ? _buildTopUpSection(_topUpDataStarlinkLand!, 'Starlink Land')
                : const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: const BoxDecoration(
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
              imageUrl: _convertDriveLink(
                  "https://drive.google.com/file/d/1WImAlPGGwINk9OwaS8Njz4WbnrN6aj_L/view?usp=sharing"),
              width: double.infinity,
              fit: BoxFit.contain,
              placeholder: (context, url) => Container(
                width: double.infinity,
                // height: double.infinity,
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
      ),
    );
  }

  Widget _buildTopUpSection(
      List<Map<String, dynamic>> topUpData, String title) {
    List<Map<String, dynamic>> firstThreeItems =
        topUpData.length > 3 ? topUpData.sublist(0, 3) : topUpData;

    return Column(
      children: [
        Column(
          children: firstThreeItems.map((topUp) {
            return TabCard(
              namaPaket: topUp['nama_paket'],
              kuota: topUp['kuota'],
              masaAktif: topUp['masa_aktif'],
              harga: topUp['harga'],
              typeSatelit: topUp['type_satelit'],
              jenisSatelit: topUp['jenis_satelit'],
            );
          }).toList(),
        ),
        if (topUpData.length > 3)
          TextButton(
            onPressed: () {
              if (topUpData.isNotEmpty && topUpData[0]['jenis_satelit'] == 1) {
                _showAllTopUpItems(
                    context,
                    _topUpDataStarlinkMaritime!,
                    'Starlink Maritime',
                    _convertDriveLink(
                        "https://drive.google.com/file/d/1wE7kOfnBcExp8SDFUsFrN2rmbvKe9t1M/view?usp=sharing"));
              } else if (topUpData.isNotEmpty &&
                  topUpData[0]['jenis_satelit'] == 2) {
                _showAllTopUpItems(
                    context,
                    _topUpDataStarlinkLand!,
                    'Starlink Land',
                    _convertDriveLink(
                        "https://drive.google.com/file/d/1vjobXAk-J0vfkmnkLU84RoqjNxu9otfi/view?usp=sharing"));
              }
            },
            child: const Text(
              'Lihat Semua',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  void _showAllTopUpItems(BuildContext context,
      List<Map<String, dynamic>> topUpData, String title, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TabSeeAll(
          topUpData: topUpData,
          title: title,
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}
