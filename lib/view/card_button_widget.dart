import 'package:flutter/material.dart';

import 'card_widget.dart';

class CardButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final double? width;
  final double? height;
  final Widget child;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape? shape;

  const CardButtonWidget({
    super.key,
    required this.onPressed,
    this.height,
    this.width,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CardWidget(
        backgroundColor: backgroundColor,
        height: height,
        width: width,
        padding: padding,
        borderRadius: borderRadius,
        shape: shape,
        child: child,
      ),
    );
  }
}
