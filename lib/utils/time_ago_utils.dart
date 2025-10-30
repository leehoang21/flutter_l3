import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../controller/localization_controller.dart';

String timeagoFormat(DateTime dateTime) {
  return timeago.format(dateTime,
      locale:
          '${Get.find<LocalizationController>().locale.languageCode}_short');
}
