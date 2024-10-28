// // // ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, prefer_const_constructors, unused_field, deprecated_member_use
// // // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:geotraking/core/services/auth/authenticate_service.dart';
// // // import 'package:geotraking/core/services/version_checker_service.dart';
// // import 'package:geotraking/views/auth/login_page.dart';
// // import 'package:geotraking/views/catalogue/product_page.dart';
// // import 'package:geotraking/views/entrypoint/components/custom_button_app_navigation.dart';
// // import 'package:geotraking/views/home/home_page.dart';
// // import 'package:geotraking/views/profile/profile_page.dart';
// // import 'package:geotraking/views/traking/traking_page.dart';
// // import 'package:package_info_plus/package_info_plus.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // import 'package:device_info_plus/device_info_plus.dart';
// // // import 'package:http/http.dart' as http;

// // // import 'package:url_launcher/url_launcher.dart';

// // class EntryPointUI extends StatefulWidget {
// //   const EntryPointUI({Key? key}) : super(key: key);

// //   @override
// //   State<EntryPointUI> createState() => _EntryPointUIState();
// // }

// // class _EntryPointUIState extends State<EntryPointUI> {
// //   bool _isLoggedIn = false;
// //   bool _isFirstLaunch = true;
// //   int _selectedIndex = 0;
// //   String _selectedLanguage = 'English';
// //   String _appVersion = '';
// //   String _playStoreUrl =
// //       'https://play.google.com/store/apps/details?id=com.geosat.geotraking';

// //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _checkLoggedIn();
// //     _checkFirstLaunch();
// //     _loadLanguageFromSharedPreferences();
// //     _getAppVersion();
// //   }

// //   _checkLoggedIn() async {
// //     final authService = AuthService();
// //     final user = await authService.getCurrentUser();

// //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
// //     final device = androidInfo.device;
// //     final model = androidInfo.model;
// //     final brand = androidInfo.brand;
// //     final host = androidInfo.host;

// //     if (user != null) {
// //       setState(() {
// //         _isLoggedIn = true;
// //       });

// //       await authService.saveLoginHistory(user.id, device, model, brand, host);
// //     } else {
// //       await authService.saveLoginHistory(0, device, model, brand, host);
// //     }
// //   }

// //   _getAppVersion() async {
// //     try {
// //       PackageInfo packageInfo = await PackageInfo.fromPlatform();
// //       setState(() {
// //         _appVersion = packageInfo.version;
// //       });
// //       print('App Version: $_appVersion');
// //     } catch (e) {
// //       print('Failed to get app version: $e');
// //     }
// //   }

// //   _checkFirstLaunch() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
// //     if (isFirstLaunch) {
// //       showDialog(
// //         context: context,
// //         barrierDismissible: true,
// //         barrierColor: Colors.white.withOpacity(0.5),
// //         builder: (BuildContext context) {
// //           return AlertDialog(
// //             backgroundColor: Colors.white.withOpacity(0.8),
// //             content: Image.asset('assets/images/first_launcher.png'),
// //             actions: <Widget>[
// //               ElevatedButton(
// //                 child: Text('OK'),
// //                 onPressed: () {
// //                   Navigator.of(context).pop();
// //                 },
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //       prefs.setBool('isFirstLaunch', false);
// //     }
// //     setState(() {
// //       _isFirstLaunch = false;
// //     });
// //   }

// //   _loadLanguageFromSharedPreferences() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final language = prefs.getString('language');
// //     if (language != null) {
// //       setState(() {
// //         _selectedLanguage = language;
// //       });
// //     }
// //   }

// //   _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       extendBody: true,
// //       body: Stack(
// //         children: [
// //           [
// //             HomePage(selectedLanguage: _selectedLanguage),
// //             ProductPage(selectedLanguage: _selectedLanguage),
// //             TrakingPage(),
// //             _isLoggedIn
// //                 ? ProfilePage(selectedLanguage: _selectedLanguage)
// //                 : LoginPage(),
// //           ][_selectedIndex],
// //           BottomGradientWidget(),
// //         ],
// //       ),
// //       bottomNavigationBar: CustomBottomNavigationBar(
// //           onItemTapped: _onItemTapped, selectedIndex: _selectedIndex),
// //     );
// //   }
// // }

