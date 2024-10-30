
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/components/localization_language.dart';
// import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/views/profile/transaction/components/custom_tab_label.dart';
// import 'package:geotraking/views/profile/transaction/components/tab_paidoff.dart';
// import 'package:geotraking/views/profile/transaction/components/tab_process.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Localization.getTransaction(_selectedLanguage)),
          titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
              ),
          leading: const AppBackButton(),
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
                        label: Localization.getPaidOff(_selectedLanguage)),
                    CustomTabLabel(
                        label: Localization.getCancel(_selectedLanguage)),
                    CustomTabLabel(
                        label: Localization.getReplace(_selectedLanguage)),
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
              // TabProcess(),
              // TabPaidOff(),
              Text('Coming Soon'),
              Text('Coming Soon'),
              Text('Coming Soon'),
              Text('Coming Soon'),
            ],
          ),
        ),
      ),
    );
  }
}
