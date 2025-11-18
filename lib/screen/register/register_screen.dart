import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/data/model/body/user.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/screen/register/register_screen_contant.dart';
import 'package:timesheet/utils/dimensions.dart';
import 'package:timesheet/utils/images.dart';
import 'package:timesheet/utils/styles.dart';
import 'package:timesheet/utils/utils.dart';
import 'package:timesheet/view/custom_button.dart';
import 'package:timesheet/view/text_field_widget.dart';

import '../../utils/color_resources.dart';
import '../../view/date_field_widget.dart';

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
  final DateEditingController _birthdayController = DateEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentstudyController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: GetBuilder<AuthController>(
        builder: (controller) => Form(
          key: _formKey,
          child: Column(
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
                      'sign_up_to_your_account'.tr,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: TextFieldWidget(
                        validator: RegisterContant.validateUserName,
                        controller: _usernameController,
                        textInputAction: TextInputAction.next,
                        isObscureText: false,
                        labelText: "username".tr,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: TextFieldWidget(
                        controller: _firstnameController,
                        textInputAction: TextInputAction.next,
                        isObscureText: false,
                        validator: RegisterContant.validateFirstName,
                        labelText: "first_name".tr,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: TextFieldWidget(
                        controller: _lastnameController,
                        textInputAction: TextInputAction.next,
                        isObscureText: false,
                        validator: RegisterContant.validateLastName,
                        labelText: "last_name".tr,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: TextFieldWidget(
                        controller: _genderController,
                        textInputAction: TextInputAction.next,
                        isObscureText: false,
                        labelText: "gender".tr,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: DateFieldWidget(
                        controller: _birthdayController,
                        labelText: "birthday".tr,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: TextFieldWidget(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        isObscureText: false,
                        validator: RegisterContant.validateEmail,
                        labelText: "email".tr,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: TextFieldWidget(
                        controller: _universityController,
                        textInputAction: TextInputAction.next,
                        isObscureText: false,
                        labelText: "university".tr,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
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
                        margin: EdgeInsets.only(top: 20.h),
                        child: TextFieldWidget(
                          isObscureText: true,
                          controller: _passwordController,
                          labelText: "password".tr,
                          validator: RegisterContant.validatePassword,
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 20.h),
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
                      margin: EdgeInsets.only(top: 40.h),
                      child: CustomButton(
                        onPressed: () {
                          _register();
                        },
                        title: "sign_up".tr,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.signIn);
                      },
                      child: Text(
                        'already_account'.tr,
                        style: robotoMedium.copyWith(
                            color: ColorResources.getPrimaryTextColor()),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
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
        dob: _birthdayController.dateTime,
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
