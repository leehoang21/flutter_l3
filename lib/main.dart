import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:timesheet/theme/dark_theme.dart';
import 'package:timesheet/theme/light_theme.dart';
import 'package:timesheet/utils/app_constants.dart';
import 'package:timesheet/helper/internet_checker.dart';
import 'package:timesheet/utils/messages.dart';
import 'package:timesheet/utils/vi_message_timeago.dart';
import 'controller/localization_controller.dart';
import 'firebase_options.dart';
import 'helper/get_di.dart' as di;
import 'helper/notification_helper.dart';
import 'helper/responsive_helper.dart';
import 'helper/route_helper.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    print("Bắt đầu: ${DateTime.now()}");
  }
  timeago.setLocaleMessages('vi', ViMessages());
  timeago.setLocaleMessages('vi_short', ViShortMessages());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationHelper.initialize(
    FlutterLocalNotificationsPlugin(),
  );
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = MyHttpOverrides();
  }

  Map<String, Map<String, String>> languages = await di.init();

  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  const MyApp({super.key, this.languages});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizeController) {
      FlutterNativeSplash.remove();
      if (kDebugMode) {
        print("Kết thúc init: ${DateTime.now()}");
      }
      return GetMaterialApp(
        title: AppConstants.APP_NAME,
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
        ),
        locale: localizeController.locale,
        theme: light(),
        darkTheme: dark(),
        translations: Messages(languages: languages),
        fallbackLocale: Locale(AppConstants.languages[0].languageCode,
            AppConstants.languages[0].countryCode),
        initialRoute: GetPlatform.isWeb
            ? RouteHelper.getInitialRoute()
            : RouteHelper.getSplashRoute(),
        getPages: RouteHelper.routes,
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 250),
        builder: _buildInternetChecker,
      );
    });
  }

  Widget _buildInternetChecker(BuildContext context, Widget? widget) {
    InternetChecker.listenConnection((ConnectivityResult result) {
      final isNotConnected = InternetChecker.isNotConnected(result);
      isNotConnected
          ? const SizedBox()
          : ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: isNotConnected ? Colors.red : Colors.green,
        duration: Duration(seconds: isNotConnected ? 6000 : 3),
        content: Text(
          isNotConnected ? 'no_connection'.tr : 'connected'.tr,
          textAlign: TextAlign.center,
        ),
      ));
    });
    return widget ?? const SizedBox();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
