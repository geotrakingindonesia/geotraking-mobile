// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:geotraking/core/models/wpp.dart';
import 'package:geotraking/core/models/wpp_latlon.dart';
import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WppRiService {

  // Fungsi get data wpp ri
  Future<List<WppRi>> getDataWpp() async {
    var settings = Connection.getConnect();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('select * from ai_wpp');

    List<WppRi> wppList = [];

    for (var row in results) {
      WppRi wppRi = WppRi(
        id: row['id'],
        namaWpp: row['name'],
        keterangan: row['keterangan'],
      );
      wppList.add(wppRi);
    }

    await conn.close();

    return wppList;
  }

  // Fungsi get data zona wpp
  Future<List<WppLatLong>> getDetailDataWpp(int wppId) async {
    var settings = Connection.getConnect();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn
        .query('select * from ai_wpp_detail where wpp_id =?', [wppId]);

    List<WppLatLong> wppRiDetails = [];

    for (var row in results) {
      WppLatLong wppRiDetail = WppLatLong(
        id: row['id'],
        wppId: row['wpp_id'],
        lat: double.parse(row['lat']),
        lon: double.parse(row['lon']),
      );
      wppRiDetails.add(wppRiDetail);
    }

    await conn.close();

    return wppRiDetails;
  }

  // Fungsi get data seluruh zona wpp
  Future<List<WppLatLong>> getAllZoneWpp() async {
    List<Future<List<WppLatLong>>> futures = [];

    for (int i = 1; i <= 11; i++) {
      futures.add(getDetailDataWpp(i));
    }

    List<List<WppLatLong>> results = await Future.wait(futures);
    return results.expand((element) => element).toList();
  }

  // Fungsi untuk load dan cache data WPP dan Zona WPP
  Future<Map<String, dynamic>> loadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedWppList = prefs.getString('wppList');
    final cachedZoneWpp = prefs.getString('zoneWpp');
    List<WppRi> wppList = [];
    List<WppLatLong?> allZoneWpp = [];

    if (cachedWppList != null) {
      final List<dynamic> jsonData = jsonDecode(cachedWppList);
      wppList = jsonData.map((data) => WppRi.fromJson(data)).toList();
    } else {
      wppList = await getDataWpp();
      final jsonData =
          jsonEncode(wppList.map((item) => item.toJson()).toList());
      await prefs.setString('wppList', jsonData);
    }

    if (cachedZoneWpp != null) {
      final List<dynamic> jsonData = jsonDecode(cachedZoneWpp);
      allZoneWpp = jsonData.map((item) => WppLatLong.fromJson(item)).toList();
      print('ini pake json list ${jsonData}');
    } else {
      allZoneWpp = await getAllZoneWpp();
      final jsonData =
          jsonEncode(allZoneWpp.map((item) => item?.toJson()).toList());
      print('ini pake json data ${jsonData}');
      await prefs.setString('zoneWpp', jsonData);
    }
    return {
      'wppList': wppList,
      'zoneWpp': allZoneWpp,
    };
  }
}
