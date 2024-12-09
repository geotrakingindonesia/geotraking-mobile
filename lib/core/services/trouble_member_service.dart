// ignore_for_file: prefer_final_fields
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/models/trouble_all_member.dart';
import 'package:geotraking/core/models/trouble_member.dart';
import 'package:geotraking/core/models/trouble_member_detail.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';

class TroubleMemberService {
  AuthService _authService = AuthService();

  Future<List<TroubleMember>> getProcessTroubleData() async {
    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;

    print('Current User ID: $memberId');

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      atm.id AS id,
      atm.member_id AS member_id,
      atm.mobile_id AS mobile_id,
      atm.keluhan AS keluhan,
      atm.create_at AS create_at,
      atm.status AS status,
      am.idfull AS idfull,
      am.name AS nama_kapal,
      mc.name AS kategori,
      mt.name AS type,
      c.customer_name AS custamer
    FROM 
      ai_trouble_member AS atm
      LEFT JOIN ai_mobile AS am ON am.id = atm.mobile_id
      LEFT JOIN ai_mobile_category AS mc ON mc.id = am.category_id
      LEFT JOIN ai_mobile_type AS mt ON mt.id = am.type_id
      LEFT JOIN ai_customer_data AS c ON c.id = am.customer
    WHERE 
      atm.member_id =? AND atm.status != 2
    ''', [memberId]);

    print('trouble results: $results');

    List<TroubleMember> troubleList = [];

    for (var row in results) {
      TroubleMember troubleMember = TroubleMember(
        id: row['id'],
        memberId: row['member_id'],
        idfull: row['idfull'],
        keluhan: row['keluhan'],
        createAt: row['create_at'] as DateTime?,
        status: row['status'],
        namaKapal: row['nama_kapal'],
        kategori: row['kategori'],
        type: row['type'],
        custamer: row['custamer'],
      );
      troubleList.add(troubleMember);
    }

    await conn.close();

    return troubleList;
  }

  Future<List<TroubleMember>> getHistoryTroubleData() async {
    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;

    print('Current User ID: $memberId');

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      atm.id AS id,
      atm.member_id AS member_id,
      atm.mobile_id AS mobile_id,
      atm.keluhan AS keluhan,
      atm.create_at AS create_at,
      atm.status AS status,
      am.idfull AS idfull,
      am.name AS nama_kapal,
      mc.name AS kategori,
      mt.name AS type,
      c.customer_name AS custamer
    FROM 
      ai_trouble_member AS atm
      LEFT JOIN ai_mobile AS am ON am.id = atm.mobile_id
      LEFT JOIN ai_mobile_category AS mc ON mc.id = am.category_id
      LEFT JOIN ai_mobile_type AS mt ON mt.id = am.type_id
      LEFT JOIN ai_customer_data AS c ON c.id = am.customer
    WHERE 
      atm.member_id =? AND atm.status = 2
    ''', [memberId]);

    print('trouble results: $results');

    List<TroubleMember> troubleList = [];

    for (var row in results) {
      TroubleMember troubleMember = TroubleMember(
        id: row['id'],
        memberId: row['member_id'],
        idfull: row['idfull'],
        keluhan: row['keluhan'],
        createAt: row['create_at'] as DateTime?,
        status: row['status'],
        namaKapal: row['nama_kapal'],
        kategori: row['kategori'],
        type: row['type'],
        custamer: row['custamer'],
      );
      troubleList.add(troubleMember);
    }

    await conn.close();

