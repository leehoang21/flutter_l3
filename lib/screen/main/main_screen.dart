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
        body: Column(
          children: [
            AppBarMain(
              tabController: _tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:
                    MainScreenConstants.tabs.map((e) => e.screen).toList(),
              ),
            ),
          ],
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
    return TabBar(
      controller: tabController,
      indicator:
          const DotIndicator(color: ColorResources.COLOR_PRIMARY, radius: 2),
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
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => const Size.fromHeight(Dimensions.APPBAR_HIGHT_SIZE);
}

class DotIndicator extends Decoration {
  final Color color;
  final double radius;

  const DotIndicator({
    required this.color,
    this.radius = 3,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DotPainter(color: color, radius: radius);
  }
}

class _DotPainter extends BoxPainter {
  final Color color;
  final double radius;

  _DotPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Paint paint = Paint()
      ..color = color
      ..isAntiAlias = true;

    final Offset circleOffset = Offset(
      offset.dx + cfg.size!.width / 2,
      offset.dy + cfg.size!.height - radius * 1.5, // vị trí chấm dưới cùng
    );

    canvas.drawCircle(circleOffset, radius, paint);
  }
}
