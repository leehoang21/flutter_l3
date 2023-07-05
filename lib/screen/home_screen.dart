import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Center(
          child: Text("home"),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          if (i == 1) {
            print(i);
            logOut();
          }
          setState(() {
            index = i;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Log Out')
        ],
      ),
    );
  }

  void logOut() {
    Get.find<AuthController>().logOut().then((value) => {
      if(value){
        Get.offNamed(RouteHelper.signIn)
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Đã có lỗi xảy ra vui lòng thử lại")))
      }
    });
  }
}
