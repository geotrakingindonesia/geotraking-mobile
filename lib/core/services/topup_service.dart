import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';

class TopupService {
  // fungsi get data topup
  Future<List<Map<String, dynamic>>?> getDataTopUp({int? typeSatelit, int? jenisSatelit}) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var query = '''
    SELECT 
      id, 
      nama_paket, 
      COALESCE(kuota, '-') AS kuota,
      COALESCE(masa_aktif, '-') AS masa_aktif,
      COALESCE(harga, '-') AS harga,
      type_satelit, 
      jenis_satelit 
    FROM ai_topup
    ''';
    
    if (typeSatelit != null) {
      query += ' WHERE type_satelit = $typeSatelit';
    }

    if (jenisSatelit != null) {
      query += typeSatelit != null ? ' AND' : ' WHERE';
      query += ' jenis_satelit = $jenisSatelit';
    }

    var results = await conn.query(query);
    print('ini results ${results}');
    List<Map<String, dynamic>> dataTopUpList = [];

    for (var row in results) {
      dataTopUpList.add({
        'id': row['id'],
        'nama_paket': row['nama_paket'],
        'kuota': row['kuota'],
        'masa_aktif': row['masa_aktif'],
        'harga': row['harga'],
        'type_satelit': row['type_satelit'],
        'jenis_satelit': row['jenis_satelit'],
      });
    }

    await conn.close();
    return dataTopUpList;
  }
}
