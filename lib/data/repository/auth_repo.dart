import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheet/data/model/body/token_request.dart';
import 'package:timesheet/data/model/body/user.dart';
import 'package:timesheet/utils/enum_role.dart';
import 'package:timesheet/utils/utils.dart';

import '../../helper/firebase_helper.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class AuthRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  final FirebaseHelper firebaseHelper;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
    required this.firebaseHelper,
  });

  Future<Response> login(
      {required String username, required String password}) async {
    //header login
    var token = "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    var languageCode = sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
    Map<String, String> header = {
      'Content-Type': 'application/x-www-form-urlencoded',
      AppConstants.LOCALIZATION_KEY:
          languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization': token
    };
    //call api login
    final result = await apiClient.postDataLogin(
        AppConstants.LOGIN_URI,
        TokenRequest(
                username: username,
                password: password,
                clientId: "core_client",
                clientSecret: "secret",
                grantType: "password")
            .toJson(),
        header);
    if (result.statusCode == 200) {
      //save device token
      String deviceToken = await _saveDeviceToken();
      //update device token
      await _updateMySeft(user: User(tokenDevice: deviceToken));
    }
    return result;
  }

  Future<Response> _updateMySeft({required User user}) {
    return apiClient.postData('${AppConstants.users}/update-myself',
        json.encode(user.toJson()), null);
  }

  Future<Response> register({required User user}) async {
    final result = await apiClient.postData(
        AppConstants.SIGN_UP,
        json.encode(user.copyWith(roles: [
          ...user.roles ?? [],
          EnumRole.user.value,
        ]).toJson()),
        null);

    return result;
  }

  Future<Response> logOut() async {
    //save device token
    await _updateMySeft(user: User(tokenDevice: ''));
    return await apiClient.deleteData(AppConstants.LOG_OUT);
  }

  Future<Response> getCurrentUser() async {
    return await apiClient.getData(AppConstants.GET_USER);
  }

  Future<String> _saveDeviceToken() async {
    String deviceToken = '@';
    if (!GetPlatform.isWeb) {
      try {
        deviceToken = await firebaseHelper.firebaseMessaging.getToken() ?? '@';
      } catch (e) {
        logger('Unable to get FCM token');
      }
    }
    logger('--------Device Token---------- $deviceToken');
    return deviceToken;
  }

  // for  user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = "Bearer $token";
    apiClient.updateHeader("Bearer $token", null,
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi", 0);
    return await sharedPreferences.setString(
        AppConstants.TOKEN, "Bearer $token");
  }

  Future<bool> clearUserToken() async {
    return await sharedPreferences.remove(AppConstants.TOKEN);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  bool clearSharedAddress() {
    sharedPreferences.remove(AppConstants.USER_ADDRESS);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(
      String number, String password, String countryCode) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
      await sharedPreferences.setString(
          AppConstants.USER_COUNTRY_CODE, countryCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveUserNumber(String number, String countryCode) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
      await sharedPreferences.setString(
          AppConstants.USER_COUNTRY_CODE, countryCode);
    } catch (e) {
      rethrow;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserCountryCode() {
    return sharedPreferences.getString(AppConstants.USER_COUNTRY_CODE) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    await sharedPreferences.remove(AppConstants.USER_COUNTRY_CODE);
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }
}
