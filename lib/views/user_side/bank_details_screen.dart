import 'package:atm_tracker/controllers/user_controller.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/location_card.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankDetailsScreen extends StatelessWidget {
  final int bankId;
  final String bankName;

  BankDetailsScreen({
    required this.bankName,
    required this.bankId,
  });

  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_userController.isAdLoading.value;
      },
      child: Scaffold(
        backgroundColor: kPrimary,
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAppBar(
                onBackPressed: () {
                  Get.back();
                  _userController.filter.value = "None";
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LargeText(
                            text: bankName,
                            color: kWhite,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: AppFonts.montserratBold,
                            size: getFontSize(24),
                            margin: getMargin(left: 20, bottom: 2)),
                        CustomContainer(
                          width: Get.width * 0.5,
                          height: getVerticalSize(3),
                          child: SizedBox(),
                          isBorderRadius: true,
                          color: kGrey,
                          isShadow: false,
                          margin: getMargin(left: 20),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SmallText(
                    text: "FILTER  ",
                    color: kWhite,
                    fontFamily: AppFonts.montserratBold,
                  ),
                  PopupMenuButton(
                    child: Icon(Icons.menu, color: kWhite),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            child: SmallText(
                              text: "Favourites",
                              fontFamily: AppFonts.montserratRegular,
                            ),
                            onTap: () {
                              _userController.filter.value = "Favourites";
                              _userController.getFilteredList();
                            }),
                        PopupMenuItem(
                            child: SmallText(
                              text: "Dual Currency",
                              fontFamily: AppFonts.montserratRegular,
                            ),
                            onTap: () {
                              _userController.filter.value = "Dual Currency";
                              _userController.getFilteredList();
                            }),
                        PopupMenuItem(
                            child: SmallText(
                              text: "Smart",
                              fontFamily: AppFonts.montserratRegular,
                            ),
                            onTap: () {
                              _userController.filter.value = "Smart";
                              _userController.getFilteredList();
                            }),
                        PopupMenuItem(
                            child: SmallText(
                              text: "Off Site",
                              fontFamily: AppFonts.montserratRegular,
                            ),
                            onTap: () {
                              _userController.filter.value = "offSite";
                              _userController.getFilteredList();
                            }),
                        PopupMenuItem(
                            child: SmallText(
                              text: "Branch",
                              fontFamily: AppFonts.montserratRegular,
                            ),
                            onTap: () {
                              _userController.filter.value = "branch";
                              _userController.getFilteredList();
                            }),


                        PopupMenuItem(
                            child: SmallText(
                              text: "Drive through",
                              fontFamily: AppFonts.montserratRegular,
                            ),
                            onTap: () {
                              _userController.filter.value = "drive";
                              _userController.getFilteredList();
                            }),
                        PopupMenuItem(
                          child: SmallText(
                            text: "All",
                            fontFamily: AppFonts.montserratRegular,
                          ),
                          onTap: () {
                            _userController.filter.value = "None";
                            _userController.getFilteredList();
                          },
                        )
                      ];
                    },
                  ),
                  SizedBox(width: getHorizontalSize(4))
                ],
              ),
              if (_userController.isLoading.value)
                Expanded(
                    child:
                        Center(child: CircularProgressIndicator(color: kWhite)))
              else if (_userController.filteredList.isEmpty)
                Expanded(
                  child: Center(
                    child: SmallText(
                      text: "No ATMs",
                      color: kWhite,
                      fontFamily: AppFonts.montserratRegular,
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding:
                        getPadding(left: 20, right: 20, top: 15, bottom: 15),
                    itemCount: _userController.filteredList.length,
                    itemBuilder: (context, index) {
                      return LocationCard(
                        address: _userController.filteredList[index].address,
                        atms: _userController.filteredList[index].atms,
                        details: _userController.getAtmDetails(index),
                        onTap: () {
                          _userController.getRemoteAdVideo(index, bankId);
                        },
                        locationName:
                            _userController.filteredList[index].locationName,
                      );
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
