import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/view/scaffold_widget.dart';
import '../../../view/appbar_widget.dart';
import '../../../view/refresh_widget/refresh_widget.dart';
import 'view/admin_user_item.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBarWidget(
        title: 'admin_panel'.tr,
        leading: const SizedBox(),
        trailing: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Get.find<AuthController>().logOut().then((value) => {
                  Get.offAllNamed(RouteHelper.getSignInRoute()),
                });
          },
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (controller) {
          return RefreshWidget(
            onRefresh: controller.onInit,
            onLoadMore: controller.loadMore,
            child: ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.adminUserDetail, arguments: {
                    'user': controller.users[index],
                  });
                },
                child: UserAdminItem(
                  data: controller.users[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
