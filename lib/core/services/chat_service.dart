import 'dart:convert';

import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  var apiUrl = 'https://pulsar.pivotel.com.au/MT/V1/SBD';
  var apiUsername = 'PTGIS_Retail';
  var apiPassword = 'Dbc9cHyee*5wd54dCCaJK';

  Future<List<Map<String, dynamic>>?> index() async {
    try {
      var settings = Connection.getConnect();
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

  Future<bool> store({
    required String hexData,
    required int senderId,
    required String mobileId,
  }) async {
    try {
      // Waktu sekarang dan expired_at
      final DateTime now = DateTime.now();
      final DateTime expiredAt = now.add(Duration(days: 180));

      // Buat `varMsgID` sebagai autoincrement
      // Simpan atau ambil nilai terakhir `varMsgID` dari preferensi lokal atau database
      int currentMsgId = await getLastVarMsgID() ?? 1; // Default mulai dari 8
      String varMsgId = 'id${currentMsgId.toString().padLeft(4, '0')}';

      // Tingkatkan nilai `varMsgID` untuk penyimpanan berikutnya
      await saveLastVarMsgID(currentMsgId + 1);

      // Set `serviceID` sesuai dengan `mobileId`
      String serviceId = '$mobileId';

      // Buat URL API dengan parameter dinamis
      String apiUrlWithParams =
          '$apiUrl?varMsgID=$varMsgId&serviceID=$serviceId';

      // Kirim data ke API
      var response = await http.post(
        Uri.parse(apiUrlWithParams),
        headers: {
          'Authorization':
              'Basic ' + base64Encode(utf8.encode('$apiUsername:$apiPassword')),
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'HexData': hexData}),
      );

      print('--------------');
      print(response.statusCode);
      print('--------------');
      // Cek apakah respons dari API berhasil
      if (response.statusCode == 200) {
        // String responseApi = response.body;
        Map<String, dynamic> responseJson = jsonDecode(response.body);

        // Konversi JSON ke string biasa
        String responseApi = '''
Status: ${responseJson['Status']},
UniqueClientMessageID: ${responseJson['Confirmation']['UniqueClientMessageID']},
IMEI: ${responseJson['Confirmation']['IMEI']},
AutoIDReference: ${responseJson['Confirmation']['AutoIDReference']},
MessageStatus: ${responseJson['Confirmation']['MessageStatus']}
''';
        // Jika berhasil, simpan data ke database
        var settings = Connection.getConnect();
        var conn = await MySqlConnection.connect(settings);

        var result = await conn.query('''
        INSERT INTO ai_geo_chat (
          teks, 
          sender_id, 
          mobile_id, 
          created_at, 
          expired_at,
          response_api
        ) VALUES (?, ?, ?, ?, ?, ?)
      ''', [
          hexData,
          senderId,
          mobileId,
          now.toIso8601String(),
          expiredAt.toIso8601String(),
          responseApi,
        ]);

        await conn.close();

        // Return true jika data berhasil disimpan ke database
        return result.affectedRows! > 0;
      } else {
        // Cetak error jika respons API gagal
        print('API error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      // Tangani error lain
      print("Error: $e");
      return false;
    }
  }

// Fungsi untuk mendapatkan nilai terakhir `varMsgID`
  Future<int?> getLastVarMsgID() async {
    // Ambil nilai terakhir dari shared_preferences atau database
    // Contoh menggunakan shared_preferences:
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lastVarMsgID');
  }

// Fungsi untuk menyimpan nilai terbaru `varMsgID`
  Future<void> saveLastVarMsgID(int value) async {
    // Simpan nilai terbaru ke shared_preferences atau database
    // Contoh menggunakan shared_preferences:
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastVarMsgID', value);
  }

  Future<List<Map<String, dynamic>>> show() async {
    try {
      var settings = Connection.getConnect();
      var conn = await MySqlConnection.connect(settings);

      var results = await conn.query('SELECT teks, sender_id, mobile_id, created_at, expired_at, response_api FROM ai_geo_chat');
      await conn.close();

      // Ubah teks Hex ke String setelah data diambil
      return results.map((row) {
        String hexData = row['teks']?.toString() ?? ''; // Ambil data teks (Hex)
        String message = _hexToString(hexData); // Konversi Hex ke String

        return {
          'teks': message, // Teks yang sudah diconvert
          'sender_id': row['sender_id'],
        };
      }).toList();
    } catch (e) {
      print("Error fetching messages: $e");
      return [];
    }
  }

  // Fungsi untuk mengonversi hex ke string
  String _hexToString(String hex) {
    final buffer = StringBuffer();
    for (int i = 0; i < hex.length; i += 2) {
      String part = hex.substring(i, i + 2);
      int charCode = int.parse(part, radix: 16);
      buffer.write(String.fromCharCode(charCode));
    }
    return buffer.toString();
  }
}
