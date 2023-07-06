import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/data/model/body/user.dart';

import '../controller/auth_controller.dart';
import '../helper/route_helper.dart';

class HomeScreent extends StatefulWidget {
  const HomeScreent({Key? key}) : super(key: key);

  @override
  State<HomeScreent> createState() => _HomeScreentState();
}

class _HomeScreentState extends State<HomeScreent> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<AuthController>(
                builder: (controller) => Text(controller.user.email ?? ""),
              ),
              ElevatedButton(
                  onPressed: logOut,
                  child: Text("Đăng xuất")
              )
            ],
          )
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          if (i == 1) {
            getUser();
          }
          setState(() {
            index = i;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Get user')
        ],
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
    Get.find<AuthController>().getUser().then((value) => {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("$value")))
    });
  }
}
