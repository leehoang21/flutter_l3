import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/dimensions.dart';
import 'package:timesheet/utils/styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final String? title;
  final Widget? trailing;
  final Widget? leading;

  const AppBarWidget(
      {super.key, required this.title, this.trailing, this.leading});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: ColorResources.getAppbarColor(),
        boxShadow: [
          BoxShadow(
            color: ColorResources.getBackgroundCardColor().withOpacity(0.2),
            offset: const Offset(2, 0),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  leading ??
                      (!Navigator.canPop(context)
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: SizedBox(
                                width: 44.w,
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                  Text(title ?? '',
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        color: Colors.white,
                      )),
                  const Spacer(),
                  trailing ?? const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => Size.fromHeight(Dimensions.APPBAR_HIGHT_SIZE);
}
