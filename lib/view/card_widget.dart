import 'package:flutter/material.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/dimensions.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape? shape;
  const CardWidget({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: ColorResources.getCardTextColor(),
              displayColor: ColorResources.getCardTextColor(),
            ),
      ),
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          color: backgroundColor ??
              ColorResources.getBackgroundCardColor().withOpacity(0.4),
          borderRadius: shape != null
              ? null
              : borderRadius ??
                  BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
        ),
        child: SizedBox(
          height: height,
          width: width,
          child: child,
        ),
      ),
    );
  }
}
