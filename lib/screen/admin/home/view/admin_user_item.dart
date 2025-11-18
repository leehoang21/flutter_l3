import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/utils/enum_role.dart';
import 'package:timesheet/view/avatar_widget.dart';

import '../../../../data/model/body/user.dart';
import '../../../../helper/route_helper.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/styles.dart';

class UserAdminItem extends StatelessWidget {
  final User data;

  const UserAdminItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final role = (data.roles ?? []).map((e) => e.name).join(', ').trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            AvatarWidget(
              path: '',
              size: 50.sp,
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.username ?? '',
                  style: robotoBold,
                ),
                Text(
                  data.email ?? "",
                  style: robotoRegular,
                ),
              ],
            ),
            const Spacer(),
            MenuAnchor(
              style: MenuStyle(
                backgroundColor: MaterialStateProperty.all(
                    ColorResources.getBackgroundCardColor()),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  ),
                ),
              ),
              builder: (context, controller, child) {
                return IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                  onPressed: () {
                    controller.open();
                  },
                );
              },
              menuChildren: [
                MenuItemButton(
                  onPressed: () async {
                    await Get.toNamed(RouteHelper.adminEditUser, arguments: {
                      'user': data,
                    });
                  },
                  child: Text(
                    'edit'.tr,
                    style: robotoRegular.copyWith(
                      fontSize: 14,
                      color: ColorResources.getCardTextColor(),
                    ),
                  ),
                ),
                MenuItemButton(
                  onPressed: () async {
                    if (data.id != null && data.id! > 0) {
                      await Get.find<UserController>().lock(data.id!);
                    }
                  },
                  child: Text(
                    'lock'.tr,
                    style: robotoRegular.copyWith(
                      fontSize: 14,
                      color: ColorResources.getCardTextColor(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.h),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${'role'.tr} : ',
                style: robotoMedium,
              ),
              TextSpan(
                text: role != ''
                    ? EnumRoleExtension.fromString(role).name.tr
                    : 'none'.tr,
                style: robotoRegular,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${"status".tr} : ',
                style: robotoMedium,
              ),
              TextSpan(
                text: data.active == true ? 'active'.tr : 'inactive'.tr,
                style: robotoRegular.copyWith(
                  color: data.active == true ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
