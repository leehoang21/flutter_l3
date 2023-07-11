import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/screen/instruments_and_tools_screen.dart';
import '../controller/auth_controller.dart';
import '../helper/route_helper.dart';
import '../widgets/drawer.dart';
import 'start_screen.dart';

class HomeScreent extends StatefulWidget {
  const HomeScreent({Key? key}) : super(key: key);

  @override
  State<HomeScreent> createState() => _HomeScreentState();
}

class _HomeScreentState extends State<HomeScreent> {
  List<Widget> listWidget = [
    const StartScreen(),
    const InstrumentAndTool(),
    const InstrumentAndTool(),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var index = 0.obs;
  var title = "Trang chủ".obs;

  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().getUser();
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
      drawer: CustomDrawer(logOut: logOut,changePage: changePage,),
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
    Get.find<AuthController>().getUser().then((value) => {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("$value")))
    });
  }

  void changePage(String s){
    navigator?.pop(context);
    title.value = s;
    switch(s){
      case "Trang chủ" : index.value = 0;
      case "Cấp phát CCDC":{
        index.value = 1;
      }
    }
  }
}
