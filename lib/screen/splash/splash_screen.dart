import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/view/scaffold_widget.dart';
import '../../controller/auth_controller.dart';
import '../../helper/route_helper.dart';
import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _route();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Images.logo,
              width: 200.w,
              colorBlendMode: BlendMode.modulate,
              color: ColorResources.getBackgroundColor(),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          ],
        ),
      ),
    );
  }

  _route() {
    Get.find<AuthController>().getCurrentUser().then((value) => {
          if (value != null)
            {
              Get.offAllNamed(RouteHelper.getMainRoute(value.roles ?? [])),
            }
          else
            {Get.offAllNamed(RouteHelper.signIn)}
        });
  }
}