// // class BottomGradientWidget extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Positioned(
// //       bottom: 0,
// //       child: Container(
// //         width: MediaQuery.of(context).size.width,
// //         height: 150,
// //         decoration: BoxDecoration(
// //             gradient: LinearGradient(colors: [
// //           Color(0xFF107873).withOpacity(0.2),
// //           Color(0xFF107873).withOpacity(0)
// //         ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:geotraking/core/services/auth/authenticate_service.dart';
// import 'package:geotraking/views/auth/login_page.dart';
// import 'package:geotraking/views/catalogue/product_page.dart';
// import 'package:geotraking/views/entrypoint/components/custom_button_app_navigation.dart';
// import 'package:geotraking/views/home/home_page.dart';
// import 'package:geotraking/views/profile/profile_page.dart';
// import 'package:geotraking/views/traking/traking_page.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:device_info_plus/device_info_plus.dart';

// class EntryPointUI extends StatefulWidget {
//   const EntryPointUI({Key? key}) : super(key: key);

//   @override
//   State<EntryPointUI> createState() => _EntryPointUIState();
// }

// class _EntryPointUIState extends State<EntryPointUI> {
//   bool _isLoggedIn = false;
//   bool _isFirstLaunch = true;
//   int _selectedIndex = 0;
//   String _selectedLanguage = 'English';
//   String _appVersion = '';
//   String _playStoreUrl =
//       'https://play.google.com/store/apps/details?id=com.geosat.geotraking';

//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//   @override
//   void initState() {
//     super.initState();
//     _checkLoggedIn();
//     _checkFirstLaunch();
//     _loadLanguageFromSharedPreferences();
//     _getAppVersion();
//   }

//   _checkLoggedIn() async {
//     final authService = AuthService();
//     final user = await authService.getCurrentUser();

//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     final device = androidInfo.device;
//     final model = androidInfo.model;
//     final brand = androidInfo.brand;
//     final host = androidInfo.host;

//     if (user != null) {
//       setState(() {
//         _isLoggedIn = true;
//       });

//       await authService.saveLoginHistory(user.id, device, model, brand, host);
//     } else {
//       await authService.saveLoginHistory(0, device, model, brand, host);
//     }
//   }

//   _getAppVersion() async {
//     try {
//       PackageInfo packageInfo = await PackageInfo.fromPlatform();
//       setState(() {
//         _appVersion = packageInfo.version;
//       });
//       print('App Version: $_appVersion');
//     } catch (e) {
//       print('Failed to get app version: $e');
//     }
//   }

//   _checkFirstLaunch() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
//     if (isFirstLaunch) {
//       showDialog(
//         context: context,
//         barrierDismissible: true,
//         barrierColor: Colors.white.withOpacity(0.5),
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: Colors.white.withOpacity(0.8),
//             content: Image.asset('assets/images/first_launcher.png'),
//             actions: <Widget>[
//               ElevatedButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       prefs.setBool('isFirstLaunch', false);
//     }
//     setState(() {
//       _isFirstLaunch = false;
//     });
//   }

//   _loadLanguageFromSharedPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     final language = prefs.getString('language');
//     if (language != null) {
//       setState(() {
//         _selectedLanguage = language;
//       });
//     }
//   }

//   _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       body: Stack(
//         children: [
//           [
//             HomePage(selectedLanguage: _selectedLanguage),
//             ProductPage(selectedLanguage: _selectedLanguage),
//             TrakingPage(),
//             _isLoggedIn
//                 ? ProfilePage(selectedLanguage: _selectedLanguage)
//                 : LoginPage(),
//           ][_selectedIndex],
//           BottomGradientWidget(),
//         ],
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//           onItemTapped: _onItemTapped, selectedIndex: _selectedIndex),
//     );
//   }
// }

// class BottomGradientWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 0,
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: 150,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//           Color(0xFF107873).withOpacity(0.2),
//           Color(0xFF107873).withOpacity(0)
//         ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/views/auth/login_page.dart';
import 'package:geotraking/views/catalogue/product_page.dart';
import 'package:geotraking/views/chat/chat_page.dart';
import 'package:geotraking/views/entrypoint/components/custom_button_app_navigation.dart';
import 'package:geotraking/views/home/home_page.dart';
import 'package:geotraking/views/profile/components/profile_tracking_page.dart';
import 'package:geotraking/views/profile/geosat/profile_tracking_geosat_page.dart';
import 'package:geotraking/views/profile/profile_page.dart';
import 'package:geotraking/views/traking/traking_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:device_info_plus/device_info_plus.dart';

