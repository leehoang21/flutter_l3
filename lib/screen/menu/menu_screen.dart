import 'package:flutter/material.dart';
import 'package:timesheet/view/avatar_widget.dart';
import 'package:timesheet/view/scaffold_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return const ScaffoldWidget(
      body: Row(
        children: [
          AvatarWidget(path: null),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
