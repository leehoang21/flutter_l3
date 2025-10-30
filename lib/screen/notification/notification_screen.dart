import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/notification_controller.dart';

import 'view/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (controller) {
        return ListView(
          children: [
            for (final noti in controller.notifications)
              NotificationItem(data: noti),
          ],
        );
      },
    );
  }
}
