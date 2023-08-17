import 'package:atm_tracker/controllers/user_controller.dart';
import 'package:atm_tracker/models/location_model.dart';
import 'package:atm_tracker/utils/constant/const.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_image.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/user_appbar.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/user_atm_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AtmDetailsScreen extends StatelessWidget {
  final LocationModel locationModel;

  AtmDetailsScreen({required this.locationModel});

  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAppBar(),
            LargeText(
              text: "ATM DETAILS",
              color: kWhite,
              size: getFontSize(24),
              margin: getMargin(left: 20),
              fontFamily: AppFonts.montserratBold,
            ),
            SizedBox(height: 10),
            CustomContainer(
                margin: getMargin(left: 20, right: 20),
                height: Get.height * 0.8,
                isShadow: false,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CustomContainer(
                            isShadow: false,
                            child: ClipRRect(
                              borderRadius: raduis_16,
                              child: CustomImage(
                                pathOrUrl: locationModel.imageUrl ??
                                    customAssetImage("atm_placeholder"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white30,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  _userController.addOrRemoveFavourite(
                                      locationModel.locationId);
                                },
                                icon: Obx(
                                  () => Icon(
                                    _userController.favouriteAtmsList
                                            .contains(locationModel.locationId)
                                        ? Icons.favorite
                                        : Icons.favorite_outline_sharp,
                                    size: getSize(30),
                                    color: _userController.favouriteAtmsList
                                            .contains(locationModel.locationId)
                                        ? kPrimary
                                        : kBlack,
                                  ),
                                ),
                                splashRadius: 0.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: getPadding(
                            left: 20, right: 20, bottom: 40, top: 20),
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LargeText(
                                      text: "Location",
                                      size: getFontSize(20),
                                      fontFamily: AppFonts.montserratBold,
                                    ),
                                    SizedBox(height: 2),
                                    LargeText(
                                      text: locationModel.locationName,
                                      color: Colors.black,
                                      size: getFontSize(16),
                                      fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: AppFonts.montserratRegular,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: getHorizontalSize(20)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LargeText(
                                      text: "City",
                                      size: getFontSize(20),
                                      fontFamily: AppFonts.montserratBold,
                                    ),
                                    SizedBox(height: 2),
                                    LargeText(
                                      text: locationModel.city,
                                      color: Colors.black,
                                      fontFamily: AppFonts.montserratRegular,
                                      size: getFontSize(16),
                                      fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getVerticalSize(30)),
                          LargeText(
                            text: "Address",
                            size: getFontSize(20),
                            fontFamily: AppFonts.montserratBold,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          LargeText(
                            text: locationModel.address,
                            color: Colors.black,
                            fontFamily: AppFonts.montserratRegular,
                            size: getFontSize(16),
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: getVerticalSize(30)),
                          LargeText(
                            text: "Region",
                            size: getFontSize(20),
                            fontFamily: AppFonts.montserratBold,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          LargeText(
                            text: locationModel.parish,
                            color: Colors.black,
                            fontFamily: AppFonts.montserratRegular,
                            size: getFontSize(16),
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: getVerticalSize(30)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LargeText(
                                text: "ATM's Available",
                                size: getFontSize(20),
                                fontFamily: AppFonts.montserratBold,
                              ),
                              CustomContainer(
                                child: LargeText(
                                  text: locationModel.atms.length.toString(),
                                  size: getFontSize(16),
                                  fontFamily: AppFonts.montserratRegular,
                                ),
                                padding: getPadding(
                                  top: 4,
                                  bottom: 4,
                                  left: 16,
                                  right: 16,
                                ),
                                color: kGrey,
                              )
                            ],
                          ),
                          SizedBox(height: getVerticalSize(10)),
                          ListView.builder(
                              itemCount: locationModel.atms.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return UserAtmBox(
                                  //todo
                                  isDrive:
                                      locationModel.atms[index].driveThrough,
                                  atmName: locationModel.atms[index].atmName,
                                  bankName: locationModel.atms[index].bankName,
                                  isDualCurrency:
                                      locationModel.atms[index].isDualCurrency,
                                  isSmart: true,
                                  isWorking:
                                      locationModel.atms[index].isWorking,
                                  isBranch: true,
                                );
                              }),
                          SizedBox(height: 10),
                          // Align(
                          //   alignment: Alignment.topRight,
                          //   child: InkWell(
                          //     onTap: () {
                          //       Get.back();
                          //       _userController.filter.value = "None";
                          //     },
                          //     child: LargeText(
                          //       text: "Back to search",
                          //       size: 16,
                          //       color: Colors.blue,
                          //     ),
                          //   ),
                          // ),
                          //SizedBox(height: getVerticalSize(30)),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LargeText(
                                    text: "People in line:",
                                    size: 14,
                                    fontFamily: AppFonts.montserratBold,
                                  ),
                                  SizedBox(height: getVerticalSize(20)),
                                  LargeText(
                                    text: "Average waiting time:",
                                    size: 14,
                                    fontFamily: AppFonts.montserratBold,
                                  ),
                                  SizedBox(height: getVerticalSize(20)),
                                  if (locationModel.updated!)
                                    LargeText(
                                      text: "Updated at",
                                      size: 14,
                                      fontFamily: AppFonts.montserratBold,
                                    )
                                ],
                              ),
                              SizedBox(
                                width: getHorizontalSize(20),
                              ),
                              Container(
                                height: getVerticalSize(80),
                                width: getHorizontalSize(2),
                                color: kBlack,
                              ),
                              SizedBox(
                                width: getHorizontalSize(20),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomContainer(
                                      child: LargeText(
                                        text: locationModel.noOfPersons
                                            .toString(),
                                        size: getFontSize(16),
                                        fontFamily: AppFonts.montserratRegular,
                                      ),
                                      padding: getPadding(
                                        top: 4,
                                        bottom: 4,
                                        left: 16,
                                        right: 16,
                                      ),
                                      color: kGrey),
                                  SizedBox(
                                    height: getVerticalSize(20),
                                  ),
                                  Row(
                                    children: [
                                      ...[
                                        if (locationModel.avgWaitTimeInMin ==
                                            '0')
                                          if (locationModel.avgWaitTimeInHrs ==
                                              '0')
                                            Text("0 min",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: AppFonts
                                                        .montserratRegular))
                                      ],
                                      if (locationModel?.avgWaitTimeInMin
                                                  ?.isNotEmpty ==
                                              true &&
                                          locationModel.avgWaitTimeInMin != '0')
                                        LargeText(
                                          text:
                                              "${locationModel.avgWaitTimeInMin} min",
                                          size: getFontSize(16),
                                          fontFamily:
                                              AppFonts.montserratRegular,
                                        ),
                                      SizedBox(width: 10),
                                      if (locationModel?.avgWaitTimeInHrs
                                                  ?.isNotEmpty ==
                                              true &&
                                          locationModel.avgWaitTimeInHrs != '0')
                                        LargeText(
                                          text:
                                              "${locationModel.avgWaitTimeInHrs} Hour",
                                          size: getFontSize(16),
                                          fontFamily:
                                              AppFonts.montserratRegular,
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  if (locationModel.updated!)
                                    LargeText(
                                      text:
                                          "${DateFormat('dd/MM/yyyy').format(DateTime.parse(locationModel.updatedAt!.toDate().toString()))}",
                                      size: getFontSize(16),
                                      fontFamily: AppFonts.montserratRegular,
                                    ),
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
