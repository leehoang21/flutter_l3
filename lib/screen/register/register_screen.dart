import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/data/model/body/user.dart';
import 'package:timesheet/helper/date_converter.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/screen/register/register_screen_contant.dart';
import 'package:timesheet/utils/images.dart';
import 'package:timesheet/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentstudyController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _showPass = false.obs;
  final _confirmShowPass = false.obs;

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
              child: Form(
                key: _formKey,
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
                              'sign_up_to_your_account'.tr,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                validator: RegisterContant.validateUserName,
                                controller: _usernameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 28),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "user_name".tr,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                validator: RegisterContant.validateFirstName,
                                controller: _firstnameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 28),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "first_name".tr,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                validator: RegisterContant.validateLastName,
                                controller: _lastnameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 28),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "last_name".tr,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _genderController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 28),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "gender".tr,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _birthdayController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          // Show date picker
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                          ).then((selectedDate) {
                                            if (selectedDate != null) {
                                              _birthdayController.text =
                                                  DateConverter
                                                      .dateToDateAndTimeAm(
                                                          selectedDate);
                                            }
                                          });
                                        },
                                        child:
                                            const Icon(Icons.calendar_today)),
                                    contentPadding:
                                        const EdgeInsets.only(left: 28),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "birthday".tr,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                validator: RegisterContant.validateEmail,
                                controller: _emailController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 28),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "email".tr,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _universityController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 28),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "university".tr,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                controller: _studentstudyController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 28),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: "year_study".tr,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Obx(
                                  () => TextFormField(
                                    validator: RegisterContant.validatePassword,
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        hintText: "password".tr,
                                        hintStyle: const TextStyle(
                                            color: Colors.grey)),
                                  ),
                                )),
                            Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Obx(
                                  () => TextFormField(
                                    validator: (value) {
                                      return RegisterContant
                                          .validateConfirmPassword(
                                              value, _passwordController.text);
                                    },
                                    textInputAction: TextInputAction.done,
                                    obscureText: _confirmShowPass.value,
                                    controller: _confirmPasswordController,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(left: 28),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            _confirmShowPass.value =
                                                !_confirmShowPass.value;
                                          },
                                          icon: Icon(_confirmShowPass.value
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  244, 244, 244, 1)),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        hintText: "confirm_password".tr,
                                        hintStyle: const TextStyle(
                                            color: Colors.grey)),
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
                                  child: Text("sign_up".tr,
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
                                Get.toNamed(RouteHelper.signIn);
                              },
                              child: Text(
                                'already_account'.tr,
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
          ),
        ));
  }

  _login() {
    if (_formKey.currentState?.validate() == true) {
      final user = User(
        username: _usernameController.text,
        firstName: _firstnameController.text,
        lastName: _lastnameController.text,
        email: _emailController.text,
        dob: _birthdayController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        displayName: "oceantech",
        birthPlace: "thai nguyen",
        gender: _genderController.text,
        university: _universityController.text,
        year: int.tryParse(_studentstudyController.text) ?? 1,
      );
      logger(user.toJson());

      Get.find<AuthController>().register(user).then((value) => {
            if (value == 200)
              {Get.toNamed(RouteHelper.main)}
            else
              {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('error_occurred'.tr)))
              },
          });
    }
  }
}
