// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';

class EmployeeAtmBox extends StatelessWidget {
  final bool isWorkingStatus;
  final String atmName;
  void Function(bool) onUpdateStatus;

  EmployeeAtmBox({
    Key? key,
    required this.isWorkingStatus,
    required this.onUpdateStatus,
    required this.atmName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: Get.width,
      height: Get.height * 0.19,
      isBorderRadius: true,
      margin: getMargin(top: 20),
      padding: getPadding(all: 10),
      isShadow: false,
      border: Border.all(width: 2, color: kPrimary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LargeText(
            text: atmName,
            size: getFontSize(18),
            fontFamily: AppFonts.montserratBold,
          ),
          SizedBox(height: 5),
          LargeText(
            text: "ATM Status",
            size: getFontSize(16),
            fontFamily: AppFonts.montserratBold,
          ),
          SizedBox(height: getVerticalSize(10)),
          Row(
            children: [
              // if (isWorkingStatus) ...[
              CircleAvatar(
                radius: getSize(8),
                backgroundColor: kGreen,
              ),
              LargeText(
                text: "  Working  ",
                size: getFontSize(18),
                color: Colors.black54,
                fontFamily: AppFonts.montserratBold,
              ),
              // ] else ...[
              CircleAvatar(
                radius: getSize(8),
                backgroundColor: kRed,
              ),
              LargeText(
                text: "  Not-Working",
                size: getFontSize(18),
                color: Colors.black54,
                fontFamily: AppFonts.montserratBold,
              ),
              //   ]
            ],
          ),
          SizedBox(height: getVerticalSize(10)),
          Row(
            children: [
              LargeText(
                text: "Status:  ",
                size: getFontSize(18),
                color: Colors.black54,
                fontFamily: AppFonts.montserratBold,
              ),
              Switch(
                inactiveTrackColor: kRed,
                thumbColor: MaterialStatePropertyAll(kWhite),
                activeColor: kGreen,
                value: isWorkingStatus,
                onChanged: onUpdateStatus,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
