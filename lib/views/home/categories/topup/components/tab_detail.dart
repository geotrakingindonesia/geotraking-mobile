import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';

class TabDetail extends StatelessWidget {
  final String namaPaket;
  final String kuota;
  final String masaAktif;
  final String harga;
  final int typeSatelit;
  final int jenisSatelit;

  TabDetail({
    required this.namaPaket,
    required this.kuota,
    required this.masaAktif,
    required this.harga,
    required this.typeSatelit,
    required this.jenisSatelit,
  });

  String typeSatelitLabel(int? typeSatelit) {
    switch (typeSatelit) {
      case 1:
        return 'Iridium';
      case 2:
        return 'Inmarsat';
      case 3:
        return 'Thuraya';
      default:
        return 'Unknown';
    }
  }

  String jenisSatelitLabel(int? jenisSatelit) {
    switch (jenisSatelit) {
      case 1:
        return 'Pulsa';
      case 2:
        return 'Broadband Marine';
      default:
        return 'Unknown';
    }
  }

  String deskSatelit(int? jenisSatelit) {
    switch (jenisSatelit) {
      case 1:
        return 'Pulsa Telepon Satelit Iridium dengan System Topup electrik, Nomor akan di proses Topup H+1 setelah invoice di kirim\n\nKartu Perdana ini sangat cocok untuk :\n– Iridium 9555\n– Iridium 9575 Extreme\n– Iridium 9505A\n\nKami juga melayani Refill Isi Ulang Pulsa Iridium\n\nHarga diatas belum termasuk PPN 11%\n\nGEOMATIKA SATELIT INDONESIA juga menyediakan :\n- Tracking Kapal (VMS - Vessel Monitoring System)\n- ⁠RPM Sensor + Traking\n- ⁠Fuel Monitoring\n- ⁠Satellite Phone\n- ⁠AIS Station\n- ⁠AIS Class B\n- Internet Maritim';
      case 2:
        return 'Internet berkecepatan tinggi dan andal untuk bisnis maritim anda. Kuota Mobile Tanpa Batas di perairan di benua.\n\nFITUR UTAMA\n- Kuota Benua Tanpa Batas\n- ⁠Penggunaan Bepergian + di Laut\n- ⁠Prioritas Jaringan\n- ⁠Dukungan Prioritas\n\nHarga diatas belum termasuk PPN 11%\n\nGEOMATIKA SATELIT INDONESIA juga menyediakan :\n•⁠  ⁠Tracking Kapal (VMS - Vessel Monitoring System)\n•⁠  ⁠⁠RPM Sensor + Traking\n•⁠  ⁠⁠Fuel Monitoring\n•⁠  ⁠⁠Satellite Phone\n•⁠  ⁠⁠AIS Station\n•⁠  ⁠⁠AIS Class B\n•  Internet Maritim';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detail Paket'),
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              namaPaket,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  kuota,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  harga,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                  '${typeSatelitLabel(typeSatelit)} - ${jenisSatelitLabel(jenisSatelit)}'),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.hourglass_bottom),
                          SizedBox(width: 8),
                          Text(
                            'Masa Aktif',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        masaAktif,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${deskSatelit(typeSatelit)}',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Harga Total',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    harga,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 127, 183, 126),
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Beli Sekarang',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
