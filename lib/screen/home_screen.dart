import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/screen/instruments_and_tools_screen.dart';

import '../controller/auth_controller.dart';
import '../helper/route_helper.dart';
import '../widgets/drawer.dart';
import 'start_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> listWidget = [
    const StartScreen(),
    const InstrumentAndTool(),
    const InstrumentAndTool(),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var index = 0.obs;
  var title = "home".obs;

  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xff7377c5),
        title: Obx(() => Text(title.value)),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Obx(() => listWidget[index.value]),
      drawer: CustomDrawer(
        logOut: logOut,
        changePage: (p0) => changePage(p0),
      ),
    );
  }

  void logOut() {
    Get.find<AuthController>().logOut().then((value) => {
      if(value == 200){
        Get.offNamed(RouteHelper.signIn)
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Đã có lỗi xảy ra vui lòng thử lại")))
      }
    });
  }
  void getUser(){
    Get.find<AuthController>().getCurrentUser().then((value) => {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("$value")))
        });
  }

  void changePage(String s){
    navigator?.pop(context);
    title.value = s.tr;
    switch (s) {
      case "home":
        index.value = 0;
      case "Cấp phát CCDC":
        {
          index.value = 1;
        }
    }
  }
}
