import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/data/model/body/user.dart';
import 'package:timesheet/helper/date_converter.dart';
import 'package:timesheet/screen/register/register_screen_contant.dart';
import 'package:timesheet/utils/utils.dart';
import 'package:timesheet/view/appbar_widget.dart';
import 'package:timesheet/view/text_field_widget.dart';

import '../../../utils/color_resources.dart';

class AdminEditUserScreen extends StatefulWidget {
  const AdminEditUserScreen({Key? key}) : super(key: key);

  @override
  State<AdminEditUserScreen> createState() => _AdminEditUserScreenState();
}

class _AdminEditUserScreenState extends State<AdminEditUserScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentstudyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _birthDay = DateTime.now().obs;
  User user = User();

  @override
  void initState() {
    if (Get.arguments != null) {
      user = Get.arguments['user'] as User? ?? User();
    }
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
    return Scaffold(
        appBar: AppBarWidget(title: 'edit_user'.tr),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: [
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
                        margin: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: ColorResources.COLOR_HINT,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 18, 40, 18),
                                child: Text("cancel".tr,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(
                                            191, 252, 226, 1.0))),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _edit();
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 18, 40, 18),
                                child: Text("save".tr,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(
                                            191, 252, 226, 1.0))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _edit() {
    if (_formKey.currentState?.validate() == true) {
      final user = User(
        username: _usernameController.text,
        email: _emailController.text,
        dob: _birthDay.value,
        displayName: '${_firstnameController.text} ${_lastnameController.text}',
        birthPlace: "thai nguyen",
        gender: _genderController.text,
        university: _universityController.text,
        year: int.tryParse(_studentstudyController.text) ?? 1,
      );
      logger(user.toJson());

      Get.find<UserController>()
          .updateUser(user, this.user.id ?? -1)
          .then((value) => {Get.back()});
    }
  }
}
