// ignore_for_file: unused_field, use_build_context_synchronously, prefer_const_constructors, unused_element
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/views/profile/troubleshoot/components/custom_tab_label.dart';
import 'package:geotraking/views/profile/troubleshoot/components/tab_history.dart';
import 'package:geotraking/views/profile/troubleshoot/components/tab_process.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TroubleshootPage extends StatefulWidget {
  const TroubleshootPage({Key? key}) : super(key: key);

  @override
  State<TroubleshootPage> createState() => _TroubleshootPageState();
}

class _TroubleshootPageState extends State<TroubleshootPage> {
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
          title: Text(Localization.getTroubleshoot(_selectedLanguage)),
          leading: AppBackButton(),
          titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
              ),
          centerTitle: true,

          backgroundColor: Colors.transparent,
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
                    CustomTabLabel(
                        label: Localization.getProcess(_selectedLanguage)),
                    CustomTabLabel(
                        label: Localization.getHistory(_selectedLanguage)),
                  ],
                ),
              ),
            ),
          ),
          // bottom: TabBar(
          //   physics: NeverScrollableScrollPhysics(),
          //   tabs: [
          //     CustomTabLabel(label: Localization.getProcess(_selectedLanguage)),
          //     CustomTabLabel(label: Localization.getHistory(_selectedLanguage)),
          //   ],
          // )
        ),
        body: Container(
          // color: Colors.transparent,
          color: Colors.white,
          child: const TabBarView(
            children: [
              TabProcess(),
              TabHistory(),
            ],
          ),
        ),
      ),
    );
  }
}
