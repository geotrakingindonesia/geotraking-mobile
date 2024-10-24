// ignore_for_file: unused_field, use_build_context_synchronously, prefer_const_constructors, unused_element
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/custom_tab_label.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/views/profile/troubleshoot/admin/components/tab_history_admin.dart';
import 'package:geotraking/views/profile/troubleshoot/admin/components/tab_process_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:geotraking/views/profile/troubleshoot/components/custom_tab_label.dart';

class TroubleshootAdminPage extends StatefulWidget {
  const TroubleshootAdminPage({Key? key}) : super(key: key);

  @override
  State<TroubleshootAdminPage> createState() => _TroubleshootAdminPageState();
}

class _TroubleshootAdminPageState extends State<TroubleshootAdminPage> {
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
          title: const Text('TroubleShoot Member'),
          leading: AppBackButton(),
          titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
              ),
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
          // bottom: const TabBar(
          //   physics: NeverScrollableScrollPhysics(),
          //   tabs: [
          //     CustomTabLabel(label: 'Process'),
          //     CustomTabLabel(label: 'History'),
          //   ],
          // ),
        ),
        body: Container(
          color: Colors.transparent,
          child: const TabBarView(
            children: [
              TabProcessAdmin(),
              TabHistoryAdmin(),
            ],
          ),
        ),
      ),
    );
  }
}
