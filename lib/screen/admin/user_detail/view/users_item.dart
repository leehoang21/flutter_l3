import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/view/avatar_widget.dart';
import '../../../../../data/model/body/user.dart';

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
        Row(
          children: [
            const AvatarWidget(
              path: '',
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.displayName ?? ''),
                Text(
                  data.email ?? "",
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            role != '' ? role : 'none'.tr,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            data.active == true ? 'active'.tr : 'inactive'.tr,
            style: TextStyle(
              color: data.active == true ? Colors.green : Colors.red,
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