class EntryPointUI extends StatefulWidget {
  const EntryPointUI({Key? key}) : super(key: key);

  @override
  State<EntryPointUI> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointUI> {
  bool _isLoggedIn = false;
  bool _isFirstLaunch = true;
  int _selectedIndex = 0;
  MemberUser? _user;
  String _selectedLanguage = 'English';

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
    _checkFirstLaunch();
    _loadLanguageFromSharedPreferences();
  }

  // _checkLoggedIn() async {
  //   final authService = AuthService();
  //   final user = await authService.getCurrentUser();

  //   if (user != null) {
  //     print('User ID: ${user.id}');
  //     print('Name: ${user.name}');
  //     print('Is Admin: ${user.isAdmin}');

  //     setState(() {
  //     _isLoggedIn = true;
  //     _user = user;
  //   });
  //   }

  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     final device = androidInfo.device;
  //     final model = androidInfo.model;
  //     final brand = androidInfo.brand;
  //     final host = androidInfo.host;

  //     print('Running on Android');
  //     print('Device: $device');
  //     print('Model: $model');
  //     print('Brand: $brand');
  //     print('Host: $host');

  //     if (user != null) {
  //       setState(() {
  //         _isLoggedIn = true;
  //       });

  //       await authService.saveLoginHistory(user.id, device, model, brand, host);
  //     } else {
  //       await authService.saveLoginHistory(0, device, model, brand, host);
  //     }
  //   } else if (Platform.isIOS) {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     final deviceIos = iosInfo.name;
  //     final modelIos = iosInfo.model;

  //     print('Running on iOS');
  //     print('Device: $deviceIos');
  //     print('Model: $modelIos');

  //     if (user != null) {
  //       setState(() {
  //         _isLoggedIn = true;
  //       });

  //       await authService.saveLoginHistory(
  //           user.id, deviceIos, modelIos, '', '');
  //     } else {
  //       await authService.saveLoginHistory(0, deviceIos, modelIos, '', '');
  //     }
  //   }
  // }

  void _checkLoggedIn() async {
    final authService = AuthService();
    final user = await authService.getCurrentUser();

    if (user != null) {
      print('User ID: ${user.id}');
      print('Name: ${user.name}');
      print('Is Admin: ${user.isAdmin}');
      setState(() {
        _isLoggedIn = true;
        _user = user;
      });

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        await authService.saveLoginHistory(
          user.id,
          androidInfo.device,
          androidInfo.model,
          androidInfo.brand,
          androidInfo.host,
        );
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        await authService.saveLoginHistory(
          user.id,
          iosInfo.name,
          iosInfo.model,
          '',
          '',
        );
      }
    } else {
      setState(() {
        _isLoggedIn = false;
      });

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        await authService.saveLoginHistory(0, androidInfo.device,
            androidInfo.model, androidInfo.brand, androidInfo.host);
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        await authService.saveLoginHistory(
            0, iosInfo.name, iosInfo.model, '', '');
      }
    }
  }

  _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if (isFirstLaunch) {
      showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.white.withOpacity(0.5),
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.8),
            content: Image.asset('assets/images/first_launcher.png'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      prefs.setBool('isFirstLaunch', false);
    }
    setState(() {
      _isFirstLaunch = false;
    });
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

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            [
              HomePage(selectedLanguage: _selectedLanguage),
              ProductPage(),
              ChatPage(),
              if (_isLoggedIn)
                _user!.isAdmin == 0
                    ? ProfileTrackingPage()
                    : ProfileTrackingGeosatPage()
              else
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/login.png',
                        width: 250,
                        height: 250,
                      ),
                      // SizedBox(height: 16),
                      Text(
                        'Silakan login terlebih dahulu',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              // Center(child: Text('Silakan login terlebih dahulu')),
              // TrakingPage(),
              _isLoggedIn
                  ? ProfilePage(selectedLanguage: _selectedLanguage)
                  : LoginPage(),
            ][_selectedIndex],
            BottomGradientWidget(),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            onItemTapped: _onItemTapped, selectedIndex: _selectedIndex),
      ),
    );
  }
}

class BottomGradientWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF107873).withOpacity(0.5),
              Color(0xFF107873).withOpacity(0)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
