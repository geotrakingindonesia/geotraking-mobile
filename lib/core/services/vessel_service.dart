// ignore_for_file: non_constant_identifier_names, prefer_final_fields

// import 'package:geotraking/core/models/kapal_member.dart';
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/core/services/connection/connection.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VesselService {
  AuthService _authService = AuthService();
  // fungsi get data kapal(vessel) member
  // Future<List<Map<String, dynamic>>?> getDataKapal() async {
  Future<List<Map<String, dynamic>>?> getDataKapal(String timezone) async {
    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;

    print('Current User ID: $memberId');

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      akm.id AS id,
      akm.member_id AS member_id,
      akm.mobile_id AS mobile_id,
      akm.create_at AS create_at,
      am.id AS mobileId,
      am.idfull AS idfull,
      am.name AS nama_kapal,
      CASE WHEN am.lat = '' THEN 0 ELSE am.lat END AS lat,
      CASE WHEN am.lon = '' THEN 0 ELSE am.lon END AS lon,
      COALESCE(am.timestamp, '0000-00-00 00:00:00') AS timestamp,
      COALESCE(am.msgTimestamp_GMT, am.timestamp, '0000-00-00 00:00:00') AS broadcast,
      COALESCE(am.atp_start, '0000-00-00 00:00:00') AS atp_start,
			COALESCE(am.atp_end, '0000-00-00 00:00:00') AS atp_end,
      CASE WHEN am.heading IS NULL THEN 0.0 ELSE am.heading END AS heading,
      CASE WHEN am.speed IS NULL THEN 0.0 ELSE am.speed END AS speed,
      COALESCE(speed * 3.6, 0) AS speed_kmh,
      COALESCE(speed * 1, 0) AS speed_kn,
      COALESCE(speed * 0.51444, 0) AS speed_ms,
      COALESCE(speed * 1.15078, 0) AS speed_mph,
      CASE WHEN am.rpm1 IS NULL THEN 0 ELSE am.rpm1 END AS rpm1,
      CASE WHEN am.rpm2 IS NULL THEN 0 ELSE am.rpm2 END AS rpm2,
      am.sn AS sn,
      am.imei AS imei,
      am.powerstatus AS powerstatus,
      CASE 
        WHEN am.externalvoltage IS NULL THEN 0 
        ELSE am.externalvoltage
      END AS externalvoltage,
      mc.name AS kategori,
      mt.name AS type,
      c.customer_name AS custamer
    FROM 
      ai_kapal_member AS akm
      LEFT JOIN ai_mobile AS am ON am.id = akm.mobile_id
      LEFT JOIN ai_mobile_category AS mc ON mc.id = am.category_id
      LEFT JOIN ai_mobile_type AS mt ON mt.id = am.type_id
      LEFT JOIN ai_customer_data AS c ON c.id = am.customer
    WHERE 
      akm.member_id =?
      ORDER BY 
      am.timestamp DESC
    ''', [memberId]);

    print('search result: $results');

    List<Map<String, dynamic>> kapalMemberList = [];

    for (var row in results) {
      // DateTime originalTimestamp = DateTime.parse(row['timestamp']);
      // DateTime adjustedTimestamp;

      // switch (timezone) {
      //   case 'UTC':
      //     adjustedTimestamp = originalTimestamp.subtract(Duration(hours: 7));
      //     break;
      //   case 'UTC+7':
      //     adjustedTimestamp = originalTimestamp;
      //     break;
      //   case 'UTC+8':
      //     adjustedTimestamp = originalTimestamp.add(Duration(hours: 1));
      //     break;
      //   case 'UTC+9':
      //     adjustedTimestamp = originalTimestamp.add(Duration(hours: 2));
      //     break;
      //   default:
      //     adjustedTimestamp = originalTimestamp;
      // }

      DateTime timestamp = DateTime.parse(row['timestamp']);
      if (timezone == 'UTC') {
        timestamp = timestamp.subtract(Duration(hours: 7));
      } else if (timezone == 'UTC+8') {
        timestamp = timestamp.add(Duration(hours: 1));
      } else if (timezone == 'UTC+9') {
        timestamp = timestamp.add(Duration(hours: 2));
      }

      kapalMemberList.add({
        'id': row['id'],
        'member_id': row['member_id'],
        'idfull': row['idfull'],
        'nama_kapal': row['nama_kapal'],
        'lat': row['lat'],
        'lon': row['lon'],
        'kategori': row['kategori'],
        'type': row['type'],
        'custamer': row['custamer'],
        'mobile_id': row['mobile_id'],
        'sn': row['sn'],
        'imei': row['imei'],
        'externalvoltage': row['externalvoltage'],
        'powerstatus': row['powerstatus'],
        'heading': row['heading'],
        'speed': row['speed'],
        'speed_kmh': row['speed_kmh'],
        'speed_kn': row['speed_kn'],
        'speed_ms': row['speed_ms'],
        'speed_mph': row['speed_mph'],
        'rpm1': row['rpm1'],
        'rpm2': row['rpm2'],
        'create_at': row['create_at'],
        // 'timestamp': row['timestamp'],
        'timestamp': timestamp.toIso8601String(),
        'broadcast': row['broadcast'],
        'atp_start': row['atp_start'],
        'atp_end': row['atp_end'],
      });
    }

    await conn.close();

    return kapalMemberList;
  }

  // fungsi get data kapal(vessel) admin(geosat)
  Future<List<Map<String, dynamic>>?> getDataKapalGeosat() async {
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
        COALESCE(speed * 1.9438, 0) AS speed_kn,  
        CASE WHEN m.rpm1 IS NULL THEN 0 ELSE m.rpm1 END AS rpm1,
        CASE WHEN m.rpm2 IS NULL THEN 0 ELSE m.rpm2 END AS rpm2,
        m.powerstatus, 
				COALESCE(m.externalvoltage, 0) AS externalvoltage
      FROM 
        ai_mobile m
        LEFT JOIN ai_mobile_category mc ON m.category_id = mc.id
        LEFT JOIN ai_mobile_type mt ON m.type_id = mt.id
        LEFT JOIN ai_customer_data c ON m.customer = c.id
      WHERE 
        m.type_id IN (1, 2, 4, 5, 15)
      ORDER BY 
        tgl_aktifasi DESC
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
          'heading': row['heading'],
          'rpm1': row['rpm1'],
          'rpm2': row['rpm2'],
          'powerstatus': row['powerstatus'],
          'externalvoltage': row['externalvoltage'],
          'atp_start': row['atp_start'],
          'atp_end': row['atp_end'],
        });
      }
    }

    await conn.close();

    return dataKapalGeosatList;
  }

  // fungsi get data kapal(vessel) admin(apn)
  Future<List<Map<String, dynamic>>?> getDataKapalAPN() async {
    var settings = Connection.getSettingsAPN();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
      SELECT 
        ai_mobile_ais.id AS mobile_id,
        ai_mobile_category.name AS category_name,
        ai_mobile_type.name AS type_name,
        ai_mobile_ais.sn AS sn,
        ai_mobile_ais.imei AS imei,
        ai_customer_data.customer_name AS legal_name,
        ai_customer_data.phone AS telephone_pemilik,
        ai_mobile_ais.name AS vessel_name,
        ai_mobile_ais.description AS description,
        ai_mobile_ais.status AS status,
        ai_mobile_ais.timestamp AS timestamp,
        ai_mobile_ais.lat AS latitude,
        ai_mobile_ais.lon AS longitude,
        ai_mobile_ais.speed AS speed,
        ai_mobile_ais.heading AS heading,
        ai_mobile_ais.modemstatus AS modemstatus,
        ai_mobile_ais.emergency AS emergency,
        ai_mobile_ais.powerstatus AS powerstatus,
        ai_mobile_ais.externalvoltage AS externalvoltage,
        ai_mobile_ais.batteryhours AS battery_voltage,
        ai_mobile_ais.atp_start AS airtime_start_date,
        ai_mobile_ais.atp_end AS airtime_end_date,
        ai_mobile_ais.atp_notify AS atp_notify,
        ai_mobile_ais.regBy AS regBy,
        ai_mobile_ais.regDate AS register_date,
        ai_mobile_ais.isSold AS isSold,
        ai_mobile_ais.isSabotage AS isSabotage,
        ai_mobile_ais.isKKP AS isKKP,
        ai_mobile_ais.broken AS broken,
        ai_mobile_ais.foto AS foto,
        ai_mobile_ais.isCharging AS isCharging,
        ai_mobile_ais.idfull AS idfull,
        ai_mobile_ais.destination AS destination,
        ai_mobile_ais.eta AS eta,
        ai_ais_ship_type.type AS ship_type,
        ai_flag.country_name AS flag_country_name,
        SUBSTRING(ai_mobile_ais.distance, 1, 4) AS distance
      FROM 
        ai_mobile_ais
      LEFT JOIN 
        ai_mobile_category ON ai_mobile_category.id = ai_mobile_ais.category_id
      LEFT JOIN 
        ai_mobile_type ON ai_mobile_type.id = ai_mobile_ais.type_id
      LEFT JOIN 
        ai_customer_data ON ai_customer_data.id = ai_mobile_ais.customer
      LEFT JOIN 
        ai_ais_ship_type ON ai_ais_ship_type.id = ai_mobile_ais.ship_type
      LEFT JOIN 
        ai_flag ON SUBSTR(ai_mobile_ais.id, 1, 3) = ai_flag.mid
      WHERE 
        ai_mobile_ais.timestamp >= DATE_SUB(NOW(), INTERVAL 1 WEEK) AND 
        ai_mobile_ais.type_id IN (13, 14, 15, 16)
      ORDER BY 
        ai_mobile_ais.timestamp DESC;
    ''');

    List<Map<String, dynamic>> dataKapalAPNList = [];

    if (results.isNotEmpty) {
      for (var row in results) {
        dataKapalAPNList.add({
          'mobile_id': row['mobile_id'],
          'category_name': row['category_name'],
          'type_name': row['type_name'],
          'sn': row['sn'],
          'imei': row['imei'],
          'legal_name': row['legal_name'],
          'telephone_pemilik': row['telephone_pemilik'],
          'vessel_name': row['vessel_name'],
          'description': row['description'],
          'status': row['status'],
          'timestamp': row['timestamp'],
          'latitude': row['latitude'],
          'longitude': row['longitude'],
          'speed': row['speed'],
          'heading': row['heading'],
          'modemstatus': row['modemstatus'],
          'emergency': row['emergency'],
          'powerstatus': row['powerstatus'],
          'externalvoltage': row['externalvoltage'],
          'battery_voltage': row['battery_voltage'],
          'airtime_start_date': row['airtime_start_date'],
          'airtime_end_date': row['airtime_end_date'],
          'atp_notify': row['atp_notify'],
          'regBy': row['regBy'],
          'register_date': row['register_date'],
          'isSold': row['isSold'],
          'isSabotage': row['isSabotage'],
          'isKKP': row['isKKP'],
          'broken': row['broken'],
          'foto': row['foto'],
          'isCharging': row['isCharging'],
          'idfull': row['idfull'],
          'destination': row['destination'],
          'eta': row['eta'],
          'ship_type': row['ship_type'],
          'flag_country_name': row['flag_country_name'],
          'distance': row['distance'],
        });
      }
    }

    await conn.close();

    return dataKapalAPNList;
  }

  // fungsi get list data airtime kapal(vessel)
  Future<List<Map<String, dynamic>>?> getAirtimeKapal(String idfull) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      atd.id AS id,
      atd.airtimestart AS airtime_start,
      atd.airtimeend AS airtime_end
    FROM 
      ai_trans_detail AS atd
      LEFT JOIN ai_mobile AS am ON am.idfull = atd.deviceid
    WHERE 
      atd.deviceid =?
    ORDER BY atd.airtimestart DESC
    ''', [idfull]);

    List<Map<String, dynamic>> dataAirtimeKapal = [];

    if (results.isNotEmpty) {
      for (var row in results) {
        dataAirtimeKapal.add({
          'id': row['id'] ?? '',
          'airtime_start': row['airtime_start'] ?? '',
          'airtime_end': row['airtime_end'] ?? '',
        });
      }
    }

    await conn.close();

    return dataAirtimeKapal;
  }

  // fungsi get list data history traking kapal(vessel)
  Future<List<Map<String, dynamic>>?> getHistoryTrakingKapal(
      String mobileId, int limit, DateTime? fromDate) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    String query = '';
    List<dynamic> params = [mobileId];

    if (fromDate != null) {
      query = '''
      SELECT
        varTimestamp AS timestamp,
        msgTimestamp_GMT AS broadcast,
        Latitude AS latitude,
        Longitude AS longitude,
        Speed AS speed,
        (Speed * 3.6) AS speed_kmh,
        (Speed * 1.9438) AS speed_kn,
        Direction AS heading
      FROM
        psg_modata
      WHERE
        serviceID =?
        AND varTimestamp IS NOT NULL
        AND Speed IS NOT NULL
        AND Direction IS NOT NULL
        AND varTimestamp >= ?
      ORDER BY
        VAR_MOID DESC
      ''';
      params.add(fromDate.toIso8601String());
    } else {
      query = '''
      SELECT
        varTimestamp AS timestamp,
        msgTimestamp_GMT AS broadcast,
        Latitude AS latitude,
        Longitude AS longitude,
        Speed AS speed,
        (Speed * 3.6) AS speed_kmh,
        (Speed * 1.9438) AS speed_kn,
        Direction AS heading
      FROM
        psg_modata
      WHERE
        serviceID =?
        AND varTimestamp IS NOT NULL
        AND Speed IS NOT NULL
        AND Direction IS NOT NULL
      ORDER BY
        VAR_MOID DESC
      LIMIT ?
      ''';
      params.add(limit);
    }

    var results = await conn.query(query, params);

    List<Map<String, dynamic>> dataHistoryTrakingKapal = [];

    if (results.isNotEmpty) {
      for (var row in results) {
        dataHistoryTrakingKapal.add({
          'timestamp': row['timestamp'] ?? '',
          'broadcast': row['broadcast'] ?? '',
          'latitude': row['latitude'] ?? '',
          'longitude': row['longitude'] ?? '',
          'speed': row['speed'] ?? '',
          'speed_kmh': row['speed_kmh'] ?? '',
          'speed_kn': row['speed_kn'] ?? '',
          'heading': row['heading'] ?? '',
        });
      }
    }

    await conn.close();

    return dataHistoryTrakingKapal;
  }

  // fungsi cari kapal berdasarkan mobile_id
  Future<Map<String, dynamic>?> searchDataKapal(String mobileId) async {
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
        COALESCE(m.timestamp, '0000-00-00 00:00:00') AS received,
        COALESCE(m.msgTimestamp_GMT, m.timestamp, '0000-00-00 00:00:00') AS broadcast,
				COALESCE(NULLIF(m.lat, ''), 0) AS lat,
				COALESCE(NULLIF(m.lon, ''), 0) AS lon,
				COALESCE(m.heading, 0) AS heading,
				COALESCE(m.speed, 0) AS speed, 
        COALESCE(speed * 3.6, 0) AS speed_kmh,
        COALESCE(speed * 1.9438, 0) AS speed_kn,
        m.powerstatus, 
				COALESCE(m.externalvoltage, 0) AS externalvoltage,
        m.atp_start, 
        m.atp_end
      FROM 
        ai_mobile m
        LEFT JOIN ai_mobile_category mc ON m.category_id = mc.id
        LEFT JOIN ai_mobile_type mt ON m.type_id = mt.id
        LEFT JOIN ai_customer_data c ON m.customer = c.id
      WHERE 
      m.id =?
    ''', [mobileId]);

    print('result: $results');

    Map<String, dynamic>? dataKapal;

    if (results.isNotEmpty) {
      var row = results.first;

      dataKapal = {
        'id': row['id'],
        'idfull': row['idfull'],
        'sn': row['sn'],
        'imei': row['imei'],
        'nama_kapal': row['nama_kapal'],
        'kategori': row['kategori'],
        'type': row['type'],
        'custamer': row['custamer'],
        'received': row['received'],
        'broadcast': row['broadcast'],
        'lat': row['lat'],
        'lon': row['lon'],
        'heading': row['heading'],
        'speed': row['speed'],
        'speed_kmh': row['speed_kmh'],
        'speed_kn': row['speed_kn'],
        'powerstatus': row['powerstatus'],
        'externalvoltage': row['externalvoltage'],
        'atp_start': row['atp_start'],
        'atp_end': row['atp_end'],
      };
    }

    await conn.close();

    return dataKapal;
  }

  // // fungsi hitung jarak tempuh histori traking kapal
  // Future<List<Map<String, dynamic>>?> getJarakTempuhHistoryTraking(
  //     String mobileId, DateTime? startDate, DateTime? endDate) async {
  //   var settings = Connection.getSettings();
  //   var conn = await MySqlConnection.connect(settings);

  //   DateTime startDateTime = DateTime(
  //     startDate!.year,
  //     startDate.month,
  //     startDate.day,
  //     0,
  //     0,
  //     0,
  //   );

  //   DateTime endDateTime = DateTime(
  //     endDate!.year,
  //     endDate.month,
  //     endDate.day,
  //     23,
  //     59,
  //     59,
  //   );

  //   String formattedStartDate =
  //       DateFormat('yyyy-MM-dd HH:mm:ss').format(startDateTime);
  //   String formattedEndDate =
  //       DateFormat('yyyy-MM-dd HH:mm:ss').format(endDateTime);

  //   String query = '''
  //   WITH DailyData AS (
  //     SELECT
  //         DATE(varTimestamp) AS tgl_aktifasi,
  //         Latitude AS latitude,
  //         Longitude AS longitude,
  //         Speed AS speed,
  //         varTimestamp,
  //         ROW_NUMBER() OVER (PARTITION BY DATE(varTimestamp) ORDER BY varTimestamp ASC) AS row_num_first,
  //         ROW_NUMBER() OVER (PARTITION BY DATE(varTimestamp) ORDER BY varTimestamp DESC) AS row_num_last
  //     FROM
  //         psg_modata
  //     WHERE
  //         serviceID = ?
  //         AND varTimestamp BETWEEN ? AND ?
  //         AND Speed IS NOT NULL
  //   ),
  //   BoundaryData AS (
  //       SELECT
  //           tgl_aktifasi,
  //           MAX(CASE WHEN row_num_first = 1 THEN varTimestamp END) AS waktu_awal,
  //           MAX(CASE WHEN row_num_last = 1 THEN varTimestamp END) AS waktu_akhir,
  //           MAX(CASE WHEN row_num_first = 1 THEN latitude END) AS start_latitude,
  //           MAX(CASE WHEN row_num_first = 1 THEN longitude END) AS start_longitude,
  //           MAX(CASE WHEN row_num_last = 1 THEN latitude END) AS end_latitude,
  //           MAX(CASE WHEN row_num_last = 1 THEN longitude END) AS end_longitude
  //       FROM
  //           DailyData
  //       GROUP BY
  //           tgl_aktifasi
  //   ),
  //   DailyAverageSpeed AS (
  //       SELECT
  //           tgl_aktifasi,
  //           AVG(Speed) * 1.9438 AS average_speed_knots,
  //           MAX(Speed) * 1.9438 AS high_speed_knots,
  //           MIN(Speed) * 1.9438 AS low_speed_knots
  //       FROM
  //           DailyData
  //       GROUP BY
  //           tgl_aktifasi
  //   )
  //   SELECT
  //       bd.tgl_aktifasi,
  //       bd.waktu_awal,
  //       bd.waktu_akhir,
  //       CONCAT(
  //           TIMESTAMPDIFF(HOUR, bd.waktu_awal, bd.waktu_akhir), ' jam ',
  //           MOD(TIMESTAMPDIFF(MINUTE, bd.waktu_awal, bd.waktu_akhir), 60), ' menit'
  //       ) AS duration,
  //       bd.start_latitude,
  //       bd.start_longitude,
  //       bd.end_latitude,
  //       bd.end_longitude,
  //       ROUND(das.average_speed_knots, 1) AS average_speed_knots,
  //       ROUND(das.high_speed_knots, 1) AS high_speed_knots,
  //       ROUND(das.low_speed_knots, 1) AS low_speed_knots
  //   FROM
  //       BoundaryData bd
  //   JOIN
  //       DailyAverageSpeed das ON bd.tgl_aktifasi = das.tgl_aktifasi
  //   ORDER BY
  //       bd.tgl_aktifasi ASC;
  // ''';

  //   //   String query = '''
  //   //   WITH DailyData AS (
  //   //       SELECT
  //   //           DATE(varTimestamp) AS tgl_aktifasi,
  //   //           Latitude AS latitude,
  //   //           Longitude AS longitude,
  //   //           Speed AS speed,
  //   //           varTimestamp,
  //   //           ROW_NUMBER() OVER (PARTITION BY DATE(varTimestamp) ORDER BY varTimestamp ASC) AS row_num_first,
  //   //           ROW_NUMBER() OVER (PARTITION BY DATE(varTimestamp) ORDER BY varTimestamp DESC) AS row_num_last
  //   //       FROM
  //   //           psg_modata
  //   //       WHERE
  //   //           serviceID = ?
  //   //           AND varTimestamp BETWEEN ? AND ?
  //   //           AND Speed IS NOT NULL
  //   //   ),
  //   //   FirstData AS (
  //   //       SELECT
  //   //           tgl_aktifasi,
  //   //           latitude,
  //   //           longitude,
  //   //           varTimestamp AS waktu_awal,
  //   //           row_num_first
  //   //       FROM
  //   //           DailyData
  //   //       WHERE
  //   //           row_num_first = 1
  //   //   ),
  //   //   LastData AS (
  //   //       SELECT
  //   //           tgl_aktifasi,
  //   //           latitude,
  //   //           longitude,
  //   //           varTimestamp AS waktu_akhir,
  //   //           row_num_last
  //   //       FROM
  //   //           DailyData
  //   //       WHERE
  //   //           row_num_last = 1
  //   //   ),
  //   //   DailyAverageSpeed AS (
  //   //       SELECT
  //   //           tgl_aktifasi,
  //   //           AVG(Speed) AS average_speed,
  //   //           MAX(Speed) AS high_speed,
  //   //           MIN(Speed) AS low_speed
  //   //       FROM
  //   //           DailyData
  //   //       WHERE
  //   //           Speed IS NOT NULL
  //   //       GROUP BY
  //   //           tgl_aktifasi
  //   //   )
  //   //   SELECT
  //   //       fd.tgl_aktifasi,
  //   //       fd.waktu_awal,
  //   //       ld.waktu_akhir,
  //   //       CONCAT(
  //   //           TIMESTAMPDIFF(HOUR, fd.waktu_awal, ld.waktu_akhir), ' jam ',
  //   //           MOD(TIMESTAMPDIFF(MINUTE, fd.waktu_awal, ld.waktu_akhir), 60), ' menit'
  //   //       ) AS duration,
  //   //       fd.latitude AS start_latitude,
  //   //       fd.longitude AS start_longitude,
  //   //       ld.latitude AS end_latitude,
  //   //       ld.longitude AS end_longitude,
  //   //       ROUND(das.average_speed * 1.9438, 1) AS average_speed_knots,
  //   //       ROUND(das.high_speed * 1.9438, 1) AS high_speed_knots,
  //   //       ROUND(das.low_speed * 1.9438, 1) AS low_speed_knots
  //   //   FROM
  //   //       FirstData fd
  //   //   JOIN
  //   //       LastData ld ON fd.tgl_aktifasi = ld.tgl_aktifasi
  //   //   JOIN
  //   //       DailyAverageSpeed das ON fd.tgl_aktifasi = das.tgl_aktifasi
  //   //   ORDER BY
  //   //       fd.tgl_aktifasi ASC;
  //   // ''';

  //   List<dynamic> params = [
  //     mobileId,
  //     formattedStartDate,
  //     formattedEndDate,
  //   ];

  //   var results = await conn.query(query, params);

  //   List<Map<String, dynamic>> jarakTempuhHistoryTraking = [];

  //   if (results.isNotEmpty) {
  //     for (var row in results) {
  //       jarakTempuhHistoryTraking.add({
  //         'tgl_aktifasi': row['tgl_aktifasi'] ?? '',
  //         'waktu_awal': row['waktu_awal'] ?? '',
  //         'waktu_akhir': row['waktu_akhir'] ?? '',
  //         'duration': row['duration'] ?? '',
  //         'start_latitude': row['start_latitude'] ?? '',
  //         'start_longitude': row['start_longitude'] ?? '',
  //         'end_latitude': row['end_latitude'] ?? '',
  //         'end_longitude': row['end_longitude'] ?? '',
  //         'average_speed_knots': row['average_speed_knots'] ?? '',
  //         'high_speed_knots': row['high_speed_knots'] ?? '',
  //         'low_speed_knots': row['low_speed_knots'] ?? '',
  //       });
  //     }
  //   }

  //   await conn.close();

  //   return jarakTempuhHistoryTraking;
  // }

  // fungsi hitung jarak tempuh untuk setiap jarak traking kapal
  Future<List<Map<String, dynamic>>?> calcMileageTrakingVessel(
      String mobileId, DateTime? startDate, DateTime? endDate) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    DateTime startDateTime = DateTime(
      startDate!.year,
      startDate.month,
      startDate.day,
      0,
      0,
      0,
    );

    DateTime endDateTime = DateTime(
      endDate!.year,
      endDate.month,
      endDate.day,
      23,
      59,
      59,
    );

    String formattedStartDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(startDateTime);
    String formattedEndDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(endDateTime);

    String query = '''
      SELECT
        varTimestamp AS received,
        msgTimestamp_GMT AS broadcast,
        Latitude AS latitude,
        Longitude AS longitude,
        (Speed * 1.9438) AS speed_kn,
        Direction AS heading
      FROM
        psg_modata
      WHERE
        serviceID = ?
        AND varTimestamp IS NOT NULL
        AND Speed IS NOT NULL
        AND Direction IS NOT NULL
        AND varTimestamp BETWEEN ? AND ?
      ORDER BY
        VAR_MOID DESC;
  ''';

    List<dynamic> params = [
      mobileId,
      formattedStartDate,
      formattedEndDate,
    ];

    var results = await conn.query(query, params);

    List<Map<String, dynamic>> calcMileageTraking = [];

    if (results.isNotEmpty) {
      for (var row in results) {
        calcMileageTraking.add({
          'received': row['received'] ?? '',
          'broadcast': row['broadcast'] ?? '',
          'latitude': row['latitude'] ?? '',
          'longitude': row['longitude'] ?? '',
          'speed_kn': row['speed_kn'] ?? '',
          'heading': row['heading'] ?? '',
        });
      }
    }

    await conn.close();

    return calcMileageTraking;
  }

  // Future<int> countDataKapal() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int cachedCount = prefs.getInt('kapal_count') ?? -1;

  //   if (cachedCount != -1) {
  //     return cachedCount;
  //   }

  //   MemberUser? currentUser = await _authService.getCurrentUser();
  //   int memberId = currentUser?.id ?? 0;
  //   int adminLevel = currentUser?.isAdmin ?? 0;

  //   print('Current User ID: $memberId, Admin Level: $adminLevel');

  //   var settings = Connection.getSettings();
  //   var conn = await MySqlConnection.connect(settings);
  //   int count = 0;

  //   if (adminLevel == 0) {
  //     var result = await conn.query('''
  //     SELECT COUNT(*) AS count
  //     FROM ai_kapal_member
  //     WHERE member_id = ?
  //   ''', [memberId]);

  //     count = result.first['count'] as int;
  //   } else if (adminLevel == 1) {
  //     var result = await conn.query('''
  //     SELECT COUNT(*) AS count
  //     FROM ai_mobile
  //     WHERE type_id IN (1, 2, 4, 5, 15)
  //   ''');

  //     count = result.first['count'] as int;
  //   }

  //   await conn.close();
  //   await prefs.setInt('kapal_count', count);

  //   return count;
  // }

  Future<int> countDataKapal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int cachedCount = prefs.getInt('kapal_count') ?? -1;
    String? lastUpdateStr = prefs.getString('last_update_kapal_count');
    DateTime? lastUpdate =
        lastUpdateStr != null ? DateTime.parse(lastUpdateStr) : null;
    DateTime currentDate = DateTime.now();

    // Check if we should update the count (i.e., more than a month since the last update)
    if (cachedCount != -1 &&
        lastUpdate != null &&
        currentDate.difference(lastUpdate).inDays < 30) {
      return cachedCount;
    }

    // Fetch current user info
    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;
    int adminLevel = currentUser?.isAdmin ?? 0;
    print('Current User ID: $memberId, Admin Level: $adminLevel');

    // Fetch data from the database
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    int count = 0;

    if (adminLevel == 0) {
      var result = await conn.query('''
      SELECT COUNT(*) AS count 
      FROM ai_kapal_member 
      WHERE member_id = ?
    ''', [memberId]);
      count = result.first['count'] as int;
    } else if (adminLevel == 1) {
      var result = await conn.query('''
      SELECT COUNT(*) AS count 
      FROM ai_mobile 
      WHERE type_id IN (1, 2, 4, 5, 15)
    ''');
      count = result.first['count'] as int;
    }

    await conn.close();

    // Update cache with new count and timestamp
    await prefs.setInt('kapal_count', count);
    await prefs.setString(
        'last_update_kapal_count', currentDate.toIso8601String());

    return count;
  }

