// import 'package:geotraking/core/services/connection/connection.dart';
// import 'package:mysql1/mysql1.dart';

// class VmsMonitoringService {
//   Future<Map<String, dynamic>?> index(String searchValue) async {
//     var settings = Connection.getSettings();
//     var conn = await MySqlConnection.connect(settings);

//     var results = await conn.query('''
//     SELECT
//       code,
//       senddate,
//       mobileid,
//       eureport,
//       messageid,
//       confirmcode
//     FROM
//       ai_eureport_new
//     WHERE
//       mobileid = ?
//       OR eureport = ?
//       OR messageid = ?
//       OR confirmcode = ?
//     ORDER BY senddate DESC
//     LIMIT 1
//   ''', [searchValue, searchValue, searchValue, searchValue]);

//     print('Query results: ${results.length} rows found.');

//     Map<String, dynamic>? dataEureport;
//     if (results.isNotEmpty) {
//       var row = results.first;

//       dataEureport = {
//         'code': row['code'] ?? '',
//         'sendDate': row['senddate'] ?? '',
//         'mobileId': row['mobileid'] ?? '',
//         'eureport': row['eureport'] ?? '',
//         'messageId': row['messageid'] ?? '',
//         'confirmCode': row['confirmcode'] ?? '',
//       };
//     }

//     await conn.close();
//     return dataEureport;
//   }
// }

import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';

class VmsMonitoringService {
  Future<Map<String, dynamic>?> index(String searchValue) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    String query = '''
    SELECT 
      code,
      senddate,
      mobileid,
      eureport,
      messageid,
      confirmcode
    FROM 
      ai_eureport_new
    WHERE 
      mobileid = ? 
      OR messageid = ? 
      OR confirmcode = ?
    ORDER BY senddate DESC
    LIMIT 1
  ''';

    List<String> params = [searchValue, searchValue, searchValue];

    var results = await conn.query(query, params);

    print('Query results: ${results.length} rows found.');

    // Ambil hasil pertama jika data ditemukan
    Map<String, dynamic>? dataEureport;
    if (results.isNotEmpty) {
      var row = results.first;

      dataEureport = {
        'code': row['code'] ?? '',
        'sendDate': row['senddate'] ?? '',
        'mobileId': row['mobileid'] ?? '',
        'eureport': row['eureport'] ?? '',
        'messageId': row['messageid'] ?? '',
        'confirmCode': row['confirmcode'] ?? '',
      };
    }

    await conn.close();
    return dataEureport;
  }
}
