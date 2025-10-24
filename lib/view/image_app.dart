// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/utils.dart';

// ignore: must_be_immutable
class ImageAppWidget extends StatelessWidget {
  final String? path;
  bool isRemote = false;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Widget? nullPathWidget;
  final Image? defultImage;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? color;

  ImageAppWidget({
    Key? key,
    required this.path,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.color,
    this.nullPathWidget,
    this.defultImage,
  }) : super(key: key);

  Widget get _placeholder {
    late double size;
    if (width != null && height != null) {
      size = width! > height! ? height! : width!;
      size = size / 3;
    } else {
      size = 10;
    }
    return Center(
        child: SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator()));
  }

  Widget get _errorWidget {
    return Center(child: _placeholder);
  }

  Widget get _nullPathWidget {
    return defultImage ?? const SizedBox();
  }

  Widget _buildLottieImageWidget() {
    if (isRemote) {
      return CachedNetworkImage(
          imageUrl: path ?? '',
          fit: fit,
          width: width,
          height: height,
          color: color,
          placeholder: (context, url) => placeholder ?? _placeholder,
          errorWidget: (context, url, error) => errorWidget ?? _errorWidget);
    }

    return image(FileImage(File(path!)));
  }

  Widget _buildSvgImageWidget() {
    if (isRemote) {
      return SvgPicture.network(
        path!,
        fit: fit,
        width: width,
        height: height,
        color: color,
        placeholderBuilder: (context) => placeholder ?? _placeholder,
      );
    }

    return SvgPicture.asset(
      path!,
      fit: fit,
      width: width,
      height: height,
      color: color,
      placeholderBuilder: (context) => placeholder ?? _placeholder,
    );
  }

  Widget _buildNormalImageWidget() {
    if (isRemote) {
      return CachedNetworkImage(
          imageUrl: path ?? '',
          fit: fit,
          width: width,
          height: height,
          color: color,
          fadeOutDuration: Duration.zero,
          fadeInDuration: Duration.zero,
          cacheKey: path,
          placeholder: (context, url) => placeholder ?? _placeholder,
          errorWidget: (context, url, error) => errorWidget ?? _errorWidget);
    }
    return image(AssetImage(path!));
  }

  bool checkAsset() {
    if (path!.contains('assets')) {
      String firstString = path!.trim().substring(0, 5).toUpperCase();
      return firstString.contains('asset'.toUpperCase());
    }
    return false;
  }

  Image image(ImageProvider<Object> image) => Image(
        image: image,
        fit: fit,
        width: width,
        height: height,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return placeholder ?? _placeholder;
        },
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _errorWidget,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    isRemote = checkRemote();
    if (isNullEmpty(path)) {
      return _nullPathWidget;
    }
    switch (imageType) {
      case ImageType.file:
        return _buildLottieImageWidget();
      case ImageType.svg:
        return _buildSvgImageWidget();
      default:
        return _buildNormalImageWidget();
    }
  }

  ImageType get imageType {
    int length = path!.length;
    String firstString = path!.substring(0, 5).toUpperCase();
    String lastString = path!.substring(length - 5).toUpperCase();
    if (lastString.contains('.svg'.toUpperCase())) {
      return ImageType.svg;
    } else if (firstString.contains('asset'.toUpperCase())) {
      return ImageType.image;
    } else {
      return ImageType.file;
    }
  }

  bool checkRemote() {
    if (path.toString().contains('http://') ||
        path.toString().contains('https://')) {
      return true;
    }
    return false;
  }
}

enum ImageType { svg, image, file }
