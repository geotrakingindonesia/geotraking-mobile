// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VesselDataModal extends StatelessWidget {
  final dynamic kapalAPN;

  VesselDataModal({super.key, required this.kapalAPN});

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

  @override
  Widget build(BuildContext context) {
    if (kapalAPN == null) {
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
                '${kapalAPN['vessel_name']}',
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
                        '${kapalAPN['idfull'] ?? '-'}',
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
                        'MMSI/SN/IMEI:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${kapalAPN['mobile_id']}/${kapalAPN['sn'] ?? '-'}/${kapalAPN['imei']?? '-'}',
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
                        'Vessel Type:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${kapalAPN['type_name']?? '-'}',
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
                        '${kapalAPN['category_name']?? '-'}',
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
                        'Flag:',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '${kapalAPN['flag_country_name']?? '-'}',
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
                        kapalAPN['timestamp'] != null
                            ? '${DateFormat('dd MMM y (HH:mm:ss)').format(kapalAPN['timestamp']!)}'
                            : '-',
                        style: TextStyle(color: Colors.black),
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
                        _formatLatitude(double.parse(kapalAPN['latitude'])),
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
                        _formatLongitude(double.parse(kapalAPN['longitude'])),
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
                        '${kapalAPN['powerstatus']?? '-'}',
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
                        '${kapalAPN['externalvoltage']?? '0'} kwh',
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
                        '${kapalAPN['heading']?? '0'}°',
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
                        '${kapalAPN['speed']?? '0'} knot',
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
