import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/colors.dart';
import '../utils.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  const ShimmerWidget(
      {super.key, this.child, this.height, this.width, this.borderRadius, this.margin});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: child ??
            Container(
              height: height,
              width: width,
              margin: margin??getMargin(all: 8),
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: borderRadius ?? BorderRadius.zero),
            ));
  }
}
