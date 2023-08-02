import 'package:atm_tracker/controllers/employee_controlller.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_image.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/location_card.dart';
import 'package:atm_tracker/views/employee_side/custom_widgets/profile_card.dart';
import 'package:atm_tracker/views/employee_side/edit_status_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<EmployeeController>(
        init: EmployeeController(),
        autoRemove: false,
        builder: (controller) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.34,
                  color: kPrimary,
                  width: Get.width,
                  padding: getPadding(all: 14),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      CustomImage(
                        margin: getMargin(top: 50, bottom: 20),
                        pathOrUrl: customAssetImage('logo'),
                        fit: BoxFit.contain,
                        height: getVerticalSize(80),
                      ),
                      ProfileCard(
                        adminName:
                            "${controller.employeeModel.value?.firstName ?? ''} ${controller.employeeModel.value?.lastName ?? ''}",
                      )
                    ],
                  ),
                ),
                LargeText(
                  text: "Locations",
                  fontFamily: AppFonts.montserratBold,
                  size: getFontSize(24),
                  margin: getMargin(top: 40, left: 20),
                ),
                if (controller.isLoading.value)
                  Expanded(
                      child: Center(
                          child: CircularProgressIndicator(color: kPrimary)))
                else if (controller.locationsList.isEmpty)
                  Expanded(
                      child: Center(
                          child:
                              SmallText(text: "No Locations", color: kBlack)))
                else
                  Expanded(
                      child: ListView.builder(
                    padding: getPadding(left: 20, right: 20, bottom: 20),
                    itemCount: controller.locationsList.length,
                    itemBuilder: (context, index) {
                      final model = controller.locationsList[index];
                      return LocationCard(
                        address: model.address,
                        elevation: 4,
                        atms: model.atms,
                        details: model.city,
                        onTap: () async {
                          Services.showLoading();
                          controller.locationModel.value =
                              controller.locationsList[index];
                          await Get.to(() => EditStatusLocation());
                          Services.hideLoading();
                          // controller.locationModel.value = null;
                        },
                        locationName: model.locationName,

                      );
                    },
                  ))
              ],
            ),
          );
        });
  }
}
