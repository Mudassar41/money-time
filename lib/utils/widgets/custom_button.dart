import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import '../utils.dart';
import 'custom_text.dart';
import '../theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final double textSize;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final BorderRadius? radius;
  final bool isLoading;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool isBorder;
  final Color? borderColor;
  final Widget? suffix;
  final Widget? preffix;
  final bool isSpaceBetweenSuffix;
  final bool isSpaceBetweenPrefix;
  final bool isIconButton;
  final Widget? iconWidget;
  final bool isCenter;

  const CustomButton({
    Key? key,
    required this.title,
    this.onTap,
    this.color = kPrimary,
    this.textColor = kWhite,
    this.isLoading = false,
    this.height,
    this.radius,
    this.margin,
    this.isBorder = false,
    this.width,
    this.borderColor,
    this.suffix,
    this.preffix,
    this.padding,
    this.textSize = 16,
    this.isSpaceBetweenSuffix = false,
    this.isSpaceBetweenPrefix = false,
    this.isIconButton = false,
    this.isCenter = true,
    this.iconWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: isLoading ? null : onTap,
      child: Container(
        margin: margin,
        padding: padding ?? getPadding(left: 12, right: 12),
        height: isLoading ? 32 : height ?? 52,
        width: width,
        alignment: Alignment.center,
        decoration: isLoading
            ? null
            : BoxDecoration(
                borderRadius: radius ?? BorderRadius.circular(26),
                color: color,
                border:
                    isBorder ? Border.all(color: borderColor ?? color) : null,
              ),
        child: isLoading
            ? SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(
                  color: color,
                ))
            : isIconButton
                ? iconWidget
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: isCenter
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      if (preffix != null) preffix!,
                      if (isSpaceBetweenPrefix) Spacer(),
                      SmallText(
                        fontFamily: AppFonts.montserratBold,
                        text: title,
                        color: textColor,
                        size: textSize,
                        isThin: false,
                      ),
                      if (isSpaceBetweenSuffix) Spacer(),
                      if (suffix != null) suffix!,
                    ],
                  ),
      ),
    );
  }
}
