import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/routes/app_routes.dart';
import 'package:geotraking/core/routes/on_generate_route.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("f25fa782-d712-4633-91ea-8d6237bd8608");
  OneSignal.Notifications.requestPermission(true);

  await SharedPreferences.getInstance();
  
  // runApp(const MainApp());
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    // return GetMaterialApp(
      title: 'Geotraking',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.onGenerate,
      initialRoute: AppRoutes.entryPoint,
    );
  }
}
