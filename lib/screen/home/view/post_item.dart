import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/post_controller.dart';
import 'package:timesheet/utils/images.dart';
import 'package:timesheet/utils/styles.dart';
import 'package:timesheet/view/avatar_widget.dart';
import '../../../data/model/body/post_model.dart';
import '../../../utils/time_ago_utils.dart';
import 'comment_widget.dart';
import 'save_post_widget.dart';

class PostItem extends StatelessWidget {
  final PostModel data;

  const PostItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            AvatarWidget(
              // path: data.user?.image,
              path: '',
              size: 50.sp,
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.user?.username ?? '',
                  style: robotoBold,
                ),
                Text(
                  data.date == null ? "" : timeagoFormat(data.date!),
                  style: robotoRegular.copyWith(
                    color: Colors.grey,
                    fontSize: 11.sp,
                  ),
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
                              ),
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
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            data.content ?? "",
            style: robotoRegular.copyWith(
              fontSize: 12.sp,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
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
                        height: 24.sp,
                        width: 24.sp,
                        color: Colors.white,
                      )),
                  SizedBox(width: 4.w),
                  Text(' ${data.likes?.length ?? 0}'),
                  SizedBox(width: 30.w),
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useSafeArea: true,
                            builder: (context) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: CommentWidget(
                                  model: data,
                                ),
                              );
                            });
                      },
                      child: Icon(
                        Icons.comment_outlined,
                        size: 24.sp,
                      )),
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
