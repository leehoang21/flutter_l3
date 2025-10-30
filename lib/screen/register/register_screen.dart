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
import 'package:timesheet/view/text_field_widget.dart';

import '../../utils/color_resources.dart';

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
  final _birthDay = DateTime.now().obs;

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
          child: Form(
            key: _formKey,
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
                        'sign_up_to_your_account'.tr,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          validator: RegisterContant.validateUserName,
                          controller: _usernameController,
                          textInputAction: TextInputAction.next,
                          isObscureText: false,
                          labelText: "username".tr,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          controller: _firstnameController,
                          textInputAction: TextInputAction.next,
                          isObscureText: false,
                          validator: RegisterContant.validateFirstName,
                          labelText: "first_name".tr,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          controller: _lastnameController,
                          textInputAction: TextInputAction.next,
                          isObscureText: false,
                          validator: RegisterContant.validateLastName,
                          labelText: "last_name".tr,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          controller: _genderController,
                          textInputAction: TextInputAction.next,
                          isObscureText: false,
                          labelText: "gender".tr,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          controller: _birthdayController,
                          textInputAction: TextInputAction.next,
                          isObscureText: false,
                          labelText: "birthday".tr,
                          suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _birthDay.value,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                _birthDay.value = pickedDate;
                                _birthdayController.text =
                                    DateConverter.formatToDate(pickedDate);
                              }
                            },
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: ColorResources.getAcceptBtn(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          isObscureText: false,
                          validator: RegisterContant.validateEmail,
                          labelText: "email".tr,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          controller: _universityController,
                          textInputAction: TextInputAction.next,
                          isObscureText: false,
                          labelText: "university".tr,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1),
                          ],
                          controller: _studentstudyController,
                          textInputAction: TextInputAction.next,
                          isObscureText: false,
                          labelText: "student_study_year".tr,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFieldWidget(
                            isObscureText: true,
                            controller: _passwordController,
                            labelText: "password".tr,
                            validator: RegisterContant.validatePassword,
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFieldWidget(
                            isObscureText: true,
                            controller: _confirmPasswordController,
                            labelText: "confirm_password".tr,
                            validator: (value) {
                              return RegisterContant.validateConfirmPassword(
                                  value, _passwordController.text);
                            },
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: ElevatedButton(
                          onPressed: () {
                            _register();
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                            child: Text("sign_up".tr,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(191, 252, 226, 1.0))),
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
      ),
    ));
  }

  _register() {
    if (_formKey.currentState?.validate() == true) {
      final user = User(
        username: _usernameController.text,
        email: _emailController.text,
        dob: _birthDay.value,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        displayName: '${_firstnameController.text} ${_lastnameController.text}',
        birthPlace: "thai nguyen",
        gender: _genderController.text,
        university: _universityController.text,
        year: int.tryParse(_studentstudyController.text) ?? 1,
      );
      logger(user.toJson());

      Get.find<AuthController>().register(user).then((value) => {
            if (value == 200)
              {Get.offAllNamed(RouteHelper.getSignInRoute())}
            else
              {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('error_occurred'.tr)))
              },
          });
    }
  }
}
