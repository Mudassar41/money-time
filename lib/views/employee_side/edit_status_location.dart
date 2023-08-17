import 'package:atm_tracker/controllers/employee_controlller.dart';
import 'package:atm_tracker/models/atm_model.dart';
import 'package:atm_tracker/utils/constant/const.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_image.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/employee_side/custom_widgets/employee_atm_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditStatusLocation extends StatelessWidget {
  EditStatusLocation();

  final controller = EmployeeController.instance;
  final minController = TextEditingController();
  final hourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Rx<String?> peopleInLine = controller.locationModel.value!.noOfPersons.obs;
    Rx<String?> averageWaitingTimeInMins =
        controller.locationModel.value!.avgWaitTimeInMin.obs;
    minController.text =
        controller.locationModel.value!.avgWaitTimeInMin ?? '0';
    hourController.text =
        controller.locationModel.value!.avgWaitTimeInHrs ?? '0';
    Rx<String?> averageWaitingTimeInHrs =
        controller.locationModel.value!.avgWaitTimeInHrs.obs;

    return Scaffold(
      appBar: AppBar(
        title: LargeText(
          text: "EDIT STATUS LOCATIONS",
          color: kWhite,
          fontFamily: AppFonts.montserratBold,
        ),
        backgroundColor: kPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: kWhite),
      ),
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: CustomContainer(
          isShadow: false,
          isBorderRadius: true,
          margin: getMargin(left: 20, right: 20, bottom: 10),
          width: Get.width,
          child: Obx(() {
            final locationModel = controller.locationModel.value!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainer(
                  isShadow: false,
                  height: Get.height * 0.3,
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: raduis_16,
                    child: CustomImage(
                        pathOrUrl: controller.locationModel.value!.imageUrl ??
                            customAssetImage('atm_placeholder'),
                        fit: BoxFit.fill),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: getPadding(left: 20, right: 20, top: 20, bottom: 20),
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
                            readOnly: true,
                            maxCharacters: 50,
                            initialValue: locationModel.locationName,
                          ),
                        ),
                        SizedBox(width: getHorizontalSize(10)),
                        Expanded(
                          child: CustomTextField(
                            maxCharacters: 50,
                            readOnly: true,
                            initialValue: locationModel.city,
                          ),
                        )
                      ],
                    ),
                    LargeText(
                      text: "Address",
                      size: getFontSize(20),
                      margin: getMargin(bottom: 10),
                      fontFamily: AppFonts.montserratBold,
                    ),
                    CustomTextField(
                      maxCharacters: 50,
                      readOnly: true,
                      initialValue: locationModel.address,
                    ),
                    LargeText(
                      text: "Region",
                      size: getFontSize(20),
                      margin: getMargin(bottom: 10),
                      fontFamily: AppFonts.montserratBold,
                    ),
                    CustomTextField(
                      initialValue: locationModel.parish,
                      maxCharacters: 50,
                      readOnly: true,
                      margin: getMargin(right: Get.width * 0.3),
                    ),
                    SizedBox(height: getVerticalSize(10)),
                    ListView.builder(
                      itemCount: locationModel.atms.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return EmployeeAtmBox(
                          onUpdateStatus: (newStatus) {
                            final List<AtmModel> atms = [];
                            for (var i = 0;
                                i < locationModel.atms.length;
                                i++) {
                              if (index == i) {
                                atms.add(locationModel.atms[i]
                                    .copyWith(isWorking: newStatus));
                              } else {
                                atms.add(locationModel.atms[i]);
                              }
                            }
                            controller.locationModel.value =
                                locationModel.copyWith(atms: atms);
                            controller.locationModel.refresh();
                          },
                          isWorkingStatus: locationModel.atms[index].isWorking,
                          atmName: locationModel.atms[index].atmName,
                        );
                      },
                    ),
                    SizedBox(height: getVerticalSize(30)),
                    Obx(
                      () {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LargeText(
                                  text: "Average waiting: ",
                                  size: getFontSize(18),
                                  fontFamily: AppFonts.montserratBold,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller
                                        .setHour(!controller.isHours.value);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: kPrimary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: !controller.isHours.value
                                                  ? Colors.white
                                                  : kPrimary,
                                            ),
                                            child: Center(
                                                child: SmallText(
                                              text: 'Min',
                                              fontFamily:
                                                  AppFonts.montserratRegular,
                                            )),
                                          ),
                                          Container(
                                            width: 60,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: !controller.isHours.value
                                                  ? kPrimary
                                                  : Colors.white,
                                            ),
                                            child: Center(
                                              child: SmallText(
                                                text: 'Hour',
                                                fontFamily:
                                                    AppFonts.montserratRegular,
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
                            SizedBox(height: 5),
                            if (controller.isHours.value == false) ...[
                              SmallText(
                                text: 'Min',
                                fontFamily: AppFonts.montserratRegular,
                              ),
                              SizedBox(height: 5),
                              CustomTextField(
                                maxCharacters: 3,
                                // initialValue: averageWaitingTimeInMins.value,
                                controller: minController,
                                inputType: TextInputType.number,
                                onChanged: (p0) {
                                  averageWaitingTimeInMins.value = p0;
                                  averageWaitingTimeInHrs.value = '0';
                                  hourController.text = '0';
                                },
                              )
                            ] else if (controller.isHours.value == true) ...[
                              SmallText(
                                text: 'Hour',
                                fontFamily: AppFonts.montserratRegular,
                              ),
                              SizedBox(height: 5),
                              CustomTextField(
                                maxCharacters: 1,
                                controller: hourController,
                                //  initialValue: averageWaitingTimeInHrs.value,
                                inputType: TextInputType.number,
                                onChanged: (p0) {
                                  averageWaitingTimeInHrs.value = p0;
                                  averageWaitingTimeInMins.value = '0';
                                  minController.text = '0';
                                },
                              ),
                            ]
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: getVerticalSize(20),
                    ),
                    Row(
                      children: [
                        LargeText(
                          text: "People in line: ",
                          size: getFontSize(18),
                          fontFamily: AppFonts.montserratBold,
                        ),
                        PopupMenuButton(
                          child: PhysicalModel(
                            color: kGrey,
                            borderRadius: BorderRadius.circular(16),
                            elevation: 6,
                            child: CustomContainer(
                                height: getVerticalSize(30),
                                isBorderRadius: true,
                                alignment: Alignment.center,
                                color: kGrey,
                                isShadow: false,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(width: getHorizontalSize(10)),
                                    Obx(
                                      () => LargeText(
                                        text: peopleInLine.value ?? '',
                                        size: getFontSize(18),
                                        fontFamily: AppFonts.montserratRegular,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: kBlack,
                                    )
                                  ],
                                )),
                          ),
                          itemBuilder: (context) =>
                              List.generate(35, (index) => index + 1)
                                  .map(
                                    (e) => PopupMenuItem(
                                      onTap: () {
                                        peopleInLine.value = e.toString();
                                        controller.locationModel.value =
                                            locationModel.copyWith(
                                          noOfPersons: peopleInLine.value,
                                        );
                                      },
                                      child: SmallText(
                                        text: e.toString(),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                        SizedBox(
                          width: getHorizontalSize(10),
                        ),
                        LargeText(
                          text: "Persons",
                          size: getFontSize(18),
                          color: Colors.black54,
                          fontFamily: AppFonts.montserratBold,
                        ),
                      ],
                    ),
                    SizedBox(height: getVerticalSize(60)),
                    CustomButton(
                      onTap: () {
                        controller.locationModel.value = locationModel.copyWith(
                          avgWaitTimeInMin: averageWaitingTimeInMins.value,
                          avgWaitTimeInHrs: averageWaitingTimeInHrs.value,
                          updatedAt: Timestamp.now(),
                          updated: true,
                        );
                        // print(averageWaitingTimeInMins.value);

                        controller.updateAtmDetails();
                      },
                      title: "Update",
                      color: kPrimary,
                      textColor: kWhite,
                      margin: getMargin(
                        left: Get.width * 0.2,
                        right: Get.width * 0.2,
                      ),
                    )
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
