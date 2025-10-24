import 'package:flutter/material.dart';

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
            icon: Icon(Icons.home,
                size: 24, color: ColorResources.getPrimaryColor()),
            inactiveIcon:
                const Icon(Icons.home_outlined, size: 24, color: Colors.grey),
          ),
        ),
        TabConfig(
          screen: const MenuScreen(),
          item: ItemConfig(
            icon: Icon(Icons.menu,
                size: 24, color: ColorResources.getPrimaryColor()),
            inactiveIcon: const Icon(Icons.menu, size: 24, color: Colors.grey),
          ),
        ),
      ];
}
