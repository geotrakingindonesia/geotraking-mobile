import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/services/topup_service.dart';
import 'package:geotraking/views/home/categories/topup/components/product_category.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_card.dart';

class TabInmarsat extends StatefulWidget {
  const TabInmarsat({Key? key}) : super(key: key);

  @override
  _TabInmarsatState createState() => _TabInmarsatState();
}

class _TabInmarsatState extends State<TabInmarsat> {
  final TopupService _topupService = TopupService();
  List<Map<String, dynamic>>? _topUpDataPulsa;
  List<Map<String, dynamic>>? _topUpDataBroadband;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final topUpDataPulsa =
          await _topupService.getDataTopUp(typeSatelit: 2, jenisSatelit: 1);
      final topUpDataBroandband =
          await _topupService.getDataTopUp(typeSatelit: 2, jenisSatelit: 2);
      setState(() {
        _topUpDataPulsa = topUpDataPulsa;
        _topUpDataBroadband = topUpDataBroandband;
        print('test data ${_topUpDataPulsa}');
        print('test data ${_topUpDataBroadband}');
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
                          "https://drive.google.com/file/d/1Wk0TaWoQvfapTeotYhij4WzssTxWPAbD/view?usp=sharing"),
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
                  //       'assets/images/banner_inmarsat.jpeg',
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
            _topUpDataPulsa != null
                ? Column(
                    children: _topUpDataPulsa!.map((topUp) {
                      return TabCard(
                        namaPaket: topUp['nama_paket'],
                        kuota: topUp['kuota'],
                        masaAktif: topUp['masa_aktif'],
                        harga: topUp['harga'],
                        typeSatelit: topUp['type_satelit'],
                        jenisSatelit: topUp['jenis_satelit'],
                      );
                    }).toList(),
                  )
                : Center(child: CircularProgressIndicator()),
            SizedBox(height: 32),
            // _topUpDataBroadband != null && _topUpDataBroadband!.isNotEmpty
            //     ? Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Container(
            //             margin: EdgeInsets.only(left: 5),
            //             child: Text(
            //               'Broadband Marine',
            //               style: TextStyle(
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ),
            //           Column(
            //             children: _topUpDataBroadband!.map((topUp) {
            //               return TabCard(
            //                 namaPaket: topUp['nama_paket'],
            //                 kuota: topUp['kuota'],
            //                 masaAktif: topUp['masa_aktif'],
            //                 harga: topUp['harga'],
            //                 typeSatelit: topUp['type_satelit'],
            //                 jenisSatelit: topUp['jenis_satelit'],
            //               );
            //             }).toList(),
            //           ),
            //           SizedBox(height: 32),
            //         ],
            //       )
            //     : Container(),
            ProductCategory(
              categori: 'inmarsat',
            ),
          ],
        ),
      ),
    );
  }
}
