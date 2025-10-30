import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/helper/date_converter.dart';
import 'package:timesheet/view/appbar_widget.dart';
import 'package:timesheet/view/avatar_widget.dart';
import 'package:timesheet/view/card_widget.dart';
import 'package:timesheet/view/scaffold_widget.dart';

import '../../../data/model/body/user.dart';

class AdminUserDetailScreen extends StatefulWidget {
  const AdminUserDetailScreen({Key? key}) : super(key: key);

  @override
  State<AdminUserDetailScreen> createState() => _AdminUserDetailScreenState();
}

class _AdminUserDetailScreenState extends State<AdminUserDetailScreen> {
  User user = User();

  @override
  void initState() {
    if (Get.arguments != null) {
      user = Get.arguments['user'] as User? ?? User();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
        appBar: AppBarWidget(title: 'user_detail'.tr),
        body: SingleChildScrollView(
          child: CardWidget(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const AvatarWidget(path: ''),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              user.username ?? '',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: user.active == true
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                user.active == true
                                    ? 'active'.tr
                                    : 'inactive'.tr,
                                style: const TextStyle(),
                              ),
                            )
                          ],
                        ),
                        Text(user.email ?? ""),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CardWidget(
                    child: Column(
                  children: [
                    ListTile(
                      title: Text('display_name'.tr),
                      subtitle: Text(user.displayName ?? ''),
                    ),
                    ListTile(
                      title: Text('email'.tr),
                      subtitle: Text(user.email ?? ''),
                    ),
                    ListTile(
                      title: Text('dob'.tr),
                      subtitle: Text(user.dob != null
                          ? DateConverter.formatToDate(user.dob!)
                          : 'none_updated'.tr),
                    ),
                    ListTile(
                      title: Text('gender'.tr),
                      subtitle: Text(user.gender ?? 'none_updated'.tr),
                    ),
                    ListTile(
                      title: Text('year'.tr),
                      subtitle: Text(user.year == null
                          ? 'none_updated'.tr
                          : user.year.toString()),
                    ),
                    ListTile(
                      title: Text('birth_place'.tr),
                      subtitle: Text(user.birthPlace ?? 'none_updated'.tr),
                    ),
                    ListTile(
                      title: Text('username'.tr),
                      subtitle: Text(user.username ?? 'none_updated'.tr),
                    ),
                    ListTile(
                      title: Text('roles'.tr),
                      subtitle: Text((user.roles ?? [])
                          .map((e) => e.name)
                          .join(', ')
                          .trim()),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ));
  }
}
