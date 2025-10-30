import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:timesheet/screen/edit_profile/edit_profile_screen.dart';
import 'package:timesheet/screen/main/main_screen.dart';
import 'package:timesheet/screen/register/register_screen.dart';
import 'package:timesheet/screen/save_tracking/save_tracking_screen.dart';
import 'package:timesheet/screen/sign_in/sign_in_screen.dart';
import 'package:timesheet/utils/enum_role.dart';
import '../data/model/body/role.dart';
import '../screen/admin/home/admin_screen.dart';
import '../screen/admin/edit_user/edit_user_screen.dart';
import '../screen/admin/user_detail/user_detail_screen.dart';
import '../screen/splash/splash_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String main = '/main';
  static const String saveTracking = '/save-tracking';
  static const String editProfile = '/edit_profile';
  static const String admin = '/admin';
  static const String adminUserDetail = '/admin-user-detail';
  static const String adminEditUser = '/admin-edit-user';

  static String getInitialRoute() => initial;

  static String getSignInRoute() => signIn;

  static String getSplashRoute() => splash;

  static String getMainRoute(List<Role> roles) {
    for (final role in roles) {
      if (role.authority == EnumRole.user) {
        return main;
      }
    }
    return admin;
  }

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: main, page: () => const MainScreen()),
    GetPage(name: signUp, page: () => const RegisterScreen()),
    GetPage(name: saveTracking, page: () => const SaveTrackingScreen()),
    GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(name: admin, page: () => const AdminScreen()),
    GetPage(name: adminUserDetail, page: () => const AdminUserDetailScreen()),
    GetPage(name: adminEditUser, page: () => const AdminEditUserScreen()),
  ];

  static getRoute(Widget navigateTo) {
    // int _minimumVersion = 0;
    // if (GetPlatform.isAndroid) {
    //   _minimumVersion =
    //       Get.find<SplashController>().configModel.appMinimumVersionAndroid;
    // } else if (GetPlatform.isIOS) {
    //   _minimumVersion =
    //       Get.find<SplashController>().configModel.appMinimumVersionIos;
    // }
    // return AppConstants.APP_VERSION < _minimumVersion
    //     ? UpdateScreen(isUpdate: true)
    //     : Get.find<SplashController>().configModel.maintenanceMode
    //         ? UpdateScreen(isUpdate: false)
    //         : Get.find<LocationController>().getUserAddress() == null
    //             ? AccessLocationScreen(
    //                 fromSignUp: false, fromHome: false, route: Get.currentRoute)
    //             :
    navigateTo;
  }
}
