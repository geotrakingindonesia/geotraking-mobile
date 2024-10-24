import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/app_settings_tile.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/constants/app_icons.dart';
import 'package:geotraking/core/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Menu'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            AppSettingsListTile(
              label: Localization.getAboutUs(_selectedLanguage),
              // label: 'About Us',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.aboutUs),
            ),
            // AppSettingsListTile(
            //   label: Localization.getFaqs(_selectedLanguage),
            //   // label: 'Faqs',
            //   trailing: SvgPicture.asset(AppIcons.right),
            //   onTap: () => Navigator.pushNamed(context, AppRoutes.faq),
            // ),
            AppSettingsListTile(
              label: Localization.getContactUs(_selectedLanguage),
              // label: 'Contact Us',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.contactUs),
            ),
            AppSettingsListTile(
              label: Localization.getHelpCenter(_selectedLanguage),
              // label: 'Help Center',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () => Navigator.pushNamed(context, AppRoutes.supportPage),
            ),
            AppSettingsListTile(
              label: Localization.getChangeLanguage(_selectedLanguage),
              // label: 'Change Language',
              trailing: SvgPicture.asset(AppIcons.right),
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.changeLanguage),
            ),
          ],
        ),
      ),
    );
  }
}
