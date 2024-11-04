import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MediaSosialRow extends StatefulWidget {
  const MediaSosialRow({Key? key}) : super(key: key);

  @override
  State<MediaSosialRow> createState() => _MediaSosialRowState();
}

class _MediaSosialRowState extends State<MediaSosialRow> {
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadLanguageFromSharedPreferences();
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

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Text(
                Localization.socialMedia(_selectedLanguage),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.pink,
                  size: 18,
                ),
                onPressed: () =>
                    _launchUrl('https://www.instagram.com/geosatindonesia/'),
              ),
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                  size: 18,
                ),
                onPressed: () =>
                    _launchUrl('https://www.youtube.com/@geosatindonesia428'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
