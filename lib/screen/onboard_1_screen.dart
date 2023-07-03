import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/route_helper.dart';
import '../utils/images.dart';

class OnboardOneScreen extends StatefulWidget {
  const OnboardOneScreen({Key? key}) : super(key: key);

  @override
  State<OnboardOneScreen> createState() => _OnboardOneScreenState();
}

class _OnboardOneScreenState extends State<OnboardOneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Scrollbar(
      child: SingleChildScrollView(
        child: Column(children: [
          Image.asset(Images.onboard_1),
          Container(
              margin: const EdgeInsets.only(top: 40),
              child: const Text("Find you Comfort\nFood here",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, height: 1.3),
                  textAlign: TextAlign.center)),
          Container(
            margin: const EdgeInsets.fromLTRB(64, 20, 64, 0),
            child: const Text(
              "Here You Can find a chef or dish for every taste and color. Enjoy!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, height: 1.3),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: ElevatedButton(
              onPressed: () {
                Get.offNamed(RouteHelper.onBoarding2);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 18, 40, 18),
                child: Text("Next", style: TextStyle(fontSize: 16)),
              ),
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
              ),
            ),
          )
        ]),
      ),
    )));
  }
}
