import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:timesheet/controller/post_controller.dart';
import 'package:timesheet/utils/images.dart';
import 'package:timesheet/view/avatar_widget.dart';
import '../../../data/model/body/post_model.dart';

import '../../../utils/time_ago_utils.dart';
import 'comment_widget.dart';
import 'save_post_widget.dart';

class PostItem extends StatelessWidget {
  final PostModel data;
  final PagingController<int, PostModel> pagingController;

  const PostItem(
      {super.key, required this.data, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Row(
          children: [
            const AvatarWidget(
              // path: data.user?.image,
              path: '',
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.user?.displayName ?? ''),
                Text(
                  data.date == null ? "" : timeagoFormat(data.date!),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            PopupMenuButton(
              icon: const Icon(Icons.more_horiz),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SavePostWidget(
                                  data: data,
                                  pagingController: pagingController),
                            );
                          });
                    },
                    child: Text('edit'.tr),
                  ),
                ];
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            data.content ?? "",
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.find<PostController>().like(data);
                      },
                      child: Image.asset(
                        Images.like,
                        height: 24,
                        width: 24,
                      )),
                  const SizedBox(width: 4),
                  Text(' ${data.likes?.length ?? 0}'),
                  const SizedBox(width: 30),
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: CommentWidget(
                                    model: data,
                                    pagingController: pagingController,
                                  ));
                            });
                      },
                      child: const Icon(Icons.comment_outlined)),
                  const SizedBox(width: 4),
                  Text(' ${data.comments?.length ?? 0}'),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
