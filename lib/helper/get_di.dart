import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/controller/comment_controller.dart';
import 'package:timesheet/controller/post_controller.dart';
import 'package:timesheet/controller/timesheet_controller.dart';
import 'package:timesheet/controller/tracking_controller.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/data/repository/notification_repo.dart';
import 'package:timesheet/data/repository/post_repo.dart';
import 'package:timesheet/data/repository/splash_repo.dart';
import 'package:timesheet/data/repository/timesheet_repo.dart';
import 'package:timesheet/data/repository/tracking_repo.dart';
import 'package:timesheet/data/repository/user_repo.dart';
import '../controller/localization_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/splash_controller.dart';
import '../data/api/api_client.dart';
import '../data/model/language_model.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/language_repo.dart';
import '../theme/theme_controller.dart';
import '../utils/app_constants.dart';
import 'firebase_helper.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  //config
  final FirebaseHelper firebaseHelper = FirebaseHelper();
  await firebaseHelper.init();
  Get.lazyPut(() => firebaseHelper);
  // final firstCamera = await availableCameras();
  Get.lazyPut(() => sharedPreferences);
  // Get.lazyPut(() => firstCamera);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  // Repository
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => AuthRepo(
        apiClient: Get.find(),
        sharedPreferences: Get.find(),
        firebaseHelper: Get.find(),
      ));
  Get.lazyPut(() => SplashRepo(apiClient: Get.find()));
  Get.lazyPut(() => TrackingRepo(apiClient: Get.find()));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find()));
  Get.lazyPut(() => PostRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => TimeSheetRepo(apiClient: Get.find()));
  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(repo: Get.find()));
  Get.lazyPut(() => AuthController(repo: Get.find()));
  Get.lazyPut(() => TrackingController(repo: Get.find()));
  Get.lazyPut(() => NotificationController(repo: Get.find()));
  Get.lazyPut(() => PostController(repo: Get.find()));
  Get.lazyPut(() => CommentController(repo: Get.find()));
  Get.lazyPut(() => UserController(repo: Get.find()));
  Get.lazyPut(() => TimesheetController(repo: Get.find()));
  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    // ignore: no_leading_underscores_for_local_identifiers
    Map<String, String> _json = {};
    mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return languages;
}
