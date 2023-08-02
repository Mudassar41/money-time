import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_image.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/views/user_side/parish_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLandingPage extends StatelessWidget {
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.2,
            color: kPrimary,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomImage(
                  margin: getMargin(top: 70),
                  pathOrUrl: customAssetImage('logo'),
                  height: getSize(100),
                ),
                SizedBox(width: getHorizontalSize(20)),
                Padding(
                  padding: getPadding(top: 50),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
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
                      child: LargeText(
                        text: "Sign out",
                        fontFamily: AppFonts.montserratBold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomContainer(
                  width: Get.width * 0.8,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: getFontSize(24),
                          color: kGreen,
                          fontFamily: AppFonts.montserratRegular),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'W',
                          style: TextStyle(
                              fontSize: getFontSize(40),
                              fontFamily: AppFonts.montserratBold),
                        ),
                        TextSpan(text: 'elcome to '),
                        TextSpan(
                          text: 'Moneytime ',
                          style: TextStyle(
                              fontSize: getFontSize(40),
                              fontFamily: AppFonts.montserratBold),
                        ),
                        TextSpan(
                            text:
                                'atm tracker app, Jamaica’s number 1 atm tracker with daily real time updates.')
                      ],
                    ),
                  ),
                  padding: getPadding(top: 60, bottom: 60, left: 10),
                ),
                CustomButton(
                  title: "SELECT YOUR REGION",
                  color: Color(0xFF00FF2B).withOpacity(0.2),
                  textColor: kBlack,
                  width: Get.width * 0.7,
                  onTap: () {
                    Get.to(() => ParishSelectionScreen());
                  },
                ),
                SizedBox(height: getVerticalSize(2))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
