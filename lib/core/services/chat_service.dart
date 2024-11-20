import 'dart:convert';

import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';

class ChatService {
  Future<List<Map<String, dynamic>>?> index() async {
    try {
      var settings = Connection.getSettings();
      var conn = await MySqlConnection.connect(settings);
      var results = await conn.query('''
      SELECT 
        m.id, 
        m.idfull, 
        m.sn, 
        m.imei, 
        m.name AS nama_kapal, 
        mc.name AS kategori, 
        mt.name AS type, 
        c.customer_name AS custamer,
        COALESCE(m.timestamp, '0000-00-00 00:00:00') AS tgl_aktifasi,
        COALESCE(m.msgTimestamp_GMT, m.timestamp, '0000-00-00 00:00:00') AS broadcast,
        COALESCE(m.atp_start, '0000-00-00 00:00:00') AS atp_start,
        COALESCE(m.atp_end, '0000-00-00 00:00:00') AS atp_end,
        CASE 
          WHEN m.lat IS NULL OR m.lat = '' OR m.lat = 'None' THEN 0 
          ELSE m.lat 
        END AS lat,
        CASE 
          WHEN m.lon IS NULL OR m.lon = '' OR m.lon = 'None' THEN 0 
          ELSE m.lon 
        END AS lon,
        COALESCE(m.heading, 0) AS heading,
        COALESCE(m.speed, 0) AS speed, 
        COALESCE(speed * 3.6, 0) AS speed_kmh,
        COALESCE(speed * 1, 0) AS speed_kn,
        COALESCE(speed * 0.51444, 0) AS speed_ms,
        COALESCE(speed * 1.15078, 0) AS speed_mph,
        CASE WHEN m.rpm1 IS NULL THEN 0 ELSE m.rpm1 END AS rpm1,
        CASE WHEN m.rpm2 IS NULL THEN 0 ELSE m.rpm2 END AS rpm2,
        m.powerstatus, 
        m.is_chat, 
        COALESCE(m.externalvoltage, 0) AS externalvoltage
      FROM 
        ai_mobile m
        LEFT JOIN ai_mobile_category mc ON m.category_id = mc.id
        LEFT JOIN ai_mobile_type mt ON m.type_id = mt.id
        LEFT JOIN ai_customer_data c ON m.customer = c.id
      WHERE 
        m.imei = 300534064159060 
    ''');

      List<Map<String, dynamic>> dataKapalGeosatList = [];

      if (results.isNotEmpty) {
        for (var row in results) {

          dataKapalGeosatList.add({
            'id': row['id'],
            'idfull': row['idfull'],
            'sn': row['sn'],
            'imei': row['imei'],
            'nama_kapal': row['nama_kapal'],
            'kategori': row['kategori'],
            'type': row['type'],
            'custamer': row['custamer'],
            'tgl_aktifasi': row['tgl_aktifasi'],
            'broadcast': row['broadcast'],
            'lat': row['lat'],
            'lon': row['lon'],
            'speed': row['speed'],
            'speed_kmh': row['speed_kmh'],
            'speed_kn': row['speed_kn'],
            'speed_ms': row['speed_ms'],
            'speed_mph': row['speed_mph'],
            'heading': row['heading'],
            'rpm1': row['rpm1'],
            'rpm2': row['rpm2'],
            'powerstatus': row['powerstatus'],
            'externalvoltage': row['externalvoltage'],
            'atp_start': row['atp_start'],
            'atp_end': row['atp_end'],
            'is_chat': row['is_chat'],
          });
        }
      }

      await conn.close();
      return dataKapalGeosatList;
    } catch (e) {
      // Handle any errors and print the error for debugging
      print("Error fetching data: $e");
      return null;
    }
  }
}
