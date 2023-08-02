import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UserAtmBox extends StatelessWidget {
  final bool isWorking;
  final bool isSmart;
  final bool isDualCurrency;
  final bool isBranch;
  final String atmName;
  final String bankName;
  final bool isDrive;

  UserAtmBox({
    required this.atmName,
    required this.bankName,
    required this.isDualCurrency,
    required this.isSmart,
    required this.isWorking,
    required this.isBranch, required this.isDrive,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        padding: getPadding(all: 8),
        isShadow: false,
        border: Border.all(
          color: isWorking ? kGreen : kRed,
          width: 2,
        ),
        margin: getMargin(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: CustomContainer(
                width: isWorking ? 80 : 100,
                isBorderRadius: true,
                isShadow: false,
                alignment: Alignment.center,
                color: isWorking ? kGreen : kRed,
                padding: getPadding(all: 8),
                child: SmallText(
                  text: isWorking ? "Working" : "Not-working",
                  size: getFontSize(13),
                  color: kWhite,
                  fontFamily: AppFonts.montserratRegular,
                ),
              ),
            ),
            SizedBox(height: 5),
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
                      text: atmName,
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
                        text: bankName,
                        overflow: TextOverflow.ellipsis,
                        size: getFontSize(17),
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: getVerticalSize(10)),
            LargeText(
              text: "Type",
              size: getFontSize(20),
              fontFamily: AppFonts.montserratBold,
            ),
            SizedBox(height: 5),
            // Row(
            //   children: [
            //     LargeText(
            //       text: 'Bank:',
            //       size: 14,
            //       fontFamily: AppFonts.montserratBold,
            //       margin: getMargin(right: 10),
            //     ),
            //     LargeText(
            //       text: bankName,
            //       fontWeight: FontWeight.normal,
            //       color: Colors.black,
            //       size: 13,
            //       fontFamily: AppFonts.montserratRegular,
            //     ),
            //   ],
            // ),
            Row(
              children: [
                if (isSmart)
                  LargeText(
                    text: 'Smart',
                    color: Colors.black,
                    size: 13,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.montserratRegular,
                  ),
                if (isDualCurrency)
                  Row(
                    children: [
                      VerticalLine(),
                      LargeText(
                        text: 'Dual Currency',
                        color: Colors.black,
                        size: 13,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.montserratRegular,
                      ),
                    ],
                  ),
                if (isBranch)
                  Row(
                    children: [
                      VerticalLine(),
                      LargeText(
                        text: 'Branch',
                        color: Colors.black,
                        size: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.montserratRegular,
                      ),
                    ],
                  ),

                if (isDrive)
                  Row(
                    children: [
                      VerticalLine(),
                      LargeText(
                        text: 'Drive Through',
                        color: Colors.black,
                        size: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: AppFonts.montserratRegular,
                      ),
                    ],
                  ),
              ],
            ),
            // SizedBox(width: getHorizontalSize(5)),
            //  SizedBox(height: 5)
          ],
        ));
  }
}

class VerticalLine extends StatelessWidget {
  const VerticalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Text(
        "/",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontFamily: AppFonts.montserratRegular,
        ),
      ),
    );
  }
}
