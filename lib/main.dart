import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/views/splash_screen.dart';
import 'package:atm_tracker/utils/log/custom_loger.dart';
import 'package:atm_tracker/utils/pages/pages.dart';
import 'package:atm_tracker/utils/theme/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final log = CustomLogger(className: 'main');
Future<void> main() async {
  try {
    await Services.initializeApp();
    await Future.delayed(200.milliseconds);
    runApp(MyApp());
  } catch (e) {
    log.e(e);
  }
}

class MyApp extends StatelessWidget {
  final controller = Get.put(AuthController());
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    log.i('Put Auth Controller');
    return GetMaterialApp(
      title: 'Money Time',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: SplashScreen.route,
      getPages: AppRoutes.pages,
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
      locale: const Locale('en', 'US'),
      onInit: () async {},
    );
  }
}
