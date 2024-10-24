import 'package:flutter/material.dart';
import 'package:geotraking/core/services/topup_service.dart';
import 'package:geotraking/views/home/categories/topup/components/product_category.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_card.dart';

class TabThuraya extends StatefulWidget {
  const TabThuraya({Key? key}) : super(key: key);

  @override
  _TabThurayaState createState() => _TabThurayaState();
}

class _TabThurayaState extends State<TabThuraya> {
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
          await _topupService.getDataTopUp(typeSatelit: 3, jenisSatelit: 1);
      final topUpDataBroandband =
          await _topupService.getDataTopUp(typeSatelit: 3, jenisSatelit: 2);
      setState(() {
        _topUpDataPulsa = topUpDataPulsa;
        _topUpDataBroadband = topUpDataBroandband;
        print('test data ${_topUpDataPulsa}');
        print('test data thuraya ${_topUpDataBroadband}');
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Pulsa',
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
            _topUpDataBroadband != null && _topUpDataBroadband!.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          'Broadband Marine',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Column(
                        children: _topUpDataBroadband!.map((topUp) {
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
                      SizedBox(height: 32),
                    ],
                  )
                : Container(),
            ProductCategory(
              categori: 'thuraya',
            ),
          ],
        ),
      ),
    );
  }
}
