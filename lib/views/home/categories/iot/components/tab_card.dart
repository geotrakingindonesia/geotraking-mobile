// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:geotraking/views/home/categories/iot/components/tab_detail.dart';

class TabCard extends StatelessWidget {
  final String namaPaket;
  final String kuota;
  final String masaAktif;
  // String? harga;
  // int? typeSatelit;
  // int? jenisSatelit;

  TabCard({
    required this.namaPaket,
    required this.kuota,
    required this.masaAktif,
    // this.harga,
    // this.typeSatelit,
    // this.jenisSatelit,
  });

  // String formatRupiah(String? harga) {
  //   if (harga == null || harga == '-') {
  //     return 'IDR -';
  //   }

  //   final number = int.tryParse(harga);
  //   if (number != null) {
  //     final formatted = NumberFormat.currency(
  //             locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
  //         .format(number);
  //     return formatted;
  //   }
  //   return 'IDR -';
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TabDetail(
                namaPaket: namaPaket,
                kuota: kuota,
                masaAktif: masaAktif,
                // harga: formatRupiah(harga),
                // typeSatelit: typeSatelit!,
                // jenisSatelit: jenisSatelit!,
              ),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaPaket,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  kuota,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${masaAktif}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            // Text(
            //   formatRupiah(harga),
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.red,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
