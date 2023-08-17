import 'package:atm_tracker/models/atm_model.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AtmBox extends StatelessWidget {
  final AtmModel atmModel;
  final VoidCallback onTap;

  AtmBox({required this.atmModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        width: Get.width,
        margin: getMargin(top: 10, bottom: 20),
        height: Get.height * 0.24,
        isBorderRadius: true,
        padding: getPadding(all: 10),
        isShadow: false,
        border: Border.all(
          width: 2,
          color: atmModel.isWorking ? kGreen : kRed,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomContainer(
                  isBorderRadius: true,
                  isShadow: false,
                  alignment: Alignment.center,
                  color: atmModel.isWorking ? kGreen : kRed,
                  padding: getPadding(all: 8),
                  child: SmallText(
                    text: atmModel.isWorking ? "Working" : "Not-Working",
                    fontFamily: AppFonts.montserratRegular,
                    size: getFontSize(13),
                    color: kWhite,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.delete,
                    color: Colors.black26,
                  ),
                )
              ],
            ),
            SizedBox(height: getVerticalSize(20)),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LargeText(
                      text: "ATM Name",
                      size: getFontSize(20),
                      fontFamily: AppFonts.montserratBold,
                    ),
                    SizedBox(height: getVerticalSize(10)),
                    LargeText(
                      text: atmModel.atmName,
                      size: getFontSize(17),
                      color: Colors.black54,
                    ),
                  ],
                ),
                SizedBox(width: getHorizontalSize(40)),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeText(
                        text: "Bank Name",
                        size: getFontSize(20),
                        fontFamily: AppFonts.montserratBold,
                      ),
                      SizedBox(height: getVerticalSize(10)),
                      LargeText(
                        text: atmModel.bankName,
                        overflow: TextOverflow.ellipsis,
                        size: getFontSize(17),
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: getVerticalSize(20)),
            LargeText(
              text: "Type",
              size: getFontSize(20),
              fontFamily: AppFonts.montserratBold,
            ),
            SizedBox(height: getVerticalSize(10)),
            LargeText(
              text: atmType(),
              size: getFontSize(18),
              color: Colors.black54,
            )
          ],
        ));
  }

  String atmType() {
    String type = "";
    if (atmModel.isSmart) type += "Smart ";

    if (atmModel.isDualCurrency) type += "/Dual Currency";
    if (atmModel.driveThrough) type += '/Drive Through';
    if (atmModel.branch) type += '/Branch';
    if (atmModel.offSite) type += '/offSite';

    return type;
  }
}
