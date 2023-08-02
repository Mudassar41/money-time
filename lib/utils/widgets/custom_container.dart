import 'package:flutter/material.dart';

import '../constant/const.dart';
import '../theme/colors.dart';
import '../utils.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadius? radius;
  final bool isShadow;
  final Alignment? alignment;
  final Color? borderColor;
  final Border? border;
  final Color? shadowColor;
  final bool isBorderRadius;
  const CustomContainer(
      {super.key,
      required this.child,
      this.color = kWhite,
      this.margin,
      this.alignment,
      this.radius,
      this.padding,
      this.height,
      this.width,
      this.isShadow = true,
      this.borderColor,
      this.border,
      this.shadowColor,
      this.isBorderRadius = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? getMargin(),
      padding: padding,
      height: height,
      alignment: alignment,
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: isBorderRadius ? radius ?? raduis_16 : null,
          border: border ?? Border.all(color: borderColor ?? kTransparent),
          boxShadow: [
            if (isShadow)
              BoxShadow(
                  color: shadowColor ?? kShadowcColor,
                  offset: const Offset(1, 2),
                  blurRadius: 6,
                  spreadRadius: 2)
          ]),
      child: child,
    );
  }
}
