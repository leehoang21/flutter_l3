import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/view/scaffold_widget.dart';
import 'package:timesheet/view/text_field_widget.dart';

import '../../data/model/body/user.dart';
import '../../utils/debouncer.dart';
import 'view/users_item.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
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
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: Column(
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
                  _pagingController.refresh();
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PagedListView<int, User>(
                padding: EdgeInsets.zero,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<User>(
                  itemBuilder: (context, item, index) => UsersItem(data: item),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
