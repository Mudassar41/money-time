import 'package:atm_tracker/utils/constant/const.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/atm_name_container.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationCard extends StatelessWidget {
  final String locationName;
  final String address;
  final String details;
  final num elevation;
  final VoidCallback onTap;
  final List atms;
  final String? parish;

  LocationCard(
      {required this.address,
      required this.atms,
      required this.details,
      this.elevation = 0.0,
      required this.onTap,
      this.parish,
      required this.locationName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 5, bottom: 5),
      child: GestureDetector(
        onTap: onTap,
        child: PhysicalModel(
          color: kWhite,
          elevation: elevation.toDouble(),
          borderRadius: raduis_12,
          child: CustomContainer(
              // width: Get.width,
              // height: Get.height * 0.2,

              isBorderRadius: true,
              isShadow: false,
              padding: getPadding(
                left: 10,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LargeText(
                    text: locationName,
                    size: 16,
                    color: kBlack,
                    fontFamily: AppFonts.montserratBold,
                  ),
                  SizedBox(height: 3),
                  SmallText(
                    text: address,
                    color: kBlack,
                    size: 14,
                    fontFamily: AppFonts.montserratRegular,
                  ),
                  SizedBox(height: 3),
                  SmallText(
                    text: details,
                    fontFamily: AppFonts.montserratRegular,
                    color: kBlack,
                    size: 14,
                  ),
                  if (parish != null) ...[
                    SizedBox(height: 3),
                    SmallText(
                      text: parish!,
                      color: kBlack,
                      size: 14,
                      fontFamily: AppFonts.montserratBold,
                    ),
                  ],
                  SizedBox(height: 6),
                  Container(
                    height: getVerticalSize(34),
                    // width: Get.width,
                    child: ListView.builder(
                      itemCount: atms.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return AtmNameContainer(
                          atmName: atms[index].atmName,
                        );
                      },
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
