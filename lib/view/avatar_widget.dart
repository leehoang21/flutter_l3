import 'package:flutter/material.dart';
import 'package:timesheet/utils/images.dart';
import 'image_app.dart';

class AvatarWidget extends StatelessWidget {
  final String? path;
  final double? size;
  const AvatarWidget({super.key, required this.path, this.size});

  @override
  Widget build(BuildContext context) {
    final size0 = size ?? 44;
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: ImageAppWidget(
        path: path,
        width: size0,
        height: size0,
        fit: BoxFit.cover,
        defultImage: Image.asset(Images.vietnam),
      ),
    );
  }
}
