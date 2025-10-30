import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:timesheet/controller/comment_controller.dart';
import 'package:timesheet/data/model/body/post_model.dart';
import 'package:timesheet/view/scaffold_widget.dart';
import '../../../utils/time_ago_utils.dart';
import '../../../view/avatar_widget.dart';
import '../../../view/text_field_widget.dart';

class CommentWidget extends StatefulWidget {
  final PostModel model;
  final PagingController<int, PostModel> pagingController;

  const CommentWidget(
      {super.key, required this.model, required this.pagingController});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    Get.find<CommentController>().initState(widget.model.comments ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: GetBuilder<CommentController>(
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                        children: (controller.comments)
                            .map(
                              (e) => CommentCard(
                                model: e,
                              ),
                            )
                            .toList()),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFieldWidget(
                  controller: _controller,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      await controller.commment(_controller.text, widget.model);
                      widget.pagingController.refresh();
                      _controller.clear();
                    },
                  ),
                  isObscureText: false,
                  labelText: '',
                ),
              ),
            ],
          );
        },
      ),
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
          const AvatarWidget(path: '', size: 40),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.user?.displayName ?? "",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  model.content ?? "",
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  model.date == null ? "" : timeagoFormat(model.date!),
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
