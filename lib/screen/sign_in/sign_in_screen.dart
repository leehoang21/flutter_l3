import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/utils/images.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _showPass = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: GetBuilder<AuthController>(
            builder: (controller) => Opacity(
              opacity: controller.loading ? 0.3 : 1,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(100, 56, 100, 60),
                      color: Colors.white,
                      child: Image.asset(Images.logo),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Column(
                        children: [
                          Text(
                            "login_to_your_account".tr,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: _usernameController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 28),
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color:
                                              Color.fromRGBO(244, 244, 244, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  hintText: "email".tr,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Obx(
                                () => TextFormField(
                                  textInputAction: TextInputAction.done,
                                  obscureText: _showPass.value,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(left: 28),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _showPass.value = !_showPass.value;
                                        },
                                        icon: Icon(_showPass.value
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      hintText: "password".tr,
                                      hintStyle:
                                          const TextStyle(color: Colors.grey)),
                                ),
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
                                padding:
                                    const EdgeInsets.fromLTRB(40, 18, 40, 18),
                                child: Text("sign_in".tr,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(
                                            191, 252, 226, 1.0))),
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
                              style: const TextStyle(
                                  color: Color.fromRGBO(0, 123, 255, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Bạn cần điền đầy đủ tài khoản mật khẩu.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Get.find<AuthController>().login(username, password).then((value) => {
            if (value == 200)
              {Get.toNamed(RouteHelper.main)}
            else if (value == 400)
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
