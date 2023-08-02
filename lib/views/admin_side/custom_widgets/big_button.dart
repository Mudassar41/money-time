import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_image.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BigButton extends StatelessWidget {
  BigButton({
    required this.buttonName,
    required this.iconName,
    required this.onTap,
  });

  final String iconName;
  final String buttonName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        isBorderRadius: true,
        width: Get.width * 0.36,
        height: Get.height * 0.2,
        padding: getPadding(all: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomImage(
              pathOrUrl: customAssetImage(iconName),
              height: getVerticalSize(70),
              fit: BoxFit.fill,
            ),
            LargeText(
              text: buttonName,
              fontFamily: AppFonts.montserratBold,
              maxLines: 2,
              textAlign: TextAlign.center,
              size: getFontSize(18),
            )
          ],
        ),
      ),
    );
  }
}
