import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/constants/constants.dart';
import 'package:geotraking/core/models/notification.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationModel notification;
  final String selectedLanguage;

  const NotificationDetailPage(
      {required this.notification, Key? key, required this.selectedLanguage})
      : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(Localization.getNotificationDetail(selectedLanguage)),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  notification.judul ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              Divider(
                thickness: 0.5,
                color: Colors.white60,
              ),
              Text(
                '${notification.teksNotification ?? ''}',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, 
                ),
                onPressed: () => _launchURL(
                    'https://play.google.com/store/apps/details?id=com.geosat.geotraking&pcampaignid=web_share'),
                child: Text(
                  'Open in Play Store',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
              SizedBox(height: 3),
              Text(
                timeago.format(
                  DateTime.parse(notification.createAt!.toIso8601String()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
