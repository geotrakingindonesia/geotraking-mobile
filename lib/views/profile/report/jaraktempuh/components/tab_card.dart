// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabCard extends StatelessWidget {
  final String tanggalBerlayar;
  final String jarak;
  final String lamaBerlayar;
  String? rerataSpeed;
  String? highSpeed;
  String? lowSpeed;
  String? latAkhir;
  String? lonAkhir;

  TabCard({
    super.key,
    required this.tanggalBerlayar,
    required this.jarak,
    required this.lamaBerlayar,
    this.rerataSpeed,
    this.highSpeed,
    this.lowSpeed,
    this.latAkhir,
    this.lonAkhir,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 243, 182, 100),
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
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tanggalBerlayar,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.clock,
                      color: Colors.black87,
                      size: 14,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$lamaBerlayar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.speed_rounded,
                      color: Colors.black87,
                      size: 14,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$rerataSpeed',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'High: $highSpeed | Low: $lowSpeed',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '$jarak',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
