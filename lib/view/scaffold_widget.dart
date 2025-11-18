import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    super.key,
    required this.body,
    this.appBar,
    this.padding,
    this.floatingActionButton,
  });
  final Widget body;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: (appBar?.preferredSize.height ?? 16.h) +
                    (padding?.vertical ?? 0),
                left: padding?.horizontal ?? 16.w,
                right: padding?.horizontal ?? 16.w,
                bottom: padding?.vertical ?? 0,
              ),
              child: body,
            ),
            appBar ?? const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
