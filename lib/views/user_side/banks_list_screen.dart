import 'package:atm_tracker/controllers/user_controller.dart';
import 'package:atm_tracker/utils/constant/strings.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/views/user_side/bank_details_screen.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/bank_name_tile.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BanksListScreen extends StatelessWidget {
  final String parishName;

  BanksListScreen({required this.parishName});

  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAppBar(),
          LargeText(
              text: "BANKS",
              color: kWhite,
              fontFamily: AppFonts.montserratBold,
              size: getFontSize(24),
              margin: getMargin(left: 20, bottom: 2)),
          CustomContainer(
            width: Get.width * 0.6,
            height: getVerticalSize(3),
            child: SizedBox(),
            isBorderRadius: true,
            color: kGrey,
            isShadow: false,
            margin: getMargin(left: 20),
          ),
          SmallText(
            text: parishName,
            color: kWhite,
            margin: getMargin(left: 20),
            fontFamily: AppFonts.montserratRegular,
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              padding: getPadding(left: 20, right: 20, bottom: 20),
              itemCount: banksList.length,
              itemBuilder: (context, index) {
                return BankNameTile(
                    name: banksList[index],
                    onTap: () {
                      _userController.bankName.value = banksList[index];
                      _userController.getFilteredList();

                      Get.to(
                        () => BankDetailsScreen(
                          bankName: banksList[index],
                          bankId: index,
                        ),
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
