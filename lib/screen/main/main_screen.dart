import 'package:flutter/material.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/dimensions.dart';
import 'package:timesheet/view/scaffold_widget.dart';

import 'main_screen_contant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: MainScreenConstants.tabs.length,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MainScreenConstants.tabs.length,
      child: ScaffoldWidget(
        appBar: AppBarMain(
          tabController: _tabController,
        ),
        body: TabBarView(
          controller: _tabController,
          children: MainScreenConstants.tabs.map((e) => e.screen).toList(),
        ),
      ),
    );
  }
}

class AppBarMain extends StatelessWidget implements PreferredSize {
  const AppBarMain({
    super.key,
    required this.tabController,
  });
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: ColorResources.getAppbarColor(),
        boxShadow: [
          BoxShadow(
            color: ColorResources.getBackgroundCardColor().withOpacity(0.2),
            offset: const Offset(2, 0),
            blurRadius: 4,
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        tabs: MainScreenConstants.tabs
            .asMap()
            .entries
            .map(
              (e) => Tab(
                icon: tabController.index == e.key
                    ? e.value.item.icon
                    : e.value.item.inactiveIcon,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => const Size.fromHeight(Dimensions.APPBAR_HIGHT_SIZE);
}
