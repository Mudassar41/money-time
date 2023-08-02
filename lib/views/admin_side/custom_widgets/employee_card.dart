import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  final String employeeName;
  final String employeeEmail;
  final VoidCallback onTap;
  EmployeeCard({required this.employeeEmail, required this.employeeName, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        isShadow: false,
        margin: getMargin(top: 10),
        padding: getPadding(all: 10),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LargeText(text: employeeName, size: getFontSize(18)),
          SmallText(text: employeeEmail)
        ],
      )),
    );
  }
}
