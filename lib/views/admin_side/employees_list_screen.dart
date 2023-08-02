import 'package:atm_tracker/controllers/admin_controller.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/views/admin_side/custom_widgets/employee_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeListScreen extends StatelessWidget {
  final _adminController = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getVerticalSize(60)),
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back, color: kWhite, size: getSize(40))),
            LargeText(
                text: "SELECT AN EMPLOYEE",
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
            if (_adminController.isEmployeeListLoading.value)
              Expanded(
                  child:
                      Center(child: CircularProgressIndicator(color: kWhite)))
            else if (_adminController.employeesList.isEmpty)
              Expanded(
                  child: Center(
                      child: SmallText(text: "No Employees", color: kWhite)))
            else
              Expanded(
                  child: Obx(
                () => ListView.builder(
                  padding: getPadding(left: 20, right: 20, bottom: 20),
                  itemCount: _adminController.employeesList.length,
                  itemBuilder: (context, index) {
                    return EmployeeCard(
                        employeeName:
                            _adminController.employeesList[index].firstName +
                                " " +
                                _adminController.employeesList[index].lastName,
                        employeeEmail:
                            _adminController.employeesList[index].email,
                        onTap: () {
                          _adminController.employeeId.value =
                              _adminController.employeesList[index].employeeId;
                          Get.back();
                        });
                  },
                ),
              ))
          ],
        ),
      ),
    );
  }
}
