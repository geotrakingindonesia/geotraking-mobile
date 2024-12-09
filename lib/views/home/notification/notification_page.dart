// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_element, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/models/notification.dart';
// import 'package:geotraking/core/models/notification_member.dart';
// import 'package:geotraking/core/services/notification_member_service.dart';
import 'package:geotraking/core/services/notification_service.dart';
import 'package:geotraking/views/home/notification/notification_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationService _notificationService = NotificationService();
  List<NotificationModel> notifications = [];
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _getNotifications();
    _loadLanguageFromSharedPreferences();
  }

  Future<void> _getNotifications() async {
    try {
      final data = await _notificationService.getNotification();
      print(data);
      setState(() {
        notifications = data;
      });
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  _loadLanguageFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('language');
    if (language != null) {
      setState(() {
        _selectedLanguage = language;
      });
    }
  }

  void navigateToNotificationDetails(NotificationModel notification) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationDetailPage(
          notification: notification,
          selectedLanguage: _selectedLanguage,
        ),
      ),
    );
  }

  Color _getBackgroundColor(int index) {
    switch (index % 4) {
      case 0:
        return Color.fromARGB(255, 67, 154, 151);
      case 1:
        return Color.fromARGB(255, 98, 182, 183);
      case 2:
        return Color.fromARGB(255, 151, 222, 206);
      case 3:
        return Color.fromARGB(255, 203, 237, 213);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(Localization.getNotification(_selectedLanguage)),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        color: AppColors.cardColor,
        child: FadeInLeft(
          duration: Duration(milliseconds: 1000),
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final backgroundColor = _getBackgroundColor(index);
                return GestureDetector(
                  onTap: () async {
                    navigateToNotificationDetails(notification);
                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${(notification.judul!.split(' ').take(5).join(' '))}...',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                            Text(
                              '${(notification.teksNotification!.split(' ').take(15).join(' '))}...',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black54),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  timeago.format(
                                    DateTime.parse(notification.createAt!
                                        .toIso8601String()),
                                  ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(Icons.notification_important)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
