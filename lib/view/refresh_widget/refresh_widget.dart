import 'package:flutter/cupertino.dart';
import 'package:timesheet/view/refresh_widget/src/indicator/classic_indicator.dart';
import 'src/indicator/material_indicator.dart';
import 'src/smart_refresher.dart';

class RefreshWidget extends StatelessWidget {
  final RefreshController? controller;
  final bool enableLoadMore;
  final Future Function()? onRefresh;
  final Future<bool> Function()? onLoadMore;
  final Widget? child;

  const RefreshWidget(
      {Key? key,
      this.controller,
      this.enableLoadMore = true,
      this.onRefresh,
      this.onLoadMore,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller0 = controller ?? RefreshController();
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: enableLoadMore,
      controller: controller0,
      onRefresh: onRefresh,
      onLoading: () async {
        if (onLoadMore != null) {
          onLoadMore!().then((value) {
            if (value) {
              controller0.footerMode = RefreshNotifier(LoadStatus.noMore);
            } else {
              controller0.loadComplete();
            }
          });
        }
      },
      header: const MaterialClassicHeader(),
      footer: const ClassicFooter(),
      child: child,
    );
  }
}
