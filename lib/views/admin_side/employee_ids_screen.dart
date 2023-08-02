import 'package:atm_tracker/controllers/employee_id_controller.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/admin_side/custom_widgets/employee_id_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeIDsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<EmployeeIdController>(
        init: EmployeeIdController(),
        autoRemove: false,
        builder: (controller) {
          return Scaffold(
            backgroundColor: kPrimary,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getVerticalSize(60)),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back,
                        color: kWhite, size: getSize(40))),
                LargeText(
                    text: "Team member ID's",
                    color: kWhite,
                    size: getFontSize(24),
                    margin: getMargin(left: 20, bottom: 4, top: 20)),
                CustomContainer(
                  width: Get.width * 0.6,
                  height: getVerticalSize(3),
                  child: SizedBox(),
                  isBorderRadius: true,
                  color: kGrey,
                  isShadow: false,
                  margin: getMargin(left: 20, bottom: 20),
                ),
                CustomTextField(
                  margin: getMargin(bottom: 20, left: 20, right: 20),
                  raduis: BorderRadius.circular(24),
                  maxCharacters: 20,
                  controller: controller.employeeIdController,
                  hint: "Insert Team Member id",
                  color: Colors.grey.shade200,
                  suffixIcon: TextButton(
                      child: SmallText(
                          text: "ADD",
                          color: kPrimary,
                          decoration: TextDecoration.underline),
                      onPressed: () {
                        controller.addEmployeeId();
                      }),
                ),
                if (controller.isLoading.value)
                  Expanded(
                      child: Center(
                          child: CircularProgressIndicator(color: kWhite)))
                else if (controller.employeeIdList.isEmpty)
                  Expanded(
                      child: Center(
                          child: SmallText(text: "No IDs", color: kWhite)))
                else
                  Expanded(
                      child: ListView.builder(
                    padding: getPadding(left: 20, right: 20, bottom: 20),
                    itemCount: controller.employeeIdList.length,
                    itemBuilder: (context, index) {
                      final model = controller.employeeIdList[index];
                      return EmployeeIdCard(
                          employeeEmail: model.employeeEmail ?? "",
                          employeeName: model.employeeName ?? "",
                          id: model.id,
                          isUsed: model.isOccupied);
                    },
                  ))
              ],
            ),
          );
        });
  }
}
