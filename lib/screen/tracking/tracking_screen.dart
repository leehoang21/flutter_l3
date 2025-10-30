import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/view/scaffold_widget.dart';

import '../../controller/tracking_controller.dart';
import 'tracking_screen_contant.dart';
import 'view/tracking_card_item.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: GetBuilder<TrackingController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < controller.trackings.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TrackingCardItem(
                      backgroudColor: TrackingScreenContant.cardColors[
                          i % TrackingScreenContant.cardColors.length],
                      data: controller.trackings[i],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteHelper.saveTracking);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
