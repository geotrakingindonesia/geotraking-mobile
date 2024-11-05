// vessel_info_widget.dart

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/formated_latlong.dart';
import 'package:geotraking/core/components/info_row.dart';
import 'package:intl/intl.dart';

class VesselInfoWidget extends StatelessWidget {
  final Map<String, dynamic> vesselData;
  final FormatedLatlong latlongFormatter = FormatedLatlong();

  VesselInfoWidget({Key? key, required this.vesselData}) : super(key: key);

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
            buildInfoRow('${vesselData['nama_kapal']}', '(${vesselData['idfull']})'),
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
              'Received date',
              '${DateFormat('dd MMM yyyy hh:mm a').format(DateTime.parse(vesselData['timestamp']))}',
              'Broadcast date',
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
              '${latlongFormatter.formatLatitude(double.tryParse(vesselData['lat']))}',
              'Longitude',
              '${latlongFormatter.formatLongitude(double.tryParse(vesselData['lon']))}',
            ),
            Divider(),
            buildInfoColumnInRow(
              'Power source',
              '${vesselData['powerstatus']}',
              'Power value',
              '${vesselData['externalvoltagelon'] ?? '-'} kWh',
            ),
            Divider(),
            buildInfoColumnInRow(
              'Heading',
              '${vesselData['heading']}°',
              'Speed',
              '${vesselData['speed_kn']} knots',
            ),
          ],
        ),
      ),
    );
  }
}
