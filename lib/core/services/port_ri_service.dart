// import 'dart:convert';
import 'dart:convert';

import 'package:geotraking/core/models/port_ri.dart';
import 'package:geotraking/core/models/port_ri_detail.dart';
import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortPelabuhanService {
  // fungsi get data port pelabuhan ri
  Future<List<PortPelabuhan>> getDataPortPelabuhan() async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('select * from ai_port_detail');

    List<PortPelabuhan> portPelabuhanList = [];

    for (var row in results) {
      PortPelabuhan portPelabuhan = PortPelabuhan(
        namaPelabuhan: row['nama'],
        kodePelabuhan: row['kd_pelabuhan'],
        lat: double.parse(row['lat']),
        lon: double.parse(row['lon']),
      );
      portPelabuhanList.add(portPelabuhan);
    }

    await conn.close();

    return portPelabuhanList;
  }

  // fungsi get detail data port pelabuhan ri
  Future<PortRi?> getDetailDataPortPelabuhan(String kodePelabuhan) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query(
        'select * from ai_port_ri where kd_pelabuhan =?', [kodePelabuhan]);

    PortRi? portDetailPelabuhan;

    if (results.isNotEmpty) {
      var row = results.first;
      portDetailPelabuhan = PortRi(
        kodePelabuhan: row['kd_pelabuhan'].toString(),
        namaPelabuhan: row['nama_pelabuhan'].toString(),
        lokasiPelabuhan: row['lokasi_pelabuhan'].toString(),
        unitKerja: row['unit_kerja'].toString(),
        alamatKantor: row['alamat_kantor'].toString(),
      );
    }

    await conn.close();

    return portDetailPelabuhan;
  }

  Future<List<PortPelabuhan>> getCachedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString('portPelabuhanList');

    if (cachedData != null) {
      List<dynamic> jsonList = json.decode(cachedData);
      print('ini pake json list ${jsonList}');
      return jsonList.map((json) => PortPelabuhan.fromJson(json)).toList();
    } else {
      List<PortPelabuhan> portPelabuhanList = await getDataPortPelabuhan();
      String jsonData =
          json.encode(portPelabuhanList.map((p) => p.toJson()).toList());
      print('ini pake json data ${jsonData}');
      prefs.setString('portPelabuhanList', jsonData);
      return portPelabuhanList;
    }
  }
}
