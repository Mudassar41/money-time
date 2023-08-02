import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankNameTile extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  BankNameTile({required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        isBorderRadius: true,
        margin: getMargin(top: 8, bottom: 8),
        isShadow: false,
        color: kWhite,
        width: Get.width,
        padding: getPadding(left: 20),
        height: getVerticalSize(54),
        alignment: Alignment.centerLeft,
        child: LargeText(
          text: name,
          color: kBlack,
          size: getFontSize(18),
          fontFamily: AppFonts.montserratBold,
        ),
      ),
    );
  }
}
