import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/post_controller.dart';
import 'package:timesheet/data/model/body/post_model.dart';
import 'package:timesheet/screen/home/view/post_item.dart';
import 'package:timesheet/screen/home/view/save_post_widget.dart';
import 'package:timesheet/utils/dimensions.dart';
import 'package:timesheet/utils/styles.dart';
import 'package:timesheet/view/scaffold_widget.dart';

import '../../view/avatar_widget.dart';
import '../../view/card_button_widget.dart';
import '../../view/refresh_widget/refresh_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: GetBuilder<PostController>(
        builder: (controller) {
          return RefreshWidget(
            onRefresh: controller.onInit,
            onLoadMore: controller.loadMore,
            child: ListView.builder(
              itemCount: controller.posts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _appbar(context);
                }
                return PostItem(
                  data: controller.posts[index - 1],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Column _appbar(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AvatarWidget(
              path: "",
              size: 50.sp,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: CardButtonWidget(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: SavePostWidget(
                              data: PostModel(),
                            ));
                      });
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
                  child: Text(
                    'What’s on your mind'.tr,
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
