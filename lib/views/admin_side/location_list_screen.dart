import 'package:atm_tracker/controllers/admin_controller.dart';
import 'package:atm_tracker/utils/constant/strings.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/utils/widgets/location_card.dart';
import 'package:atm_tracker/views/admin_side/add_or_edit_location_screen.dart';
import 'package:atm_tracker/views/admin_side/apply_filters_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationListScreen extends StatelessWidget {
  final _adminController = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => AddEditLocationScreen());
          },
          label: LargeText(
            text: "+ ADD LOCATIONS",
            color: kPrimary,
            fontFamily: AppFonts.montserratBold,
          )),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getVerticalSize(60)),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: kWhite,
                size: getSize(40),
              ),
            ),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LargeText(
                        text: "LIST OF LOCATIONS",
                        color: kWhite,
                        fontFamily: AppFonts.montserratBold,
                        size: getFontSize(24),
                        margin: getMargin(left: 20, bottom: 4, top: 20),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(ApplyFiltersScreen());
                        },
                        icon: Icon(
                          Icons.filter_alt_sharp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  if (_adminController.isFiltered.value)
                    TextButton(
                      onPressed: () {
                        _adminController.isFiltered(false);
                        _adminController.bankNameController1.clear();
                        _adminController.regionController.clear();
                        _adminController.getLocations();
                      },
                      child: Text('Remove Filters'),
                    )
                ],
              ),
            ),
            CustomContainer(
              width: Get.width,
              height: getVerticalSize(3),
              child: SizedBox(),
              isBorderRadius: true,
              color: kGrey,
              isShadow: false,
              margin: getMargin(left: 20, bottom: 20, right: 20),
            ),
            //////////////////
            // CustomTextField(
            //   hint: "Bank Name",
            //   maxCharacters: 100,
            //   readOnly: true,
            //   validator: (v) => _adminController.fieldValidator(v!),
            //   controller: _adminController.bankNameController1,
            //   suffixIcon: PopupMenuButton(
            //     icon: Icon(
            //       Icons.arrow_drop_down,
            //       size: getSize(30),
            //     ),
            //     itemBuilder: (_) {
            //       return List.generate(
            //         banksList.length,
            //         (index) => PopupMenuItem(
            //           onTap: () {
            //             _adminController.bankNameController1.text =
            //                 banksList[index];
            //           },
            //           child: SmallText(
            //             text: banksList[index],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            /////////////
            if (_adminController.isLocationListLoading.value)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: kWhite),
                ),
              )
            else if (_adminController.locationsList.isEmpty)
              Expanded(
                child: Center(
                  child: SmallText(text: "No Locations", color: kWhite),
                ),
              )
            else
              Expanded(
                  child: Obx(
                () => ListView.builder(
                  padding: getPadding(left: 20, right: 20, bottom: 80),
                  itemCount: _adminController.locationsList.length,
                  itemBuilder: (context, index) {
                    return LocationCard(
                      address: _adminController.locationsList[index].address,
                      atms: _adminController.locationsList[index].atms,
                      details: _adminController.locationsList[index].city,
                      onTap: () {
                        _adminController.editLocationValues(index);
                      },
                      locationName:
                          _adminController.locationsList[index].locationName,
                    );
                  },
                ),
              ))
          ],
        ),
      ),
    );
  }
}
