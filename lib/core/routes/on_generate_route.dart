// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/cupertino.dart';
import 'package:geotraking/views/auth/login_page.dart';
import 'package:geotraking/views/auth/sign_up_page.dart';
// import 'package:geotraking/views/catalogue/product_page.dart';
import 'package:geotraking/views/entrypoint/entrypoint_ui.dart';
import 'package:geotraking/views/home/categories/airtime/search_page.dart';
import 'package:geotraking/views/home/categories/basarnas/basarnas_page.dart';
import 'package:geotraking/views/home/categories/bbm/calc_bbm_page.dart';
import 'package:geotraking/views/home/categories/iot/iot_page.dart';
import 'package:geotraking/views/home/categories/topup/topup_page.dart';
import 'package:geotraking/views/home/drawer/change_language_page.dart';
import 'package:geotraking/views/home/notification/create_notification_page.dart';
import 'package:geotraking/views/home/notification/notification_page.dart';
import 'package:geotraking/views/home/categories/portRi/port_ri_page.dart';
import 'package:geotraking/views/home/categories/salmon/salmon_page.dart';
import 'package:geotraking/views/home/categories/wpp/wpp_page.dart';
import 'package:geotraking/views/home/drawer/about_us_page.dart';
import 'package:geotraking/views/home/drawer/contact_us_page.dart';
import 'package:geotraking/views/home/drawer/drawer_page.dart';
// import 'package:geotraking/views/home/drawer/faq_page.dart';
import 'package:geotraking/views/profile/apn/profile_kapal_apn_page.dart';
import 'package:geotraking/views/profile/apn/profile_tracking_apn_page.dart';
import 'package:geotraking/views/profile/components/legend_information.dart';
import 'package:geotraking/views/profile/components/privacy_policy.dart';
// import 'package:geotraking/views/profile/components/profile_change_language_page.dart';
import 'package:geotraking/views/profile/components/profile_change_password_page.dart';
import 'package:geotraking/views/profile/components/profile_edit_page.dart';
import 'package:geotraking/views/profile/components/profile_kapal_page.dart';
// import 'package:geotraking/views/profile/components/profile_point_page.dart';
import 'package:geotraking/views/profile/components/profile_setting_page.dart';
import 'package:geotraking/views/profile/components/profile_tracking_page.dart';
// import 'package:geotraking/views/profile/console/console_page.dart';
import 'package:geotraking/views/profile/geosat/profile_kapal_geosat_page.dart';
import 'package:geotraking/views/profile/geosat/profile_tracking_geosat_page.dart';
import 'package:geotraking/views/profile/log/logbook_hasil_penangkapan_page.dart';
import 'package:geotraking/views/profile/log/logbook_history_hasil_penangkapan_page.dart';
// import 'package:geotraking/views/profile/report/jaraktempuh/jaraktempuh_page.dart';
// import 'package:geotraking/views/profile/history/history_page.dart';
// import 'package:geotraking/views/profile/profile_page.dart';
import 'package:geotraking/views/profile/support/support_page.dart';
import 'package:geotraking/views/profile/transaction/transaction_page.dart';
import 'package:geotraking/views/profile/troubleshoot/admin/troubleshoot_admin_page.dart';
import 'package:geotraking/views/profile/troubleshoot/troubleshoot_page.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.entryPoint:
        return CupertinoPageRoute(builder: (_) => const EntryPointUI());

      case AppRoutes.login:
        return CupertinoPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.signup:
        return CupertinoPageRoute(builder: (_) => const SignUpPage());

      case AppRoutes.drawerPage:
        return CupertinoPageRoute(builder: (_) => const DrawerPage());

      case AppRoutes.aboutUs:
        return CupertinoPageRoute(builder: (_) => const AboutUsPage());

      // case AppRoutes.faq:
      //   return CupertinoPageRoute(builder: (_) => const FAQPage());

      case AppRoutes.contactUs:
        return CupertinoPageRoute(builder: (_) => const ContactUsPage());
      // route halaman product
      // case AppRoutes.productPage:
      //   return CupertinoPageRoute(builder: (_) => const ProductPage());

      case AppRoutes.supportPage:
        return CupertinoPageRoute(builder: (_) => const SupportPage());

      case AppRoutes.airtimePage:
        return CupertinoPageRoute(builder: (_) => const SearchAirtimePage());

      // case AppRoutes.openFiberPage:
      //   return CupertinoPageRoute(builder: (_) => const OpenFiberPage());

      case AppRoutes.calcBbmPage:
        return CupertinoPageRoute(builder: (_) => const CalculateBbmPage());

      case AppRoutes.wppPage:
        return CupertinoPageRoute(builder: (_) => const WppPage());

      case AppRoutes.basarnasPage:
        return CupertinoPageRoute(builder: (_) => const BasarnasPage());

      case AppRoutes.portRiPage:
        return CupertinoPageRoute(builder: (_) => const PortRiPage());

      case AppRoutes.salmonPage:
        return CupertinoPageRoute(builder: (_) => const SalmonPage());

      case AppRoutes.troubleshootMemberPage:
        return CupertinoPageRoute(builder: (_) => const TroubleshootPage());

      case AppRoutes.troubleshootAdminPage:
        return CupertinoPageRoute(
            builder: (_) => const TroubleshootAdminPage());

      // case AppRoutes.historyPembayaranPage:
      //   return CupertinoPageRoute(builder: (_) => const HistoryMemberPage());

      // case AppRoutes.myPointPage:
      //   return CupertinoPageRoute(builder: (_) => const ProfilePointPage());

      case AppRoutes.notificationPage:
        return CupertinoPageRoute(builder: (_) => const NotificationPage());
        
      case AppRoutes.createNotificationPage:
        return CupertinoPageRoute(builder: (_) => CreateNotificationPage());

      // case AppRoutes.myProfile:
      //   return CupertinoPageRoute(builder: (_) => ProfilePage());

      case AppRoutes.settingMyProfile:
        return CupertinoPageRoute(builder: (_) => ProfileSettingPage());

      case AppRoutes.changePasswordProfile:
        return CupertinoPageRoute(
            builder: (_) => const ProfileChangePasswordPage());

      case AppRoutes.changeLanguage:
        return CupertinoPageRoute(
            // builder: (_) => const ProfileChangeLanguagePage());
            builder: (_) => const ChangeLanguagePage());

      case AppRoutes.editMyProfile:
        return CupertinoPageRoute(
            builder: (_) => const ProfileMemberEditPage());

      case AppRoutes.myProfileKapal:
        return CupertinoPageRoute(builder: (_) => const ProfileKapalPage());

      case AppRoutes.myProfileKapalGeosat:
        return CupertinoPageRoute(
            builder: (_) => const ProfileKapalGeosatPage());

      case AppRoutes.myProfileKapalApn:
        return CupertinoPageRoute(builder: (_) => const ProfileKapalAPNPage());

      case AppRoutes.myProfileTrackKapalAPN:
        return CupertinoPageRoute(
            builder: (_) => const ProfileTrackingAPNPage());

      case AppRoutes.myProfileTrackKapalGeosat:
        return CupertinoPageRoute(
            builder: (_) => const ProfileTrackingGeosatPage());

      case AppRoutes.myProfileTrackKapal:
        return CupertinoPageRoute(builder: (_) => const ProfileTrackingPage());

      // case AppRoutes.myProfileTrackKapalDemo:
      //   return CupertinoPageRoute(builder: (_) => const ProfileTrackingDemoPage());

      case AppRoutes.transactionPage:
        return CupertinoPageRoute(builder: (_) => const TransactionPage());

      case AppRoutes.iotPage:
        return CupertinoPageRoute(builder: (_) => IotPage());

      case AppRoutes.topUpPage:
        return CupertinoPageRoute(builder: (_) => TopupPage());


      case AppRoutes.logBookHasilPenangkapan:
        return CupertinoPageRoute(builder: (_) => LogbookHasilPenangkapanPage());
        
      case AppRoutes.logBookHistoryHasilPenangkapan:
        return CupertinoPageRoute(builder: (_) => LogbookHistoryHasilPenangkapanPage());
      
      // case AppRoutes.reportHistoryTrakingJarakTempuh:
      //   return CupertinoPageRoute(builder: (_) => JaraktempuhPage());
      
      
      case AppRoutes.legendInformation:
        return CupertinoPageRoute(builder: (_) => LegendInformation());
      
      case AppRoutes.privacyPolice:
        return CupertinoPageRoute(builder: (_) => PrivacyPolicy());





      // case AppRoutes.consolePage:
      // return CupertinoPageRoute(builder: (_) => ConsolePage());
    }
  }
}
