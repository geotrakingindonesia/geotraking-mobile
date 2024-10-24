import 'package:geotraking/core/models/airtime.dart';
import 'package:geotraking/core/models/history_airtime.dart';
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';

class AirtimeService {
  final AuthService _authService = AuthService();

  Future<Airtime?> getAirtime(String idfull) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      am.id AS mobile_id,
      am.idfull,
      am.name AS nama_kapal,
      am.sn,
      am.imei,
      mc.name AS kategori,
      mt.name AS type,
      c.customer_name AS custamer,
      COALESCE(am.timestamp, '0000-00-00 00:00:00') AS timestamp,
      COALESCE(am.msgTimestamp_GMT, am.timestamp, '0000-00-00 00:00:00') AS broadcast,
    	COALESCE(NULLIF(am.lat, ''), 0) AS lat,
			COALESCE(NULLIF(am.lon, ''), 0) AS lon,
			COALESCE(am.heading, 0) AS heading,
			COALESCE(am.speed, 0) AS speed,
      COALESCE(speed * 3.6, 0) AS speed_kmh,
      COALESCE(speed * 1.9438, 0) AS speed_kn,
      am.powerstatus,
      COALESCE(am.externalvoltage, 0) AS externalvoltage,
      COALESCE(am.atp_start, '0000-00-00 00:00:00') AS atp_start,
      COALESCE(am.atp_end, '0000-00-00 00:00:00') AS atp_end
    FROM 
      ai_mobile AS am
      LEFT JOIN ai_mobile_category AS mc ON mc.id = am.category_id
      LEFT JOIN ai_mobile_type AS mt ON mt.id = am.type_id
      LEFT JOIN ai_customer_data AS c ON c.id = am.customer
    WHERE 
      am.idfull =?
    ''', [idfull]);

    print('result: $results');

    Airtime? dataAirtime;

    if (results.isNotEmpty) {
      var row = results.first;

      dataAirtime = Airtime(
        mobileId: row['mobile_id'] ?? '',
        idfull: row['idfull'] ?? '',
        namaKapal: row['nama_kapal'] ?? '',
        sn: row['sn'] ?? '',
        imei: row['imei'] ?? '',
        kategori: row['kategori'] ?? '',
        type: row['type'] ?? '',
        custamer: row['custamer'] ?? '',
        lat: double.parse(row['lat'] ?? '0'),
        lon: double.parse(row['lon'] ?? '0'),
        speed: double.parse(row['speed'] ?? '0'),
        speedKmh: row['speed_kmh'] ?? '0',
        speedKn: row['speed_kn'] ?? '0',
        heading: double.parse(row['heading'] ?? '0'),
        powerstatus: row['powerstatus'] ?? '',
        externalvoltage: double.parse(row['externalvoltage'] ?? '0'),
        broadcast: row['broadcast'] as String?,
        timestamp: row['timestamp'] as String?,
        atp_start: row['atp_start'] as String?,
        atp_end: row['atp_end'] as String?,
      );
    }

    await conn.close();

    return dataAirtime;
  }

  Future<List<HistoryAirtime>> getHistoryAirtime(String idfull) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      atd.id as id,
      atd.airtimestart AS airtime_start,
      atd.airtimeend AS airtime_end
    FROM 
      ai_trans_detail AS atd
      LEFT JOIN ai_mobile AS am ON am.idfull = atd.deviceid
    WHERE 
      atd.deviceid =?
    ''', [idfull]);

    List<HistoryAirtime> historyAirtimeList = [];

    for (var row in results) {
      HistoryAirtime historyAirtime = HistoryAirtime(
        id: row['id'],
        airtimestart: row['airtime_start'],
        airtimeend: row['airtime_end'],
      );
      historyAirtimeList.add(historyAirtime);
    }

    await conn.close();

    return historyAirtimeList;
  }

  Future<void> storePembayaranAirtime(String mobileId) async {
    final now = DateTime.now().toUtc().add(Duration(hours: 7));

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;

    print('Current User ID: $memberId');

    await conn.query('''
    INSERT INTO ai_status_payment_member (member_id, mobile_id, create_at, status)
    VALUES (?, ?, ?, 0)
    ''', [memberId, mobileId, now]);

    await conn.close();
  }
}
