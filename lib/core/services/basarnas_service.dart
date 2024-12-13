import 'dart:convert';

import 'package:geotraking/core/models/basarnas.dart';
import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasarnasService {
  // Fungsi get data basarnas dari table ai_basarnas
  Future<List<Basarnas>> getDataBasarnas() async {
    var settings = Connection.getConnect();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('select * from ai_basarnas');

    List<Basarnas> basarnasList = [];

    for (var row in results) {
      Basarnas basarnas = Basarnas(
        id: row['id'],
        namaBasarnas: row['nama'],
        tipe: row['tipe'],
        lat: double.parse(row['lat']),
        lon: double.parse(row['lon']),
      );
      basarnasList.add(basarnas);
    }

    await conn.close();

    return basarnasList;
  }
  // Fungsi cache get data basarnas dari local storage dengan SharedPreferences ketika sudah pernah akses sekali di awal
  Future<List<Basarnas>> getCachedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString('basarnasData');

    if (cachedData != null) {
      List<dynamic> jsonList = json.decode(cachedData);
      print('ini pake json list ${jsonList}');
      return jsonList.map((json) => Basarnas.fromJson(json)).toList();
    } else {
      List<Basarnas> basarnasList = await getDataBasarnas();
      String jsonData =
          json.encode(basarnasList.map((b) => b.toJson()).toList());
      print('ini pake json data ${jsonData}');
      prefs.setString('basarnasData', jsonData);
      return basarnasList;
    }
  }
}
