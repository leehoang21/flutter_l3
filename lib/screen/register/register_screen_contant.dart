import 'package:get/get.dart';

class RegisterContant {
  static String? Function(String?)? validateEmail = (String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required'.tr;
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email'.tr;
    }
    return null;
  };

  static String? Function(String?)? validatePassword = (String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required'.tr;
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters'.tr;
    }
    return null;
  };

  static String? Function(String?, String) validateConfirmPassword =
      (String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required'.tr;
    }
    if (value != password) {
      return 'Passwords do not match'.tr;
    }
    return null;
  };

  static String? Function(String?)? validateUserName = (String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required'.tr;
    }

    return null;
  };

  static String? Function(String?)? validateFirstName = (String? value) {
    if (value == null || value.isEmpty) {
      return 'First Name is required'.tr;
    }

    return null;
  };

  static String? Function(String?)? validateLastName = (String? value) {
    if (value == null || value.isEmpty) {
      return 'Last Name is required'.tr;
    }

    return null;
  };
}
