import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.all(12),
      color: ColorResources.getPrimaryColor().withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: data.title,
                  style: robotoBold.copyWith(fontSize: 14),
                ),
                TextSpan(
                  text: data.body,
                  style: robotoRegular.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
          Text(
            data.date == null ? '' : timeagoFormat(data.date!),
            style: robotoRegular.copyWith(
              fontSize: 12,
              color: ColorResources.getGreyBaseGray5(),
            ),
          ),
        ],
      ),
    );
  }
}
