import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/views/home/categories/topup/components/tab_card.dart';

class TabSeeAll extends StatelessWidget {
  final List<Map<String, dynamic>> topUpData;
  final String title;

  const TabSeeAll({
    Key? key,
    required this.topUpData,
    required this.title,
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
      body: ListView.builder(
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
    );
  }
}
