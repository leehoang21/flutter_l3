import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/styles.dart';
import '../../../data/model/body/notification_model.dart';
import '../../../utils/time_ago_utils.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.data});
  final NotificationModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      color: ColorResources.getPrimaryColor().withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: data.title,
                  style: robotoBold,
                ),
                TextSpan(
                  text: data.body,
                  style: robotoRegular,
                ),
              ],
            ),
          ),
          Text(
            data.date == null ? '' : timeagoFormat(data.date!),
            style: robotoRegular.copyWith(
              fontSize: 12.sp,
              color: ColorResources.getGreyBaseGray5(),
            ),
          ),
        ],
      ),
    );
  }
}
