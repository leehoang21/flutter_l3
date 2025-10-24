import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    super.key,
    required this.body,
    this.appBar,
    this.padding,
  });
  final Widget body;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: padding ??
            EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: 16.0,
              right: 16.0,
            ),
        child: body,
      ),
      appBar: appBar,
    );
  }
}
