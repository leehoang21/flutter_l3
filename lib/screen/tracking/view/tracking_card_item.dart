import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/tracking_controller.dart';
import 'package:timesheet/helper/date_converter.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/dimensions.dart';

import '../../../data/model/body/tracking_model.dart';
import '../../../utils/styles.dart';

class TrackingCardItem extends StatelessWidget {
  const TrackingCardItem({
    super.key,
    required this.data,
    required this.backgroudColor,
  });
  final TrackingModel data;
  final Color backgroudColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: backgroudColor, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.RADIUS_LARGE),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
                color: backgroudColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT),
                  topRight: Radius.circular(Dimensions.RADIUS_DEFAULT),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${data.id ?? '0'}',
                  style: robotoBold.copyWith(
                    fontSize: 16,
                    color: ColorResources.getCardTextColor(),
                  ),
                ),
                MenuAnchor(
                  style: MenuStyle(
                    backgroundColor: MaterialStateProperty.all(backgroudColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                      ),
                    ),
                  ),
                  builder: (context, controller, child) {
                    return IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: ColorResources.getCardTextColor(),
                      ),
                      onPressed: () {
                        controller.open();
                      },
                    );
                  },
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {
                        Get.toNamed(RouteHelper.saveTracking, arguments: {
                          'tracking': data,
                        });
                      },
                      child: Text(
                        'edit'.tr,
                        style: robotoRegular.copyWith(
                          fontSize: 14,
                          color: ColorResources.getCardTextColor(),
                        ),
                      ),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        if (data.id != null && data.id! > 0) {
                          Get.find<TrackingController>().delete(data.id!);
                        }
                      },
                      child: Text(
                        'delete'.tr,
                        style: robotoRegular.copyWith(
                          fontSize: 14,
                          color: ColorResources.getCardTextColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
                color: ColorResources.getBackgroundCardColor(),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT),
                  bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.content ?? '',
                  style: robotoMedium.copyWith(
                    fontSize: 18,
                    color: ColorResources.getCardTextColor(),
                  ),
                ),
                const SizedBox(height: 10),
                Text(DateConverter.formatToDate(data.date ?? DateTime.now()),
                    style: robotoRegular.copyWith(
                      fontSize: 14,
                      color: ColorResources.getCardTextColor(),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
