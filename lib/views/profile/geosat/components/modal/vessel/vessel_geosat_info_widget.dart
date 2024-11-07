// vessel_info_widget.dart

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/formated_latlong.dart';
import 'package:geotraking/core/components/info_row.dart';
import 'package:intl/intl.dart';

class VesselGeosatInfoWidget extends StatelessWidget {
  final Map<String, dynamic> vesselData;
  final String? selectedTimeZonePreferences;
  final String? selectedSpeedPreferences;
  final String? selectedCoordinatePreferences;
  final FormatedLatlong latlongFormatter = FormatedLatlong();

  VesselGeosatInfoWidget(
      {Key? key,
      required this.vesselData,
      this.selectedTimeZonePreferences,
      this.selectedSpeedPreferences,
      this.selectedCoordinatePreferences})
      : super(key: key);

  String getSpeedValue(Map<String, dynamic>? data, String? selectedSpeed) {
    if (data == null) return '-';
    switch (selectedSpeed) {
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
    return Container(
      padding: EdgeInsets.all(8),
      width: 250,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoRow(
                '${vesselData['nama_kapal']}', '(${vesselData['idfull']})'),
            Divider(),
            buildInfoColumnInRow(
              'SN',
              '${vesselData['sn']}',
              'IMEI',
              '${vesselData['imei']}',
            ),
            Divider(),
            buildInfoColumnInRow(
              'Vessel type',
              '${vesselData['type']}',
              'Category',
              '${vesselData['kategori']}',
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Owner:',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        '${vesselData['custamer']}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            buildInfoColumnInRow(
              'Received date ($selectedTimeZonePreferences)',
              '${DateFormat('dd MMM yyyy hh:mm a').format(DateTime.parse(vesselData['tgl_aktifasi']))}',
              'Broadcast date ($selectedTimeZonePreferences)',
              '${DateFormat('dd MMM yyyy hh:mm a').format(DateTime.parse(vesselData['broadcast']))}',
            ),
            Divider(),
            buildInfoColumnInRow(
              'Airtime Start',
              '${DateFormat('dd MMM yyyy').format(DateTime.parse(vesselData['atp_start']))}',
              'Airtime End',
              '${DateFormat('dd MMM yyyy').format(DateTime.parse(vesselData['atp_end']))}',
            ),
            Divider(),
            buildInfoColumnInRow(
              'Latitude',
              selectedCoordinatePreferences == 'Degrees'
                  ? latlongFormatter
                      .formatLatitude(double.tryParse(vesselData['lat'] ?? '0'))
                  : double.tryParse(vesselData['lat'] ?? '0')?.toString() ??
                      '0',
              'Longitude',
              selectedCoordinatePreferences == 'Degrees'
                  ? latlongFormatter.formatLongitude(
                      double.tryParse(vesselData['lon'] ?? '0'))
                  : double.tryParse(vesselData['lon'] ?? '0')?.toString() ??
                      '0',
            ),
            Divider(),
            buildInfoColumnInRow(
              'Power source',
              '${vesselData['powerstatus']}',
              'Power value',
              '${vesselData['externalvoltagelon'] ?? '-'} kwh',
            ),
            Divider(),
            buildInfoColumnInRow(
              'Heading',
              '${vesselData['heading']}°',
              'Speed',
              getSpeedValue(vesselData, selectedSpeedPreferences),
              // '${vesselData['speed_kn']} knots',
            ),
          ],
        ),
      ),
    );
  }
}
