import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/dimensions.dart';
import 'package:timesheet/utils/styles.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final double? width;
  final double? height;
  final Color? color;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 1.h,
          ),
          backgroundColor: color ?? ColorResources.getPrimaryColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
            ),
          ),
          maximumSize: Size.infinite,
          minimumSize: Size(width ?? 1.sw, height ?? Dimensions.buttonSize),
          elevation: 0,
        ),
        child: Text(
          title,
          style: robotoMedium.copyWith(
            color: Colors.white,
          ),
        ));
  }
}
