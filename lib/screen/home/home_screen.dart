import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:timesheet/controller/post_controller.dart';
import 'package:timesheet/data/model/body/post_model.dart';
import 'package:timesheet/screen/home/view/post_item.dart';
import 'package:timesheet/screen/home/view/save_post_widget.dart';
import 'package:timesheet/view/scaffold_widget.dart';

import '../../view/avatar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PagingController<int, PostModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      final result = await Get.find<PostController>().loadMore(pageKey + 1);
      if (Get.find<PostController>().isLast.value) {
        _pagingController.appendLastPage(result);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(result, nextPageKey);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: InkWell(
                onTap: () {
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
                                pagingController: _pagingController));
                      });
                },
                child: Row(
                  children: [
                    const AvatarWidget(path: ""),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(500),
                        ),
                        child: Text(
                          'create_post'.tr,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: PagedListView<int, PostModel>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<PostModel>(
                  itemBuilder: (context, item, index) =>
                      PostItem(data: item, pagingController: _pagingController),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
