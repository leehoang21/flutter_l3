import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/dimensions.dart';
import 'package:timesheet/utils/styles.dart';

import '../helper/date_converter.dart';

class DateEditingController extends TextEditingController {
  DateTime _dateTime = DateTime.now();

  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
    text = DateConverter.formatToDate(dateTime);
  }

  DateTime get dateTime => _dateTime;
}

class DateFieldWidget extends StatelessWidget {
  const DateFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.onChanged,
  });
  final DateEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.buttonSize,
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        style: robotoRegular.copyWith(color: ColorResources.getTextColor()),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: controller.dateTime,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            controller.dateTime = pickedDate;
          }
        },
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 28.w),
          isDense: true,
          suffixIcon: Icon(
            Icons.calendar_month_outlined,
            color: ColorResources.getAcceptBtn(),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1.w, color: const Color.fromRGBO(244, 244, 244, 1)),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
          ),
          labelText: labelText,
          filled: true,
          fillColor: ColorResources.getGreyBaseGray3(),
          labelStyle: robotoRegular.copyWith(
              color: ColorResources.getPrimaryTextColor()),
        ),
      ),
    );
  }
}
