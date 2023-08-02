import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeIdCard extends StatelessWidget {
  final String? employeeName;
  final String? employeeEmail;
  final bool isUsed;
  final String id;
  EmployeeIdCard(
      {this.employeeEmail,
      this.employeeName,
      required this.id,
      required this.isUsed});
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: getMargin(top: 10, bottom: 10),
      padding: getPadding(left: 12,right: 12,top: 12),
      width: Get.width,
      height: Get.height * 0.1,
      isBorderRadius: true,
      isShadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: LargeText(text: employeeName ?? "", size: 16, overflow: TextOverflow.ellipsis)),
              CustomContainer(
                isShadow: false,
                isBorderRadius: true,
                padding: getPadding(top: 2, bottom: 2, left: 8,right: 8),
                color: kYellow,
                child: SmallText(text: isUsed ? "Used" : "Not used"))
            ],
          ),
          Expanded(child: SmallText(text: employeeEmail ?? "", overflow: TextOverflow.ellipsis)),
          Align(alignment: Alignment.bottomRight,child: SmallText(text: id,margin: getMargin(top: 8),))
        ],
      ));
  }
}
