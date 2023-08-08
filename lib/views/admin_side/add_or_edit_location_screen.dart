import 'package:atm_tracker/controllers/admin_controller.dart';
import 'package:atm_tracker/controllers/image_controller.dart';
import 'package:atm_tracker/models/employee_model.dart';
import 'package:atm_tracker/models/location_model.dart';
import 'package:atm_tracker/utils/constant/const.dart';
import 'package:atm_tracker/utils/constant/strings.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_image.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/admin_side/custom_widgets/atm_box.dart';
import 'package:atm_tracker/views/admin_side/employees_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditLocationScreen extends StatelessWidget {
  final bool isNewLocation;
  final LocationModel? locationModel;

  AddEditLocationScreen({this.isNewLocation = true, this.locationModel});

  final _adminController = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        _adminController.clearValues();
        return true;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: kPrimary,
            onPressed: () {
              if (isNewLocation)
                _adminController.handleAddOrUpdateButtonPress(
                    isNewLocation, "");
              else
                _adminController.handleAddOrUpdateButtonPress(
                  isNewLocation,
                  locationModel!.locationId,
                  locationModel: locationModel,
                );
            },
            label: LargeText(
              text: isNewLocation ? "ADD LOCATION" : "UPDATE LOCATION",
              fontFamily: AppFonts.montserratBold,
              size: 18,
              color: kWhite,
            )),
        appBar: AppBar(
          title: LargeText(
            text: isNewLocation ? "ADD LOCATION" : 'EDIT LOCATION',
            fontFamily: AppFonts.montserratBold,
            color: kWhite,
          ),
          backgroundColor: kPrimary,
          elevation: 0,
          iconTheme: IconThemeData(color: kWhite),
        ),
        backgroundColor: kPrimary,
        body: CustomContainer(
          isShadow: false,
          isBorderRadius: true,
          margin: getMargin(left: 20, right: 20, bottom: 10),
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainer(
                  isShadow: false,
                  height: Get.height * 0.3,
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: raduis_16,
                    child: Obx(
                      () => CustomImage(
                        pathOrUrl: getImagePathOrUrl() ??
                            customAssetImage('atm_placeholder'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () async {
                        _adminController.atmImage.value = null;
                        _adminController.atmImage.value =
                            await ImageController.pickMediaWithCropper();
                      },
                      icon: CustomImage(
                        pathOrUrl: customAssetIcon("edit_image_icon"),
                        height: getVerticalSize(20),
                      ),
                      splashRadius: 0.1),
                ),
                Form(
                  key: _adminController.locationFormKey,
                  child: Obx(
                    () => ListView(
                        padding: getPadding(left: 20, right: 20, bottom: 20),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              LargeText(
                                text: "Location Name",
                                size: getFontSize(20),
                                fontFamily: AppFonts.montserratBold,
                              ),
                              SizedBox(width: getHorizontalSize(50)),
                              LargeText(
                                text: "City",
                                size: getFontSize(20),
                                fontFamily: AppFonts.montserratBold,
                              ),
                            ],
                          ),
                          SizedBox(height: getVerticalSize(10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  hint: "Location",
                                  maxCharacters: 30,
                                  validator: (v) =>
                                      _adminController.fieldValidator(v!),
                                  controller:
                                      _adminController.locationNameController,
                                ),
                              ),
                              SizedBox(
                                width: getHorizontalSize(10),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  hint: "City",
                                  maxCharacters: 30,
                                  validator: (v) =>
                                      _adminController.fieldValidator(v!),
                                  controller: _adminController.cityController,
                                ),
                              )
                            ],
                          ),
                          LargeText(
                            text: "Address",
                            fontFamily: AppFonts.montserratBold,
                            size: getFontSize(20),
                            margin: getMargin(bottom: 10),
                          ),
                          CustomTextField(
                            hint: "Address",
                            maxCharacters: 100,
                            validator: (v) =>
                                _adminController.fieldValidator(v!),
                            controller: _adminController.addressController,
                          ),
                          LargeText(
                            text: "Region",
                            size: getFontSize(20),
                            fontFamily: AppFonts.montserratBold,
                          ),
                          SizedBox(height: getVerticalSize(10)),
                          CustomTextField(
                            hint: "Select Region",
                            readOnly: true,
                            validator: (v) =>
                                _adminController.fieldValidator(v!),
                            controller: _adminController.parishController,
                            suffixIcon: PopupMenuButton(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                size: getSize(30),
                              ),
                              itemBuilder: (_) {
                                return List.generate(
                                  _adminController.regions.length,
                                  (index) => PopupMenuItem(
                                    onTap: () {
                                      _adminController.parishController.text =
                                          _adminController.regions[index].name;

                                      _adminController.getRegionBanks(
                                        _adminController.regions[index].id!,
                                      );
                                    },
                                    child: SmallText(
                                      text:
                                          _adminController.regions[index].name,
                                      color: Colors.black,
                                      maxLines: 2,
                                    ),
                                  ),
                                );
                              },
                            ),
                            maxCharacters: 100,
                          ),
                          // CustomTextField(
                          //     hint: "Region",
                          //     maxCharacters: 30,
                          //     validator: (v) =>
                          //         _adminController.fieldValidator(v!),
                          //     controller: _adminController.parishController),
                          SizedBox(height: getVerticalSize(10)),
                          Row(
                            children: [
                              // LargeText(
                              //   text: "Branch",
                              //   fontFamily: AppFonts.montserratBold,
                              //   size: getFontSize(20),
                              //   margin: getMargin(bottom: 10),
                              // ),
                              // SizedBox(width: getHorizontalSize(100)),
                              // Obx(() {
                              //   return Switch(
                              //       inactiveTrackColor: kRed,
                              //       thumbColor:
                              //           MaterialStatePropertyAll(kWhite),
                              //       activeColor: kGreen,
                              //       value: _adminController.branch.value,
                              //       onChanged: (v) {
                              //         print(v);
                              //         _adminController.branch.value = v;
                              //       });
                              // }),

                              Obx(
                                () {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _adminController.isBranch(
                                                  !_adminController
                                                      .isBranch.value);
                                              if (_adminController
                                                  .isBranch.value) {
                                                _adminController.offSite(false);
                                                _adminController.branch(true);
                                              } else {
                                                _adminController.offSite(true);
                                                _adminController.branch(false);
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: kPrimary,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: _adminController
                                                                .isBranch.value
                                                            ? Colors.white
                                                            : kPrimary,
                                                      ),
                                                      child: Center(
                                                          child: SmallText(
                                                        text: 'Branch',
                                                        fontFamily: AppFonts
                                                            .montserratRegular,
                                                      )),
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: _adminController
                                                                .isBranch.value
                                                            ? kPrimary
                                                            : Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: SmallText(
                                                          text: 'Offsite',
                                                          fontFamily: AppFonts
                                                              .montserratRegular,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     LargeText(
                          //       text: "Offsite",
                          //       size: getFontSize(20),
                          //       margin: getMargin(bottom: 10),
                          //     ),
                          //     SizedBox(
                          //       width: getHorizontalSize(100),
                          //     ),
                          // Obx(() {
                          //   return Switch(
                          //       inactiveTrackColor: kRed,
                          //       thumbColor:
                          //           MaterialStatePropertyAll(kWhite),
                          //       activeColor: kGreen,
                          //       value: _adminController.offSite.value,
                          //       onChanged: (v) {
                          //         print(v);
                          //         _adminController.offSite.value = v;
                          //       });
                          // }),
                          //     ],
                          //  ),
                          LargeText(
                            text: "Status",
                            size: getFontSize(20),
                            fontFamily: AppFonts.montserratBold,
                          ),
                          Row(
                            children: [
                              LargeText(
                                text: "Smart  ",
                                size: getFontSize(18),
                                color: Colors.black,
                                fontFamily: AppFonts.montserratBold,
                              ),
                              Obx(
                                () => Switch(
                                    inactiveTrackColor: kRed,
                                    thumbColor:
                                        MaterialStatePropertyAll(kWhite),
                                    activeColor: kGreen,
                                    value: _adminController.isSmart.value,
                                    onChanged: (v) {
                                      _adminController.isSmart.value = v;
                                    }),
                              ),
                              LargeText(
                                text: "Dual Currency ",
                                size: getFontSize(18),
                                fontFamily: AppFonts.montserratBold,
                                color: Colors.black,
                              ),
                              Obx(
                                () => Switch(
                                    inactiveTrackColor: kRed,
                                    thumbColor:
                                        MaterialStatePropertyAll(kWhite),
                                    activeColor: kGreen,
                                    value:
                                        _adminController.isDualCurrency.value,
                                    onChanged: (v) {
                                      _adminController.isDualCurrency.value = v;
                                    }),
                              )
                            ],
                          ),

                          Row(
                            children: [
                              LargeText(
                                text: "Drive through  ",
                                size: getFontSize(18),
                                color: Colors.black,
                                fontFamily: AppFonts.montserratBold,
                              ),
                              Obx(
                                () => Switch(
                                    inactiveTrackColor: kRed,
                                    thumbColor:
                                        MaterialStatePropertyAll(kWhite),
                                    activeColor: kGreen,
                                    value: _adminController.driveThrough.value,
                                    onChanged: (v) {
                                      _adminController.driveThrough.value = v;
                                    }),
                              ),
                            ],
                          ),

                          CustomButton(
                            title: "Select Employee",
                            textColor: kWhite,
                            color: kPrimary,
                            margin: getMargin(top: 10, bottom: 10),
                            onTap: () {
                              _adminController.getEmployees();
                              Get.to(() => EmployeeListScreen());
                            },
                          ),
                          if (_adminController.employeeId.value != '')
                            SmallText(
                                text: "Selected Employee: ${getEmployeeName()}",
                                margin: getMargin(top: 10, bottom: 10)),
                          Obx(
                            () => ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _adminController.atmsList.length,
                              itemBuilder: (context, index) {
                                return AtmBox(
                                  atmModel: _adminController.atmsList[index],
                                  onTap: () {
                                    _adminController.atmsList.removeAt(index);
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: getVerticalSize(20),
                          ),
                          PhysicalModel(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(16),
                            elevation: 4,
                            child: CustomContainer(
                                width: Get.width,
                                isBorderRadius: true,
                                padding: getPadding(all: 10),
                                isShadow: false,
                                borderColor: kPrimary,
                                child: Form(
                                  key: _adminController.atmFormKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          LargeText(
                                            text: "Add ATM",
                                            fontFamily: AppFonts.montserratBold,
                                            size: getFontSize(20),
                                            color: Colors.black,
                                          ),
                                          Spacer(),
                                          LargeText(
                                            text: "Working  ",
                                            size: getFontSize(20),
                                            fontFamily: AppFonts.montserratBold,
                                            color: Colors.black54,
                                          ),
                                          Obx(
                                            () => Switch(
                                              inactiveTrackColor: kRed,
                                              thumbColor:
                                                  MaterialStatePropertyAll(
                                                kWhite,
                                              ),
                                              activeColor: kGreen,
                                              value: _adminController
                                                  .isWorking.value,
                                              onChanged: (v) {
                                                _adminController
                                                    .isWorking.value = v;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: getVerticalSize(10)),
                                      CustomTextField(
                                        hint: "ATM Name",
                                        maxCharacters: 25,
                                        validator: (v) =>
                                            _adminController.fieldValidator(v!),
                                        controller:
                                            _adminController.atmNameController,
                                      ),
                                      CustomTextField(
                                        hint: "Bank Name",
                                        maxCharacters: 100,
                                        readOnly: true,
                                        validator: (v) =>
                                            _adminController.fieldValidator(v!),
                                        controller:
                                            _adminController.bankNameController,
                                        suffixIcon: PopupMenuButton(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            size: getSize(30),
                                          ),
                                          itemBuilder: (_) {
                                            return List.generate(
                                              _adminController
                                                  .regionBanks.length,
                                              (index) => PopupMenuItem(
                                                onTap: () {
                                                  _adminController
                                                          .bankNameController
                                                          .text =
                                                      _adminController
                                                          .regionBanks
                                                          .value[index]
                                                          .name;
                                                },
                                                child: SmallText(
                                                  text: _adminController
                                                      .regionBanks
                                                      .value[index]
                                                      .name,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _adminController.addAtmToList();
                                        },
                                        child: Center(
                                          child: LargeText(
                                            text: "ADD",
                                            color: kPrimary,
                                            fontFamily: AppFonts.montserratBold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: getVerticalSize(50),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImagePathOrUrl() {
    if (isNewLocation) {
      if (_adminController.atmImage.value != null) {
        return _adminController.atmImage.value!.path;
      }
    } else {
      if (_adminController.atmImage.value == null) {
        return _adminController.atmImageUrl.value;
      } else {
        return _adminController.atmImage.value!.path;
      }
    }
  }

  String? getEmployeeName() {
    for (EmployeeModel employee in _adminController.employeesList) {
      if (employee.employeeId == _adminController.employeeId.value) {
        return employee.firstName;
      }
    }
    return null;
  }
}
