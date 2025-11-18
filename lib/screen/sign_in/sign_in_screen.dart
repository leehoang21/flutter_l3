import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/dimensions.dart';
import 'package:timesheet/utils/images.dart';
import 'package:timesheet/view/custom_button.dart';

import '../../utils/styles.dart';
import '../../view/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: GetBuilder<AuthController>(
        builder: (controller) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(100.w, 56.h, 100.w, 60.h),
              child: Image.asset(
                Images.logo,
                colorBlendMode: BlendMode.modulate,
                color: ColorResources.getBackgroundColor(),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Column(
                children: [
                  Text(
                    "login_to_your_account".tr,
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.h),
                    child: TextFieldWidget(
                        isObscureText: false,
                        controller: _usernameController,
                        labelText: "username".tr),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: TextFieldWidget(
                        isObscureText: true,
                        controller: _passwordController,
                        labelText: "password".tr,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 40.h),
                    child: CustomButton(
                      onPressed: () {
                        _login();
                      },
                      title: "sign_in".tr,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.signUp);
                    },
                    child: Text('dont_have_account'.tr,
                        style: robotoMedium.copyWith(
                            color: ColorResources.getPrimaryTextColor())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      final snackBar = SnackBar(
        content: Text('you_need_password'.tr),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Get.find<AuthController>().login(username, password).then((value) => {
            if (value.$1 == 200)
              {Get.offAllNamed(RouteHelper.getMainRoute(value.$2.roles ?? []))}
            else if (value.$1 == 400)
              {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('login_error'.tr)))
              }
            else
              {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('error_occurred'.tr)))
              },
          });
    }
  }
}
