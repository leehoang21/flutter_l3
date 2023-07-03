import 'package:get/get.dart';

import '../../helper/route_helper.dart';
import '../../view/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      // Get.find<AuthController>().clearSharedData();
      // Get.find<WishListController>().removeWishes();
      Get.offAllNamed(RouteHelper.getSignInRoute());
    } else {
      showCustomSnackBar(response.statusText ?? "error");
    }
  }
}
