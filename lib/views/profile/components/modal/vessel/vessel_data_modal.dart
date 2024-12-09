// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VesselDataModal extends StatelessWidget {
  final Map<String, dynamic>? vesselData;
  final String? selectedTimeZonePreferences;
  final String? selectedSpeedPreferences;
  final String? selectedCoordinatePreferences;

  VesselDataModal(
      {required this.vesselData,
      this.selectedTimeZonePreferences,
      this.selectedSpeedPreferences,
      this.selectedCoordinatePreferences});

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

  String getSpeedValue(
      Map<String, dynamic>? data, String? selectedSpeedPreferences) {
    if (data == null) return '-';
    switch (selectedSpeedPreferences) {
      case 'Knots':
        return (data['speed_kn'] ?? 0).toString() + ' Knots';
      case 'Km/h':
        return (data['speed_kmh'] ?? 0).toString() + ' Km/h';
      case 'm/s':
        return (data['speed_ms'] ?? 0).toString() + ' m/s';
      case 'mp/h':
        return (data['speed_mph'] ?? 0).toString() + ' mp/h';
      default:
        return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (vesselData == null) {
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
                vesselData?['nama_kapal'] ?? '-',
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        vesselData?['idfull'] ?? '',
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '${vesselData?['sn'] ?? '-'}/${vesselData?['imei'] ?? '-'}',
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '${vesselData?['type'] ?? '-'}',
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '${vesselData?['kategori'] ?? '-'}',
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
                        'Owner:',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '${vesselData?['custamer'] ?? '-'}',
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
                        'Received Date (${selectedTimeZonePreferences}):',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        _formatDate(vesselData?['timestamp']),
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Broadcast Date (${selectedTimeZonePreferences}):',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        _formatDate(vesselData?['broadcast']),
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
                        'Airtime Start:',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '${DateFormat('dd MMM y').format(DateTime.parse(vesselData?['atp_start']))}',
                        // _formatDate(vesselData?['atp_start']),
                        style: TextStyle(color: Colors.black),
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '${DateFormat('dd MMM y').format(DateTime.parse(vesselData?['atp_end']))}',
                        // _formatDate(vesselData?['atp_end']),
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        selectedCoordinatePreferences == 'Degrees'
                            ? _formatLatitude(
                                double.parse(vesselData?['lat'] ?? '0'))
                            : double.parse(vesselData?['lat'] ?? '0')
                                .toString(),
                        // _formatLatitude(double.parse(vesselData?['lat'] ?? '')),
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        selectedCoordinatePreferences == 'Degrees'
                            ? _formatLongitude(
                                double.parse(vesselData?['lon'] ?? '0'))
                            : double.parse(vesselData?['lon'] ?? '0')
                                .toString(),
                        // _formatLongitude(
                        //     double.parse(vesselData?['lon'] ?? '')),
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '${vesselData?['powerstatus'] ?? '-'}',
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '${vesselData?['externalvoltage'] ?? '-'} kwh',
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '${vesselData?['heading'] ?? '-'}°',
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
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        getSpeedValue(vesselData, selectedSpeedPreferences),
                        // '${vesselData?['speed'] ?? '-'}',
                        // '${vesselData?['speed_kn'] ?? '-'} knot/${vesselData?['speed_kmh'] ?? '-'} kmh ${selectedSpeedPreferences}',
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
