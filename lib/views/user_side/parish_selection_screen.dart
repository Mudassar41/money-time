import 'package:atm_tracker/controllers/user_controller.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/views/user_side/banks_list_screen.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/bank_name_tile.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParishSelectionScreen extends StatelessWidget {
  final _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAppBar(),
            LargeText(
              text: "SELECT YOUR REGION",
              color: kWhite,
              fontFamily: AppFonts.montserratBold,
              size: getFontSize(24),
              margin: getMargin(left: 20, bottom: 2),
            ),
            CustomContainer(
              width: Get.width * 0.6,
              height: getVerticalSize(3),
              child: SizedBox(),
              isBorderRadius: true,
              color: kGrey,
              isShadow: false,
              margin: getMargin(left: 20),
            ),
            if (_userController.isLoading.value)
              Expanded(
                  child:
                      Center(child: CircularProgressIndicator(color: kWhite)))
            else if (_userController.parishMap.entries.isEmpty)
              Expanded(
                child: Center(
                  child: SmallText(
                    text: "No Regions",
                    color: kWhite,
                    fontFamily: AppFonts.montserratRegular,
                  ),
                ),
              )
            else
              Expanded(
                child: ListView(
                  padding: getPadding(left: 20, right: 20),
                  children: [
                    ..._userController.parishMap.entries.map((e) {
                      return BankNameTile(
                          name: e.key,
                          onTap: () {
                            _userController.parishName.value = e.key;
                            Get.to(() => BanksListScreen(
                                parishName: _userController.parishName.value));
                          });
                    })
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
