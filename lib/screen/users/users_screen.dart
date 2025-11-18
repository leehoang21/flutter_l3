import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/view/scaffold_widget.dart';
import 'package:timesheet/view/text_field_widget.dart';
import '../../utils/debouncer.dart';
import '../../view/refresh_widget/refresh_widget.dart';
import 'view/users_item.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: [
          _appbar(),
          Expanded(
            child: GetBuilder<UserController>(
              builder: (controller) {
                return RefreshWidget(
                  onRefresh: controller.onInit,
                  onLoadMore: controller.loadMore,
                  child: ListView.builder(
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      return UsersItem(data: controller.users[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _appbar() {
    return Column(
      children: [
        TextFieldWidget(
          isObscureText: false,
          labelText: 'Search'.tr,
          controller: TextEditingController(),
          onChanged: (value) {
            Debouncer(
              milliseconds: 1000,
            ).run(() {
              Get.find<UserController>().search(value);
            });
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
