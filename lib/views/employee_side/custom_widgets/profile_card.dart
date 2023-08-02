import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCard extends StatelessWidget {
  final String adminName;

  ProfileCard({required this.adminName});

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        isBorderRadius: true,
        isShadow: false,
        padding: getPadding(all: 14),
        width: Get.width,
        height: Get.height * 0.14,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LargeText(
              text: adminName,
              size: getFontSize(20),
              fontFamily: AppFonts.montserratBold,
            ),
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
                        _authController.employeeLogOut();
                      },
                    );
                  },
                ))
          ],
        ));
  }
}
