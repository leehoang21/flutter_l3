import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/tracking_controller.dart';
import 'package:timesheet/data/model/body/tracking_model.dart';
import 'package:timesheet/view/appbar_widget.dart';
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
  final TextEditingController _dateController = TextEditingController();
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
            child: TextFieldWidget(
              controller: _dateController,
              textInputAction: TextInputAction.next,
              isObscureText: false,
              labelText: "date".tr,
              suffixIcon: IconButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: data.date ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    data = data.copyWith(date: pickedDate);
                    _dateController.text =
                        DateConverter.formatToDate(pickedDate);
                  }
                },
                icon: Icon(
                  Icons.calendar_month_outlined,
                  color: ColorResources.getPrimaryColor(),
                ),
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: ColorResources.COLOR_HINT,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                    child: Text("cancel".tr,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(191, 252, 226, 1.0))),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () async {
                    await Get.find<TrackingController>().save(
                      data: data.copyWith(
                        content: _contentController.text.trim(),
                      ),
                    );
                    Get.back();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                    child: Text("save".tr,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(191, 252, 226, 1.0))),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
