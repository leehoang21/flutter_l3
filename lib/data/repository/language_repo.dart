import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../model/language_model.dart';

class LanguageRepo extends GetxService {
  List<LanguageModel> getAllLanguages({required BuildContext context}) {
    return AppConstants.languages;
  }
}
