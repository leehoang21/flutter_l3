import 'package:flutter/material.dart';
import 'package:timesheet/utils/images.dart';
import 'image_app.dart';

class AvatarWidget extends StatelessWidget {
  final String? path;
  final double? width;
  final double? height;
  const AvatarWidget({super.key, required this.path, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: ImageAppWidget(
        path: path,
        width: width ?? 44,
        height: height ?? 44,
        fit: BoxFit.cover,
        defultImage: Image.asset(Images.vietnam),
      ),
    );
  }
}
