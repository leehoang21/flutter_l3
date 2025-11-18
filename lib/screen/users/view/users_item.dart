import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/utils/styles.dart';
import 'package:timesheet/view/avatar_widget.dart';
import '../../../data/model/body/user.dart';
import '../../../utils/enum_role.dart';

class UsersItem extends StatelessWidget {
  final User data;

  const UsersItem({super.key, required this.data});

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
            const AvatarWidget(
              path: '',
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
