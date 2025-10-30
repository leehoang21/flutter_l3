import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/view/appbar_widget.dart';
import 'package:timesheet/view/scaffold_widget.dart';

import '../../helper/date_converter.dart';
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
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentstudyController = TextEditingController();
  final _birthDay = DateTime.now().obs;

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
    _birthDay.value = user.dob != null ? user.dob! : DateTime.now();
    _birthdayController.text =
        user.dob != null ? DateConverter.formatToDate(user.dob!) : '';
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
              margin: const EdgeInsets.only(top: 20),
              child: TextFieldWidget(
                validator: EditProfileScreenContant.validateUserName,
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
                validator: EditProfileScreenContant.validateFirstName,
                labelText: "first_name".tr,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: TextFieldWidget(
                controller: _lastnameController,
                textInputAction: TextInputAction.next,
                isObscureText: false,
                validator: EditProfileScreenContant.validateLastName,
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
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: ColorResources.COLOR_HINT,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                      child: Text("cancel".tr,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(191, 252, 226, 1.0))),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.find<UserController>().updateMySeft(
                          Get.find<AuthController>().user.copyWith(
                              username: _usernameController.text.trim(),
                              displayName:
                                  '${_firstnameController.text.trim()} ${_lastnameController.text.trim()}',
                              dob: _birthDay.value,
                              email: _emailController.text.trim(),
                              gender: _genderController.text.trim(),
                              university: _universityController.text.trim(),
                              year: int.tryParse(
                                  _studentstudyController.text.trim())));
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                      child: Text("save".tr,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(191, 252, 226, 1.0))),
                    ),
                  ),
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
