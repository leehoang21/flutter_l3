import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:timesheet/controller/post_controller.dart';
import 'package:timesheet/data/model/body/post_model.dart';

import '../../../helper/date_converter.dart';
import '../../../utils/color_resources.dart';
import '../../../view/text_field_widget.dart';

class SavePostWidget extends StatefulWidget {
  const SavePostWidget(
      {super.key, required this.data, required this.pagingController});
  final PostModel data;
  final PagingController<int, PostModel> pagingController;

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
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
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
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () async {
                  await Get.find<PostController>()
                      .save(
                    content: _contentController.text,
                    id: widget.data.id,
                  )
                      .then((value) {
                    Get.back();
                    widget.pagingController.refresh();
                  });
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
        const SizedBox(height: 30),
      ],
    );
  }
}
