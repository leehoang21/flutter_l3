import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/view/appbar_widget.dart';
import 'package:timesheet/view/custom_button.dart';
import 'package:timesheet/view/date_field_widget.dart';
import 'package:timesheet/view/scaffold_widget.dart';
import '../../utils/color_resources.dart';
import '../../view/text_field_widget.dart';
import 'edit_profile_screen_contant.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final DateEditingController _birthdayController = DateEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentstudyController = TextEditingController();

  @override
  void initState() {
    final user = Get.find<AuthController>().user;
    _usernameController.text = user.username ?? '';
    _firstnameController.text = user.displayName?.split(' ').first ?? '';
    _lastnameController.text = user.displayName?.split(' ').length != null &&
            user.displayName!.split(' ').length > 1
        ? user.displayName!.split(' ').sublist(1).join(' ')
        : '';
    _genderController.text = user.gender ?? '';
    _birthdayController.dateTime = user.dob ?? DateTime.now();
    _emailController.text = user.email ?? '';
    _universityController.text = user.university ?? '';
    _studentstudyController.text =
        user.year != null ? user.year.toString() : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBarWidget(title: 'edit_profile'.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: TextFieldWidget(
                validator: EditProfileScreenContant.validateUserName,
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
                validator: EditProfileScreenContant.validateFirstName,
                labelText: "first_name".tr,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: TextFieldWidget(
                controller: _lastnameController,
                textInputAction: TextInputAction.next,
                isObscureText: false,
                validator: EditProfileScreenContant.validateLastName,
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
                validator: EditProfileScreenContant.validateEmail,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 40.w,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 40.h),
                    child: CustomButton(
                      onPressed: () {
                        Get.back();
                      },
                      color: ColorResources.COLOR_HINT,
                      title: "cancel".tr,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 40.h),
                    child: CustomButton(
                      onPressed: () async {
                        Get.find<UserController>().updateMySeft(
                            Get.find<AuthController>().user.copyWith(
                                username: _usernameController.text.trim(),
                                displayName:
                                    '${_firstnameController.text.trim()} ${_lastnameController.text.trim()}',
                                dob: _birthdayController.dateTime,
                                email: _emailController.text.trim(),
                                gender: _genderController.text.trim(),
                                university: _universityController.text.trim(),
                                year: int.tryParse(
                                    _studentstudyController.text.trim())));
                      },
                      title: "save".tr,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