// calc airtime yg active
  // Future<int> countActiveAirtime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int cachedCount = prefs.getInt('active_airtime_count') ?? -1;
  //   String? lastUpdate = prefs.getString('last_update_airtime_count');

  //   DateTime now = DateTime.now();
  //   DateTime lastUpdateDate = lastUpdate != null
  //       ? DateTime.parse(lastUpdate)
  //       : now.subtract(Duration(days: 31));

  //   // untuk pengecekan apakah airtime active atau tidak dia mengecek perbulan sekali
  //   bool isCacheValid =
  //       cachedCount != -1 && now.difference(lastUpdateDate).inDays < 30;

  //   if (isCacheValid) {
  //     return cachedCount;
  //   }

  //   MemberUser? currentUser = await _authService.getCurrentUser();
  //   int memberId = currentUser?.id ?? 0;
  //   int adminLevel = currentUser?.isAdmin ?? 0;

  //   print('Current User ID: $memberId, Admin Level: $adminLevel');

  //   var settings = Connection.getSettings();
  //   var conn = await MySqlConnection.connect(settings);
  //   int count = 0;

  //   String currentDate = now.toIso8601String().split('T').first;

  //   if (adminLevel == 0) {
  //     var result = await conn.query('''
  //     SELECT COUNT(*) AS count
  //     FROM ai_mobile am
  //     INNER JOIN ai_kapal_member akm ON am.id = akm.mobile_id
  //     WHERE am.atp_end > ?
  //       AND akm.member_id = ?
  //   ''', [currentDate, memberId]);

  //     count = result.first['count'] as int;
  //   } else if (adminLevel == 1) {
  //     var result = await conn.query('''
  //     SELECT COUNT(*) AS count
  //     FROM ai_mobile
  //     WHERE atp_end > ?
  //   ''', [currentDate]);

  //     count = result.first['count'] as int;
  //   }

  //   await conn.close();

  //   await prefs.setInt('active_airtime_count', count);
  //   await prefs.setString('last_update_airtime_count', now.toIso8601String());

  //   return count;
  // }

  Future<int> countActiveAirtime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve cached count, last update date, and cached user ID
    int cachedCount = prefs.getInt('active_airtime_count') ?? -1;
    String? lastUpdate = prefs.getString('last_update_airtime_count');
    int cachedUserId = prefs.getInt('cached_user_id') ?? -1;

    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;
    int adminLevel = currentUser?.isAdmin ?? 0;

    DateTime now = DateTime.now();
    DateTime lastUpdateDate = lastUpdate != null
        ? DateTime.parse(lastUpdate)
        : now.subtract(Duration(days: 31));

    // Validate cache by checking user ID and update time (within 30 days)
    bool isCacheValid = cachedCount != -1 &&
        cachedUserId == memberId &&
        now.difference(lastUpdateDate).inDays < 30;

    if (isCacheValid) {
      return cachedCount; // Return cached count if it's valid
    }

    print('Current User ID: $memberId, Admin Level: $adminLevel');

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    int count = 0;

    // Get the current date in the required format (YYYY-MM-DD)
    String currentDate = now.toIso8601String().split('T').first;

    if (adminLevel == 0) {
      // Count with JOIN for non-admin users (adminLevel 0)
      var result = await conn.query('''
      SELECT COUNT(*) AS count
      FROM ai_mobile am
      INNER JOIN ai_kapal_member akm ON am.id = akm.mobile_id
      WHERE am.atp_end > ?
        AND akm.member_id = ?
    ''', [currentDate, memberId]);

      count = result.first['count'] as int;
    } else if (adminLevel == 1) {
      // Direct count from ai_mobile for admin users (adminLevel 1)
      var result = await conn.query('''
      SELECT COUNT(*) AS count
      FROM ai_mobile 
      WHERE atp_end > ?
    ''', [currentDate]);

      count = result.first['count'] as int;
    }

    await conn.close();

    // Update cache with new count, timestamp, and user ID
    await prefs.setInt('active_airtime_count', count);
    await prefs.setString('last_update_airtime_count', now.toIso8601String());
    await prefs.setInt('cached_user_id', memberId);

    return count;
  }

  Future<void> resetCountCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('active_airtime_count');
    await prefs.remove('last_update_airtime_count');
    await prefs.remove('kapal_count');
    await prefs.remove('last_update_kapal_count');
    await prefs.remove('cached_user_id');
  }
}
