import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/utils/styles.dart';
import 'package:timesheet/utils/utils.dart';
import 'package:timesheet/view/avatar_widget.dart';

import '../../controller/localization_controller.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _profile(),
        const SizedBox(height: 20),
        MenuItem(
            icon: const Icon(Icons.edit),
            title: "edit_profile".tr,
            onPressed: () {
              Get.toNamed(RouteHelper.editProfile);
            }),
        _changeTheme(),
        _changeLanguage(),
        MenuItem(
          icon: const Icon(Icons.logout),
          title: "logout".tr,
          onPressed: () async {
            final status = await Get.find<AuthController>().logOut();
            if (status == 200) {
              Get.offAllNamed(RouteHelper.signIn);
            }
          },
        ),
        //exit app
        const SizedBox(height: 10),
        MenuItem(
          icon: const Icon(Icons.exit_to_app),
          title: "exit_app".tr,
          onPressed: () {
            showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('exit_app'.tr),
                content: Text('Are you sure you want to exit?'.tr),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('no'.tr),
                  ),
                  TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: Text('yes'.tr),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _changeTheme() {
    final isDarkMode = Get.isDarkMode.obs;
    return Obx(() => MenuItem(
          icon: const Icon(Icons.dark_mode),
          title: "dark_mode".tr,
          trailing: Switch(
            value: isDarkMode.value,
            onChanged: (bool isActive) {
              Get.changeThemeMode(isActive ? ThemeMode.dark : ThemeMode.light);
              isDarkMode.value = isActive;
            },
          ),
        ));
  }

  Widget _changeLanguage() {
    return GetBuilder<LocalizationController>(
      builder: (controller) {
        return MenuItem(
            icon: const Icon(Icons.language),
            title: "change_language".tr,
            trailing: DropdownButton<Locale>(
              focusColor: Colors.transparent,
              icon: const SizedBox(),
              value: controller.locale,
              items:
                  controller.languages.map<DropdownMenuItem<Locale>>((value) {
                return DropdownMenuItem<Locale>(
                  value: Locale(value.languageCode, value.countryCode),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AvatarWidget(
                        path: value.imageUrl,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "lang_${value.languageCode}".tr,
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue == null) return;
                Get.find<LocalizationController>().setLanguage(newValue);
              },
            ));
      },
    );
  }

  GetBuilder<AuthController> _profile() {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Row(
          children: [
            AvatarWidget(
              path: controller.user.image,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.user.username ?? "",
                  style: robotoBold.copyWith(
                    fontSize: 14,
                  ),
                ),
                if (!isNullEmpty(controller.user.displayName))
                  Text(
                    controller.user.displayName ?? "",
                    style: robotoMedium.copyWith(
                      fontSize: 12,
                    ),
                  ),
                Text(
                  controller.user.email ?? "",
                  style: robotoRegular.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onPressed,
  });
  final Widget icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(title),
            const Spacer(),
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
