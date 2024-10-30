// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
// import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/views/catalogue/components/hubungi_kami_button.dart';
import 'package:url_launcher/url_launcher.dart';

class TabDetail extends StatefulWidget {
  TabDetail({super.key, 
    required this.namaPaket,
    required this.kuota,
    required this.masaAktif,
    required this.harga,
    required this.typeSatelit,
    required this.jenisSatelit,
  });

  final String harga;
  final int jenisSatelit;
  final String kuota;
  final String masaAktif;
  final String namaPaket;
  final int typeSatelit;

  @override
  _TabDetailState createState() => _TabDetailState();
}

String typeSatelitLabel(int? typeSatelit) {
  switch (typeSatelit) {
    case 1:
      return 'Iridium';
    case 2:
      return 'Inmarsat';
    case 3:
      return 'Starlink';
    default:
      return '-';
  }
}

String jenisSatelitLabel(int? typeSatelit, int? jenisSatelit) {
  if (typeSatelit == 3) {
    switch (jenisSatelit) {
      case 1:
        return 'Starlink Maritime';
      case 2:
        return 'Starlink Land';
      default:
        return '-';
    }
  } else {
    switch (jenisSatelit) {
      case 1:
        return 'Pulsa';
      case 2:
        return 'Broadband Marine';
      default:
        return '-';
    }
  }
}

String deskSatelit(int? typeSatelit) {
  switch (typeSatelit) {
    case 1:
      return 'Pulsa Telepon Satelit Iridium dengan System Topup electrik, Nomor akan di proses Topup H+1 setelah invoice di kirim\n\nKartu Perdana ini sangat cocok untuk :\n– Iridium 9555\n– Iridium 9575 Extreme\n– Iridium 9505A\n\nKami juga melayani Refill Isi Ulang Pulsa Iridium\n\nGEOMATIKA SATELIT INDONESIA juga menyediakan :\n- Tracking Kapal (VMS - Vessel Monitoring System)\n- ⁠RPM Sensor + Traking\n- ⁠Fuel Monitoring\n- ⁠Satellite Phone\n- ⁠AIS Station\n- ⁠AIS Class B\n- Internet Maritim';
    case 2:
      return 'Internet berkecepatan tinggi dan andal untuk bisnis maritim anda. Kuota Mobile Tanpa Batas di perairan di benua.\n\nFITUR UTAMA\n- Kuota Benua Tanpa Batas\n- ⁠Penggunaan Bepergian + di Laut\n- ⁠Prioritas Jaringan\n- ⁠Dukungan Prioritas\n\nHarga diatas belum termasuk PPN 11%\n\nGEOMATIKA SATELIT INDONESIA juga menyediakan :\n•⁠  ⁠Tracking Kapal (VMS - Vessel Monitoring System)\n•⁠  ⁠⁠RPM Sensor + Traking\n•⁠  ⁠⁠Fuel Monitoring\n•⁠  ⁠⁠Satellite Phone\n•⁠  ⁠⁠AIS Station\n•⁠  ⁠⁠AIS Class B\n•  Internet Maritim';
    case 3:
      return 'Starlink adalah konstelasi satelit pertama dan terbesar di dunia yang menggunakan orbit rendah Bumi untuk memberikan internet broadband yang mampu mendukung streaming, gaming online, panggilan video, dan banyak lagi.\nMemanfaatkan satelit canggih dan perangkat keras pengguna, ditambah dengan pengalaman kami yang luas dalam hal pesawat ruang angkasa dan operasi di orbit, Starlink memberikan internet berkecepatan tinggi dan latensi rendah kepada pengguna di seluruh dunia.';
    default:
      return '-';
  }
}

String fiturSatelit(int? typeSatelit, int? jenisSatelit) {
  if (typeSatelit == 3) {
    switch (jenisSatelit) {
      case 1:
        return 'Fitur Utama\n1. Kuota Benua Tanpa Batas\n2. Penggunaan Bepergian + di Laut\n3. Prioritas Jaringan\n4. Dukungan Prioritas';
      case 2:
        return 'Fitur Utama\n1. Jangkauan Seluruh Negara\n2. Penggunaan Saat Bepergian\n3. Perjalanan Internasional\n4. Cakupan Pesisir\n5. Jeda Layanan';
      default:
        return '';
    }
  } else {
    switch (jenisSatelit) {
      case 1:
        return '';
      case 2:
        return '';
      default:
        return '';
    }
  }
}

String sAndKSatelit(int? typeSatelit, int? jenisSatelit) {
  if (typeSatelit == 3) {
    switch (jenisSatelit) {
      case 1:
        return '1. Kontrak perbulan\n2. Belum termasuk PPN 11%';
      case 2:
        return '1. Kontrak perbulan\n2. Paket Land jika kuota habis akan Throtle down (FUP)\n3. Belum termasuk PPN 11%';
      default:
        return '';
    }
  } else {
    switch (jenisSatelit) {
      case 1:
        return '1. Harga diatas belum termasuk PPN 11%';
      case 2:
        return '1. Harga diatas belum termasuk PPN 11%';
      default:
        return '';
    }
  }
}

class _TabDetailState extends State<TabDetail> {
  bool _isShowSAndK = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detail Paket'),
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black,
            ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.namaPaket,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${widget.kuota} | ${widget.masaAktif}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  widget.harga,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
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
                          Icon(Icons.hourglass_bottom, color: Colors.black87),
                          SizedBox(width: 8),
                          Text(
                            'Masa Aktif',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ],
                      ),
                      Text(
                        widget.masaAktif,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black87),
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
                    '${deskSatelit(widget.typeSatelit)}',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  widget.typeSatelit == 3
                      ? SizedBox(height: 5)
                      : SizedBox.shrink(),
                  Visibility(
                    visible: widget.typeSatelit == 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${fiturSatelit(widget.typeSatelit, widget.jenisSatelit)}',
                            style: TextStyle(color: Colors.grey.shade700),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'S&K',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(_isShowSAndK
                            ? Icons.arrow_upward
                            : Icons.arrow_downward),
                        onPressed: () {
                          setState(() {
                            _isShowSAndK = !_isShowSAndK;
                          });
                        },
                      ),
                    ],
                  ),
                  if (_isShowSAndK)
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${sAndKSatelit(widget.typeSatelit, widget.jenisSatelit)}',
                                style: TextStyle(color: Colors.grey.shade700),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: HubungiKamiButton(
          onHubungiKamiButtonTap: () async {
            String whatsAppUrl =
                'https://wa.me/6281908192559?text=Hallo+Geomatika+Satelit+Indonesia';
            if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
              await launchUrl(Uri.parse(whatsAppUrl));
            } else {
              throw 'Could not launch $whatsAppUrl';
            }
          },
        ),
      ),
    );
  }
}
