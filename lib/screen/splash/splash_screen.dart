import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/view/scaffold_widget.dart';
import '../../controller/auth_controller.dart';
import '../../controller/splash_controller.dart';
import '../../helper/route_helper.dart';
import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../../view/no_internet_screen.dart';

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
      body: GetBuilder<SplashController>(builder: (splashController) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: splashController.hasConnection
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Images.logo,
                        width: 200,
                        colorBlendMode: BlendMode.modulate,
                        color: ColorResources.getBackgroundColor(),
                      ),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    ],
                  )
                : const NoInternetScreen(child: SplashScreen()),
          ),
        );
      }),
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
