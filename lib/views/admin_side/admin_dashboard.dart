import 'package:atm_tracker/controllers/admin_controller.dart';
import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_image.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/views/admin_side/ads_list_screen.dart';
import 'package:atm_tracker/views/admin_side/custom_widgets/big_button.dart';
import 'package:atm_tracker/views/admin_side/employee_ids_screen.dart';
import 'package:atm_tracker/views/admin_side/location_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  final _adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomContainer(
            color: kPrimary,
            isBorderRadius: false,
            height: Get.height * 0.3,
            width: Get.width,
            child: CustomContainer(
              isShadow: false,
              margin: getMargin(left: 20, right: 20, top: 60, bottom: 20),
              padding: getPadding(left: 20, right: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomImage(
                      pathOrUrl: customAssetImage('logo'),
                      fit: BoxFit.contain,
                      height: getVerticalSize(80),
                    ),
                  ),
                  LargeText(
                    text: "Hi Admin",
                    size: getFontSize(20),
                    fontFamily: AppFonts.montserratBold,
                  ),
                  SizedBox(height: getVerticalSize(6)),
                  LargeText(
                    text: "atm.tracker12@gmail.com",
                    size: getFontSize(16),
                    fontFamily: AppFonts.montserratBold,
                  ),
                  SizedBox(height: getVerticalSize(20)),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                      title: "Sign out",
                      width: getHorizontalSize(130),
                      height: getVerticalSize(30),
                      onTap: () {
                        Get.defaultDialog(
                          title: "Are your sure?",
                          textCancel: "No",
                          textConfirm: "Yes",
                          cancelTextColor: kPrimary,
                          confirmTextColor: kRed,
                          content: SmallText(text: "Do you want to log out?"),
                          onConfirm: () {
                            _authController.userOrAdminLogOut();
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: getVerticalSize(50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BigButton(
                buttonName: "Team Member ID'S",
                iconName: "admin_settings",
                onTap: () {
                  Get.to(() => EmployeeIDsScreen());
                },
              ),
              BigButton(
                buttonName: "LOCATIONS",
                iconName: "atm_icon",
                onTap: () {
                  _adminController.getLocations();
                  Get.to(() => LocationListScreen());
                },
              )
            ],
          ),
          SizedBox(height: getVerticalSize(30)),
          Padding(
            padding: getPadding(left: 40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: BigButton(
                buttonName: "ADs",
                iconName: "ad_icon",
                onTap: () async {
                  Get.to(AdsListScreen());
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
