// ignore_for_file: prefer_final_fields
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/models/transaction_airtime.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';

class TransactionAirtimeService {
  AuthService _authService = AuthService();

  Future<List<TransactionAirtime>> getProcessCategoryTransactionAirtime() async {
    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;

    print('Current User ID: $memberId');

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      ata.id AS id,
      ata.member_id AS member_id,
      ata.mobile_id AS mobile_id,
      ata.price AS price,
      ata.payment_date AS payment_date,
      ata.status AS status,
      am.idfull AS idfull,
      am.name AS nama_kapal,
      mc.name AS kategori,
      mt.name AS type,
      c.customer_name AS custamer
    FROM 
      ai_transaction_airtime AS ata
      LEFT JOIN ai_mobile AS am ON am.id = ata.mobile_id
      LEFT JOIN ai_mobile_category AS mc ON mc.id = am.category_id
      LEFT JOIN ai_mobile_type AS mt ON mt.id = am.type_id
      LEFT JOIN ai_customer_data AS c ON c.id = am.customer
    WHERE 
      ata.member_id =? AND ata.status = 0
    ORDER BY 
      ata.payment_date DESC
    ''', [memberId]);

    print('status transaction airtime : $results');

    List<TransactionAirtime> transactionAirtimeList = [];

    for (var row in results) {
      TransactionAirtime transactionAirtime = TransactionAirtime(
        id: row['id'],
        memberId: row['member_id'],
        mobileId: row['mobile_id'],
        price: row['price'],
        paymentDate: row['payment_date'] as DateTime?,
        status: row['status'],
        idfull: row['idfull'],
        namaKapal: row['nama_kapal'],
        kategori: row['kategori'],
        type: row['type'],
        custamer: row['custamer'],
      );
      transactionAirtimeList.add(transactionAirtime);
    }

    await conn.close();

    return transactionAirtimeList;
  }
}
