// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VesselDataGeosatModal extends StatelessWidget {
  final Map<String, dynamic>? kapalGeosat;

  VesselDataGeosatModal({required this.kapalGeosat});

  String _formatLatitude(double? lat) {
    if (lat == null) return '';
    int degrees = lat.toInt();
    double minutes = (lat - degrees) * 60;
    int minutesInt = minutes.toInt();
    double seconds = (minutes - minutesInt) * 60;
    return '${degrees.abs()} ${degrees < 0 ? 'S' : 'N'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
  }

  String _formatLongitude(double? lon) {
    if (lon == null) return '';
    int degrees = lon.toInt();
    double minutes = (lon - degrees) * 60;
    int minutesInt = minutes.toInt();
    double seconds = (minutes - minutesInt) * 60;
    return '${degrees.abs()} ${degrees < 0 ? 'W' : 'E'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return '-';
    if (timestamp is DateTime) {
      return DateFormat('dd MMM y (HH:mm:ss)').format(timestamp);
    } else if (timestamp is String) {
      try {
        DateTime dateTime = DateTime.parse(timestamp);
        return DateFormat('dd MMM y (HH:mm:ss)').format(dateTime);
      } catch (e) {
        return '-';
      }
    }
    return '-';
  }

  // String _formatDate(String? dateStr) {
  //   if (dateStr == null || dateStr.isEmpty) return '-';

  //   try {
  //     DateTime dateTime = DateTime.parse(dateStr);
  //     return DateFormat('dd MMM y (HH:mm:ss)').format(dateTime);
  //   } catch (e) {
  //     return '-';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (kapalGeosat == null) {
      return Center(child: Text('No data available'));
    }
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                kapalGeosat?['nama_kapal'] ?? '',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Id:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        kapalGeosat?['idfull'] ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SN/IMEI:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${kapalGeosat?['sn']}/${kapalGeosat?['imei']}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Device Type:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        // kapalMember.type!,
                        kapalGeosat?['type'] ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        kapalGeosat?['kategori'] ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Received Date:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        kapalGeosat?['tgl_aktifasi'] != null
                            ? _formatDate(kapalGeosat?['tgl_aktifasi'])
                            : '-',
                        style: const TextStyle(color: Colors.black),
                      ),
                      // Text(
                      //   // kapalMember.timestamp != null
                      //   kapalGeosat?['tgl_aktifasi'] != null
                      //       ? '${DateFormat('dd MMM y (HH:mm:ss)').format(kapalGeosat?['tgl_aktifasi'])}'
                      //       : '-',
                      //   style: TextStyle(color: Colors.black),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Broadcast Date:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        kapalGeosat?['broadcast'] != null
                            ? _formatDate(kapalGeosat?['broadcast'])
                            : '-',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Airtime Start:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${DateFormat('dd MMM y').format(DateTime.parse(kapalGeosat?['atp_start']))}',
                        // kapalGeosat?['atp_start'] != null
                        //     ? _formatDate(kapalGeosat?['atp_start'])
                        //     : '-',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Airtime End:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${DateFormat('dd MMM y').format(DateTime.parse(kapalGeosat?['atp_end']))}',
                        // kapalGeosat?['atp_end'] != null
                        //     ? _formatDate(kapalGeosat?['atp_end'])
                        //     : '-',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Latitude:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        _formatLatitude(double.parse(kapalGeosat?['lat'])),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Longitude:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        _formatLongitude(double.parse(kapalGeosat?['lon'])),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Power Source:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${kapalGeosat?['powerstatus']}°',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Power Value:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${kapalGeosat?['externalvoltage']} kwh',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Heading:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${kapalGeosat?['heading']}°',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Speed:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${kapalGeosat?['speed_kn']} Knot/${kapalGeosat?['speed_kmh']} Kmh',
                        // '${kapalGeosat?['speed']} knot',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
