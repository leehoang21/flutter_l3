import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/dimensions.dart';
import 'package:timesheet/utils/styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.isObscureText,
    required this.labelText,
    required this.controller,
    this.inputFormatters,
    this.textInputAction,
    this.validator,
    this.suffixIcon,
    this.onChanged,
  });
  final bool isObscureText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final showPass = isObscureText.obs;
    return Obx(
      () => SizedBox(
        height: Dimensions.buttonSize,
        child: TextFormField(
          validator: validator,
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.done,
          inputFormatters: inputFormatters,
          obscureText: showPass.value,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 28.w),
            isDense: true,
            suffixIcon: suffixIcon ??
                (isObscureText
                    ? IconButton(
                        onPressed: () {
                          showPass.value = !showPass.value;
                        },
                        icon: Icon(
                          showPass.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: ColorResources.getAcceptBtn(),
                        ),
                      )
                    : const SizedBox()),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1.w, color: const Color.fromRGBO(244, 244, 244, 1)),
              borderRadius:
                  BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
            ),
            labelText: labelText,
            filled: true,
            fillColor: ColorResources.getGreyBaseGray3(),
            labelStyle: robotoRegular.copyWith(
                color: ColorResources.getPrimaryTextColor()),
          ),
        ),
      ),
    );
  }
}
