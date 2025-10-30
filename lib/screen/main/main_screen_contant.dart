import 'package:flutter/material.dart';
import 'package:timesheet/screen/notification/notification_screen.dart';
import 'package:timesheet/screen/tracking/tracking_screen.dart';
import 'package:timesheet/screen/users/users_screen.dart';
import 'package:timesheet/utils/images.dart';

import '../../utils/color_resources.dart';
import '../home/home_screen.dart';
import '../menu/menu_screen.dart';

class TabConfig {
  final Widget screen;
  final ItemConfig item;

  TabConfig({
    required this.screen,
    required this.item,
  });
}

class ItemConfig {
  final Widget icon;
  final Widget inactiveIcon;

  ItemConfig({
    required this.icon,
    required this.inactiveIcon,
  });
}

class MainScreenConstants {
  static List<TabConfig> get tabs => [
        TabConfig(
          screen: const HomeScreen(),
          item: ItemConfig(
            icon: Icon(Icons.home, color: ColorResources.getPrimaryColor()),
            inactiveIcon: const Icon(Icons.home, color: Colors.grey),
          ),
        ),
        TabConfig(
          screen: const UsersScreen(),
          item: ItemConfig(
            icon: Icon(Icons.people, color: ColorResources.getPrimaryColor()),
            inactiveIcon: const Icon(Icons.people, color: Colors.grey),
          ),
        ),
        TabConfig(
          screen: const TrackingScreen(),
          item: ItemConfig(
            icon: Image.asset(Images.tracking,
                color: ColorResources.getPrimaryColor()),
            inactiveIcon: Image.asset(Images.tracking, color: Colors.grey),
          ),
        ),
        TabConfig(
          screen: const NotificationsScreen(),
          item: ItemConfig(
            icon: Icon(Icons.notifications,
                color: ColorResources.getPrimaryColor()),
            inactiveIcon: const Icon(Icons.notifications, color: Colors.grey),
          ),
        ),
        TabConfig(
          screen: const MenuScreen(),
          item: ItemConfig(
            icon: Icon(Icons.menu, color: ColorResources.getPrimaryColor()),
            inactiveIcon: const Icon(Icons.menu, color: Colors.grey),
          ),
        ),
      ];
}
