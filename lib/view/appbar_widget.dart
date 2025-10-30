import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/dimensions.dart';
import 'package:timesheet/utils/styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final String? title;
  final Widget? trailing;

  const AppBarWidget({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      height: preferredSize.height,
      margin: EdgeInsets.only(bottom: top + 20),
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
        padding: const EdgeInsets.only(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  !Navigator.canPop(context)
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const SizedBox(
                            width: 44,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
  Size get preferredSize => const Size.fromHeight(Dimensions.APPBAR_HIGHT_SIZE);
}
