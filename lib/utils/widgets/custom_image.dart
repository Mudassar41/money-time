import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';

import '../utils.dart';
import 'custom_shimmer.dart';

class CustomImage extends StatelessWidget {
  final String? pathOrUrl;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final Color? color;
  final BoxFit? fit;
  const CustomImage(
      {super.key,
      this.pathOrUrl,
      this.height,
      this.width,
      this.margin,
      this.color,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? getMargin(),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (pathOrUrl != null) {
      if (pathOrUrl!.isEmpty)
        return ShimmerWidget(
          height: height,
          width: width,
          margin: EdgeInsets.zero,
        );
      final isUrl = GetUtils.isURL(pathOrUrl!);
      if (isUrl) {
        return CachedNetworkImage(
          imageUrl: pathOrUrl!,
          fit: fit ?? BoxFit.cover,
          height: height,
          width: width,
          placeholder: (context, url) => ShimmerWidget(
            height: height,
            width: width,
            margin: EdgeInsets.zero,
          ),
          errorWidget: (context, url, error) => CustomImage(
            pathOrUrl: customAssetImage('logo'),
          ),
        );
      } else {
        if (pathOrUrl!.startsWith('assets/')) {
          return Image.asset(
            pathOrUrl!,
            fit: fit ?? BoxFit.cover,
            height: height,
            width: width,
            color: color,
          );
        } else {
          return Image.file(
            File(pathOrUrl!),
            fit: fit ?? BoxFit.cover,
            height: height,
            width: width,
            color: color,
          );
        }
      }
    } else {
      return ShimmerWidget(
        height: height,
        width: width,
        margin: EdgeInsets.zero,
      );
    }
  }
}
