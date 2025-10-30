import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/view/scaffold_widget.dart';

import '../../../data/model/body/user.dart';
import '../../../view/appbar_widget.dart';
import 'view/admin_user_item.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      final result = await Get.find<UserController>().loadMore(pageKey + 1);
      if (Get.find<UserController>().isLast.value) {
        _pagingController.appendLastPage(result);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(result, nextPageKey);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBarWidget(
        title: 'admin_panel'.tr,
        trailing: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Get.find<AuthController>().logOut().then((value) => {
                  Get.offAllNamed(RouteHelper.getSignInRoute()),
                });
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, User>(
          padding: EdgeInsets.zero,
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<User>(
            itemBuilder: (context, item, index) => InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.adminUserDetail, arguments: {
                    'user': item,
                  });
                },
                child: UserAdminItem(
                    data: item, pagingController: _pagingController)),
          ),
        ),
      ),
    );
  }
}
