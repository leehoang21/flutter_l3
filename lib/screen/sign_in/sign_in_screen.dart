import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/images.dart';

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
        builder: (controller) => Opacity(
          opacity: controller.loading ? 0.3 : 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(100, 56, 100, 60),
                child: Image.asset(
                  Images.logo,
                  colorBlendMode: BlendMode.modulate,
                  color: ColorResources.getBackgroundColor(),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  children: [
                    Text(
                      "login_to_your_account".tr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFieldWidget(
                          isObscureText: false,
                          controller: _usernameController,
                          labelText: "username".tr),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          isObscureText: true,
                          controller: _passwordController,
                          labelText: "password".tr,
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          _login();
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                          child: Text("sign_in".tr,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(191, 252, 226, 1.0))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.signUp);
                      },
                      child: Text(
                        'dont_have_account'.tr,
                        style: TextStyle(
                            color: ColorResources.getPrimaryTextColor()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
