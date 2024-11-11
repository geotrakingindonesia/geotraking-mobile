import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/services/topup_service.dart';
import 'package:geotraking/views/home/categories/topup/components/product_category.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_card.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_see_all.dart';

class TabIridium extends StatefulWidget {
  const TabIridium({Key? key}) : super(key: key);

  @override
  _TabIridiumState createState() => _TabIridiumState();
}

class _TabIridiumState extends State<TabIridium> {
  final TopupService _topupService = TopupService();
  List<Map<String, dynamic>>? _topUpDataPulsaIridium;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final topUpDataPulsa =
          await _topupService.getDataTopUp(typeSatelit: 1, jenisSatelit: 1);
      setState(() {
        _topUpDataPulsaIridium = topUpDataPulsa;
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5),
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
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/1UjQutJC_bGkeXvZOl0Nu2zrZ298BSzMq/view?usp=sharing"),
                      width: double.infinity,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        // height: double.infinity,
                        color:
                            Colors.white, // White background for loading state
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                  // child: Container(
                  //   child: ClipRRect(
                  //     borderRadius: AppDefaults.borderRadius,
                  //     child: Image.asset(
                  //       'assets/images/banner_iridium.jpeg',
                  //       width: double.infinity,
                  //       fit: BoxFit.contain,
                  //     ),
                  //   ),
                  // ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Pulsa Prepaid Plan',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            _topUpDataPulsaIridium != null
                ? _buildTopUpSection(
                    _topUpDataPulsaIridium!, 'Pulsa Prepaid Plan')
                : const Center(child: CircularProgressIndicator()),
            SizedBox(height: 10),
            ProductCategory(
              categori: 'iridium',
            ),
          ],
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
              _showAllTopUpItems(
                  context, _topUpDataPulsaIridium!, 'Pulsa Prepaid Plan', _convertDriveLink("https://drive.google.com/file/d/1UjQutJC_bGkeXvZOl0Nu2zrZ298BSzMq/view?usp=sharing"));
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
