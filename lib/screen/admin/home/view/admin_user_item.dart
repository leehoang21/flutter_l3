import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/utils/enum_role.dart';
import 'package:timesheet/view/avatar_widget.dart';

import '../../../../data/model/body/user.dart';
import '../../../../helper/route_helper.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/styles.dart';

class UserAdminItem extends StatelessWidget {
  final User data;
  final PagingController<int, User> pagingController;

  const UserAdminItem(
      {super.key, required this.data, required this.pagingController});

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
                Text(data.username ?? ''),
                Text(
                  data.email ?? "",
                ),
              ],
            ),
            const Spacer(),
            MenuAnchor(
              style: MenuStyle(
                backgroundColor: MaterialStateProperty.all(
                    ColorResources.getBackgroundCardColor()),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  ),
                ),
              ),
              builder: (context, controller, child) {
                return IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                  onPressed: () {
                    controller.open();
                  },
                );
              },
              menuChildren: [
                MenuItemButton(
                  onPressed: () async {
                    await Get.toNamed(RouteHelper.adminEditUser, arguments: {
                      'user': data,
                    });
                    pagingController.refresh();
                  },
                  child: Text(
                    'edit'.tr,
                    style: robotoRegular.copyWith(
                      fontSize: 14,
                      color: ColorResources.getCardTextColor(),
                    ),
                  ),
                ),
                MenuItemButton(
                  onPressed: () async {
                    if (data.id != null && data.id! > 0) {
                      await Get.find<UserController>().lock(data.id!);
                      pagingController.refresh();
                    }
                  },
                  child: Text(
                    'lock'.tr,
                    style: robotoRegular.copyWith(
                      fontSize: 14,
                      color: ColorResources.getCardTextColor(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            role != '' ? EnumRoleExtension.fromString(role).name.tr : 'none'.tr,
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
