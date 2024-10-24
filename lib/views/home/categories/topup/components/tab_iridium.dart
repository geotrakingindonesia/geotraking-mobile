import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/services/topup_service.dart';
import 'package:geotraking/views/home/categories/topup/components/product_category.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_card.dart';

class TabIridium extends StatefulWidget {
  const TabIridium({Key? key}) : super(key: key);

  @override
  _TabIridiumState createState() => _TabIridiumState();
}

class _TabIridiumState extends State<TabIridium> {
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
          await _topupService.getDataTopUp(typeSatelit: 1, jenisSatelit: 1);
      final topUpDataBroandband =
          await _topupService.getDataTopUp(typeSatelit: 1, jenisSatelit: 2);
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
                  child: Container(
                    child: ClipRRect(
                      borderRadius: AppDefaults.borderRadius,
                      child: Image.asset(
                        'assets/images/banner_iridium.jpeg',
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Pulsa Prepaid Plan',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            // Text('1. perdana prepaid iridium\n- e voucher Indonesia 350 menit(365 hari)\n- standard prepaid 100(30 hari), 200(180 hari), 400(180 hari), 600(365 hari)'),
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
              categori: 'iridium',
            ),
          ],
        ),
      ),
    );
  }
}
