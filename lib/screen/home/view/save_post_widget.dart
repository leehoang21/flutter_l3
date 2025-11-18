import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/post_controller.dart';
import 'package:timesheet/data/model/body/post_model.dart';
import 'package:timesheet/view/custom_button.dart';

import '../../../helper/date_converter.dart';
import '../../../utils/color_resources.dart';
import '../../../view/text_field_widget.dart';

class SavePostWidget extends StatefulWidget {
  const SavePostWidget({
    super.key,
    required this.data,
  });
  final PostModel data;

  @override
  State<SavePostWidget> createState() => _SavePostWidgetState();
}

class _SavePostWidgetState extends State<SavePostWidget> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    _contentController.text = widget.data.content ?? '';
    _dateController.text = widget.data.date != null
        ? DateConverter.formatToDate(widget.data.date!)
        : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: TextFieldWidget(
            controller: _contentController,
            textInputAction: TextInputAction.next,
            isObscureText: false,
            labelText: "content".tr,
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 40.w,
            ),
            Expanded(
              child: CustomButton(
                onPressed: () {
                  Get.back();
                },
                color: ColorResources.COLOR_HINT,
                title: "cancel".tr,
              ),
            ),
            SizedBox(
              width: 40.w,
            ),
            Expanded(
              child: CustomButton(
                onPressed: () async {
                  await Get.find<PostController>()
                      .save(
                    content: _contentController.text,
                    id: widget.data.id,
                  )
                      .then((value) {
                    Get.back();
                  });
                },
                title: "save".tr,
              ),
            ),
            SizedBox(
              width: 40.w,
            ),
          ],
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
