import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/tracking_controller.dart';
import 'package:timesheet/data/model/body/tracking_model.dart';
import 'package:timesheet/view/appbar_widget.dart';
import 'package:timesheet/view/custom_button.dart';
import 'package:timesheet/view/date_field_widget.dart';
import 'package:timesheet/view/scaffold_widget.dart';

import '../../helper/date_converter.dart';
import '../../utils/color_resources.dart';
import '../../view/text_field_widget.dart';

class SaveTrackingScreen extends StatefulWidget {
  const SaveTrackingScreen({super.key});

  @override
  State<SaveTrackingScreen> createState() => _SaveTrackingScreenState();
}

class _SaveTrackingScreenState extends State<SaveTrackingScreen> {
  final TextEditingController _contentController = TextEditingController();
  final DateEditingController _dateController = DateEditingController();
  TrackingModel data = TrackingModel();

  @override
  void initState() {
    if (Get.arguments != null) {
      final data = Get.arguments['tracking'] as TrackingModel?;
      if (data != null) {
        _contentController.text = data.content ?? '';
        _dateController.text =
            data.date != null ? DateConverter.formatToDate(data.date!) : '';
        this.data = data;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBarWidget(title: 'save_tracking'.tr),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFieldWidget(
              controller: _contentController,
              textInputAction: TextInputAction.next,
              isObscureText: false,
              labelText: "content".tr,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: DateFieldWidget(
              controller: _dateController,
              labelText: "date".tr,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 40.w,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: CustomButton(
                    onPressed: () {
                      Get.back();
                    },
                    color: ColorResources.COLOR_HINT,
                    title: "cancel".tr,
                  ),
                ),
              ),
              SizedBox(
                width: 40.w,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: CustomButton(
                    onPressed: () async {
                      await Get.find<TrackingController>().save(
                        data: data.copyWith(
                          content: _contentController.text.trim(),
                          date: _dateController.dateTime,
                        ),
                      );
                      Get.back();
                    },
                    title: "save".tr,
                  ),
                ),
              ),
              SizedBox(
                width: 40.w,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
