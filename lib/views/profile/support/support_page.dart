import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/custom_tab_label.dart';
import 'package:geotraking/core/components/localization_language.dart';
// import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/views/profile/support/components/support_service_pack.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'components/custom_tab_label.dart';
import 'components/tutorial_pack.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: Text(Localization.getHelpCenter(_selectedLanguage)),
          titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
              ),
          centerTitle: true,
          // bottom: TabBar(
          //   physics: NeverScrollableScrollPhysics(),
          //   tabs: [
          //     CustomTabLabel(label: Localization.getTabTutorialHelpCenter(_selectedLanguage)),
          //     CustomTabLabel(label: Localization.getTabSupportServiceHelpCenter(_selectedLanguage)),
          //   ],
          // ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 196, 218, 210),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Color.fromARGB(255, 106, 156, 137),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    CustomTabLabel(label: Localization.getTabTutorialHelpCenter(_selectedLanguage)),
                    CustomTabLabel(label: Localization.getTabSupportServiceHelpCenter(_selectedLanguage)),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          // color: AppColors.cardColor,
          color: Colors.white,
          child: const TabBarView(
            children: [
              TutorialPack(),
              SupportServicePack(),
            ],
          ),
        ),
      ),
    );
  }
}
