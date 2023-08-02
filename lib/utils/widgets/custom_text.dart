import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../utils.dart';

class SmallText extends StatelessWidget {
  const SmallText({
    super.key,
    required this.text,
    this.size,
    this.fontFamily,
    this.color,
    this.align,
    this.fontWeight,
    this.decoration,
    this.margin,
    this.overflow,
    this.isThin = true,
    this.maxLines = 1,
  });

  final String text;
  final double? size;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? align;
  final TextDecoration? decoration;
  final EdgeInsets? margin;
  final TextOverflow? overflow;
  final bool isThin;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? getMargin(),
      child: Text(
        text,
        textAlign: align,
        overflow: overflow ?? TextOverflow.ellipsis,
        maxLines: maxLines,
        style: isThin
            ? AppStyle.normal.copyWith(
                fontFamily: fontFamily,
                fontSize: size,
                color: color,
                decoration: decoration,
                fontWeight: fontWeight,
              )
            : AppStyle.medium.copyWith(
                fontFamily: fontFamily,
                fontSize: size,
                color: color,
                fontWeight: fontWeight,
              ),
      ),
    );
  }
}

class LargeText extends StatelessWidget {
  const LargeText(
      {super.key,
      required this.text,
      this.size,
      this.decoration,
      this.color,
      this.fontWeight,
      this.spacing,
      this.fontFamily,
      this.margin,
      this.overflow,
      this.textAlign,
      this.maxLines});

  final String text;
  final double? size;
  final String? fontFamily;
  final double? spacing;
  final Color? color;
  final TextDecoration? decoration;
  final EdgeInsets? margin;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? getMargin(),
      child: Text(
        text,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.ellipsis,
        maxLines: maxLines,
        style: AppStyle.large.copyWith(
          fontFamily: fontFamily,
          fontSize: size,
          color: color,
          decoration: decoration,
          letterSpacing: spacing,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class ExtraLargeText extends StatelessWidget {
  const ExtraLargeText(
      {super.key,
      required this.text,
      this.size,
      this.color,
      this.fontWeight,
      this.spacing,
      this.fontFamily,
      this.margin,
      this.overflow});

  final String text;
  final double? size;
  final String? fontFamily;
  final double? spacing;
  final Color? color;
  final EdgeInsets? margin;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? getMargin(),
      child: Text(
        text,
        overflow: overflow ?? TextOverflow.ellipsis,
        style: AppStyle.extraLarge.copyWith(
            fontFamily: fontFamily,
            fontSize: size,
            color: color,
            letterSpacing: spacing,
            fontWeight: fontWeight),
      ),
    );
  }
}

class HighlightedText extends StatelessWidget {
  final String text;
  final String delimiter;
  final TextStyle defaultStyle;
  final TextStyle highlightedStyle;
  final int maxLines;
  final TextOverflow? textOverflow;

  HighlightedText({
    required this.text,
    this.delimiter = '(o)',
    this.defaultStyle = const TextStyle(color: Colors.black),
    this.highlightedStyle = const TextStyle(
      color: Colors.black,
      backgroundColor: Colors.yellow,
    ),
    required this.maxLines,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    final parts = text.split(delimiter);
    final spans = <TextSpan>[];
    for (int i = 0; i < parts.length; i++) {
      final isHighlighted = i % 2 == 1;
      spans.add(
        TextSpan(
          text: parts[i],
          style: isHighlighted ? highlightedStyle : defaultStyle,
        ),
      );
    }
    return RichText(
      text: TextSpan(children: spans),
      maxLines: maxLines,
      overflow: textOverflow ?? TextOverflow.ellipsis,
    );
  }
}
