import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/comment_controller.dart';
import 'package:timesheet/data/model/body/post_model.dart';
import 'package:timesheet/utils/dimensions.dart';
import 'package:timesheet/utils/styles.dart';
import 'package:timesheet/view/card_widget.dart';
import '../../../utils/time_ago_utils.dart';
import '../../../view/avatar_widget.dart';
import '../../../view/text_field_widget.dart';

class CommentWidget extends StatefulWidget {
  final PostModel model;

  const CommentWidget({super.key, required this.model});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Get.find<CommentController>().initState(widget.model.comments ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                itemCount: controller.comments.length,
                controller: _scrollController,
                itemBuilder: (context, index) => CommentCard(
                  model: controller.comments[index],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: TextFieldWidget(
                controller: _controller,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    await controller.commment(_controller.text, widget.model);

                    _controller.clear();
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent + 100,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                ),
                isObscureText: false,
                labelText: '',
              ),
            ),
          ],
        );
      },
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.model,
    this.padding,
  });
  final CommentModel model;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              AvatarWidget(path: '', size: 40),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.user?.username ?? "",
                        textAlign: TextAlign.start,
                        style: robotoBold.copyWith(),
                      ),
                      Text(
                        model.content ?? "",
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  model.date == null ? "" : timeagoFormat(model.date!),
                  textAlign: TextAlign.start,
                  style: robotoRegular.copyWith(
                    fontSize: 11.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
