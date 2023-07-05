import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/route_helper.dart';
import '../utils/images.dart';

class OnboardTwoScreen extends StatefulWidget {
  const OnboardTwoScreen({Key? key}) : super(key: key);

  @override
  State<OnboardTwoScreen> createState() => _OnboardTwoScreenState();
}

class _OnboardTwoScreenState extends State<OnboardTwoScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return   Scaffold(
              body: Center(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Container(
                          height: 400,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Images.background_sign_in),
                                  fit: BoxFit.fill)),
                        ),
                        // Image.asset(Images.onboard_2),
                        Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: const Text("Food Ninja is Where Your\n Comfort Food Lives",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold, height: 1.3),
                                textAlign: TextAlign.center)),
                        Container(
                          margin: const EdgeInsets.fromLTRB(64, 20, 64, 0),
                          child: const Text(
                            "Enjoy a fast and smooth food delivery at your doorstep",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, height: 1.3),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.offNamed(RouteHelper.signIn);
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
        },);


  }
}