    return troubleList;
  }

  Future<List<TroubleMemberDetail>> getCommentsTroubleData(int id) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      atmd.trouble_member_id,
      atmd.admin_id,
      atmd.user_geo_id,
      atmd.member_id,
      atmd.respon,
      atmd.respon_member AS responMember,
      atmd.create_at,
      atmd.create_at_member,
      u.username AS nameUser,
      au.username AS nameAdmin,
      am.name AS nameMember,
      am.is_admin AS is_admin_member
    FROM 
      ai_trouble_member_detail AS atmd
      LEFT JOIN ai_users_office AS au ON au.id = atmd.admin_id
      LEFT JOIN users AS u ON u.id = atmd.user_geo_id
      LEFT JOIN ai_member AS am ON am.id = atmd.member_id
    WHERE
      atmd.trouble_member_id =?
    ORDER BY 
      CASE 
        WHEN atmd.admin_id IS NOT NULL OR atmd.user_geo_id IS NOT NULL THEN atmd.create_at 
        ELSE atmd.create_at_member 
      END
    ''', [id]);

    print('comment trouble results: $results');

    List<TroubleMemberDetail> commectTroubleList = [];

    for (var row in results) {
      TroubleMemberDetail troubleMemberDetail = TroubleMemberDetail(
        troubleMemberId: row['trouble_member_id'],
        adminId: row['admin_id'],
        userGeoId: row['user_geo_id'],
        memberId: row['member_id'],
        respon: row['respon'],
        responMember: row['responMember'],
        createAt: row['create_at'],
        createAtMember: row['create_at_member'],
        nameUser: row['nameUser'],
        nameAdmin: row['nameAdmin'],
        nameMember: row['nameMember'],
        isAdminMember: row['is_admin_member'],
      );
      commectTroubleList.add(troubleMemberDetail);
    }

    await conn.close();

    return commectTroubleList;
  }

  Future<List<TroubleAllMember>> getProcessTroubleDataAdmin() async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      atm.id, 
      atm.member_id, 
      am.name AS nameMember, 
      am.email AS emailMember, 
      atm.idfull, 
      atm.keluhan, 
      atm.create_at, 
      atm.status, 
      aml.name AS nama_kapal, 
      mc.name AS kategori, 
      mt.name AS type, 
      c.customer_name AS customer
    FROM 
      ai_trouble_member atm
      LEFT JOIN ai_member am ON am.id = atm.member_id
      LEFT JOIN ai_mobile aml ON aml.idfull = atm.idfull
      LEFT JOIN ai_mobile_category mc ON mc.id = aml.category_id
      LEFT JOIN ai_mobile_type mt ON mt.id = aml.type_id
      LEFT JOIN ai_customer_data c ON c.id = aml.customer
    WHERE 
      atm.status != 2
    ORDER BY 
      atm.create_at DESC
    ''');

    print('trouble admin results: $results');

    List<TroubleAllMember> troubleAllMemberList = [];

    for (var row in results) {
      TroubleAllMember troubleAllMember = TroubleAllMember(
        id: row['id'],
        memberId: row['member_id'],
        nameMember: row['nameMember'],
        emailMember: row['emailMember'],
        idfull: row['idfull'],
        keluhan: row['keluhan'],
        createAt: row['create_at'] as DateTime?,
        status: row['status'],
        namaKapal: row['nama_kapal'],
        kategori: row['kategori'],
        type: row['type'],
        custamer: row['custamer'],
      );
      troubleAllMemberList.add(troubleAllMember);
    }

    await conn.close();

    return troubleAllMemberList;
  }

  Future<List<TroubleAllMember>> getHistoryTroubleDataAdmin() async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      atm.id, 
      atm.member_id, 
      am.name AS nameMember, 
      am.email AS emailMember, 
      atm.idfull, 
      atm.keluhan, 
      atm.create_at, 
      atm.status, 
      aml.name AS nama_kapal, 
      mc.name AS kategori, 
      mt.name AS type, 
      c.customer_name AS customer
    FROM 
      ai_trouble_member atm
      LEFT JOIN ai_member am ON am.id = atm.member_id
      LEFT JOIN ai_mobile aml ON aml.idfull = atm.idfull
      LEFT JOIN ai_mobile_category mc ON mc.id = aml.category_id
      LEFT JOIN ai_mobile_type mt ON mt.id = aml.type_id
      LEFT JOIN ai_customer_data c ON c.id = aml.customer
    WHERE 
      atm.status = 2
    ORDER BY 
      atm.create_at DESC
    ''');

    print('trouble history admin results: $results');

    List<TroubleAllMember> troubleAllMemberList = [];

    for (var row in results) {
      TroubleAllMember troubleAllMember = TroubleAllMember(
        id: row['id'],
        memberId: row['member_id'],
        nameMember: row['nameMember'],
        emailMember: row['emailMember'],
        idfull: row['idfull'],
        keluhan: row['keluhan'],
        createAt: row['create_at'] as DateTime?,
        status: row['status'],
        namaKapal: row['nama_kapal'],
        kategori: row['kategori'],
        type: row['type'],
        custamer: row['custamer'],
      );
      troubleAllMemberList.add(troubleAllMember);
    }

    await conn.close();

    return troubleAllMemberList;
  }

  Future<Map<String, dynamic>?> searchDataKapal(String idfull) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      am.idfull AS idfull,
      am.name AS nama_kapal,
      mc.name AS kategori,
      mt.name AS type,
      c.customer_name AS custamer
    FROM 
      ai_mobile AS am
      LEFT JOIN ai_mobile_category AS mc ON mc.id = am.category_id
      LEFT JOIN ai_mobile_type AS mt ON mt.id = am.type_id
      LEFT JOIN ai_customer_data AS c ON c.id = am.customer
    WHERE 
      am.idfull =?
    ''', [idfull]);

    Map<String, dynamic>? dataKapal;

    if (results.isNotEmpty) {
      var row = results.first;
      dataKapal = {
        'idfull': row['idfull'] ?? '',
        'nama_kapal': row['nama_kapal'] ?? '',
        'kategori': row['kategori'] ?? '',
        'type': row['type'] ?? '',
        'custamer': row['custamer'] ?? '',
      };
    }

    await conn.close();

    return dataKapal;
  }

  Future<void> storeTroubleData(String mobileId, String keluhan) async {
    final now = DateTime.now().toUtc().add(Duration(hours: 7));

    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;

    print('Current User ID: $memberId');

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    await conn.query('''
    INSERT INTO ai_trouble_member (member_id, mobile_id, keluhan, create_at, status)
    VALUES (?, ?, ?, ?, 0)
    ''', [memberId, mobileId, keluhan, now]);

    await conn.close();
  }

  Future<void> storeCommectTrouble(
      int troubleMemberId, String responMember) async {
    final now = DateTime.now().toUtc().add(Duration(hours: 7));

    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;

    print('Current User ID: $memberId');

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    await conn.query('''
    INSERT INTO ai_trouble_member_detail (trouble_member_id, member_id, respon_member, create_at_member)
    VALUES (?, ?, ?, ?)
    ''', [troubleMemberId, memberId, responMember, now]);

    await conn.close();
  }

  Future<void> updateTroubleData(int id, String keluhan) async {
    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;

    print('Current User ID: $memberId');

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    await conn.query('''
    UPDATE ai_trouble_member
    SET 
      keluhan =?
    WHERE 
      id = ? AND member_id = ?
    ''', [keluhan, id, memberId]);

    await conn.close();
  }

  Future<void> processingTroubleData(int id) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    await conn.query('''
      UPDATE ai_trouble_member
      SET status = 1
      WHERE id = ? 
    ''', [id]);

    await conn.close();
  }

  Future<void> finishedTroubleData(int id) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    await conn.query('''
    UPDATE ai_trouble_member
    SET status = 2
    WHERE id = ? 
  ''', [id]);

    await conn.close();
  }

  Future<List<TroubleMember>> deleteTroubleData(int id) async {
    MemberUser? currentUser = await _authService.getCurrentUser();
    int memberId = currentUser?.id ?? 0;

    print('Current User ID: $memberId');

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    DELETE FROM ai_trouble_member
    WHERE 
      id =? AND member_id =?
    ''', [id, memberId]);

    print('trouble results: $results');

    List<TroubleMember> troubleList = [];

    for (var row in results) {
      TroubleMember troubleMember = TroubleMember(
        id: row['id'],
        memberId: row['member_id'],
        idfull: row['idfull'],
        keluhan: row['keluhan'],
        createAt: row['create_at'],
        status: int.parse(row['status']),
        namaKapal: row['nama_kapal'],
        kategori: row['kategori'],
        type: row['type'],
        custamer: row['custamer'],
      );
      troubleList.add(troubleMember);
    }

    await conn.close();

    return troubleList;
  }
}
