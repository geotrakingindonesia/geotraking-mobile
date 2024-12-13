import 'dart:convert';

import 'package:geotraking/core/models/notification.dart';
import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  // fungsi get notification
  Future<List<NotificationModel>> getNotification() async {
    var settings = Connection.getConnect();
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('''
    SELECT 
      id,
      judul,
      teks,
      create_at
    FROM 
      ai_notification_mobile
    ORDER BY create_at DESC
    ''');

    print('Notification Results: $results');

    List<NotificationModel> notificationList = [];

    for (var row in results) {
      NotificationModel notification = NotificationModel(
        id: row['id'] ?? '',
        judul: row['judul'] ?? '',
        teksNotification: row['teks'],
        createAt: row['create_at'] as DateTime?,
      );
      notificationList.add(notification);
    }

    await conn.close();

    return notificationList;
  }

  // insert data notif ke database
  Future<void> saveNotification(NotificationModel notification) async {
    var settings = Connection.getConnect();
    var conn = await MySqlConnection.connect(settings);

    await conn.query('''
    INSERT INTO ai_notification_mobile (judul, teks, create_at)
    VALUES (?, ?, ?)
  ''', [
      notification.judul,
      notification.teksNotification,
      DateTime.now().toUtc().add(Duration(hours: 7)),
    ]);

    await conn.close();
  }

  // push notif onesignal
  Future<void> sendNotification(NotificationModel notification) async {
    final String onesignalAppId = "f25fa782-d712-4633-91ea-8d6237bd8608";
    final String onesignalRestApiKey =
        "NTU2MjM1NGQtMmI2My00ODFmLTkyNWItYTNiYzA2OGI5MTVj";

    final response = await http.post(
      Uri.parse("https://onesignal.com/api/v1/notifications"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Basic $onesignalRestApiKey",
      },
      body: json.encode({
        "app_id": onesignalAppId,
        "included_segments": ["All"],
        "headings": {"en": notification.judul},
        "contents": {"en": notification.teksNotification},
        "small_icon": "ic_stat_ic_launcher",
        "large_icon": "ic_stat_ic_launcher",
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to send notification: ${response.body}");
    }
  }
}
