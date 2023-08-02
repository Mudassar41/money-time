import 'package:atm_tracker/controllers/admin_controller.dart';
import 'package:atm_tracker/utils/constant/strings.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyFiltersScreen extends StatelessWidget {
  ApplyFiltersScreen({Key? key}) : super(key: key);
  final _adminController = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Column(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0.0),
            child: CustomTextField1(
              hint: "Select Region",
              readOnly: true,
              controller: _adminController.regionController,
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
                        _adminController.regionController.text =
                            _adminController.regions[index].name;

                        _adminController.getRegionBanks(
                            _adminController.regions[index].id!);
                        _adminController.bankNameController1.text='Select bank';
                      },
                      child: SmallText(
                        text: _adminController.regions[index].name,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Obx(
            () {
              if (_adminController.isLoadingRegionBanks.value) {
                return Center(child: CupertinoActivityIndicator());
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                  child: CustomTextField1(
                    hint: "Select bank",
                    readOnly: true,
                    validator: (v) => _adminController.fieldValidator(v!),
                    controller: _adminController.bankNameController1,
                    suffixIcon: PopupMenuButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: getSize(30),
                      ),
                      itemBuilder: (_) {
                        return List.generate(
                          _adminController.regionBanks.length,
                          (index) => PopupMenuItem(
                            onTap: () {
                              _adminController.bankNameController1.text =
                                  _adminController
                                      .regionBanks.value[index].name;
                            },
                            child: SmallText(
                              text:_adminController
                                  .regionBanks.value[index].name,
                              color: Colors.black,
                              maxLines: 2,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
          CustomButton(
            title: "Apply Filter",
            margin: getMargin(all: 20),
            onTap: () {
              if (_adminController.bankNameController1.text.isEmpty &&
                  _adminController.regionController.text.isEmpty) return;
              _adminController.isFiltered(true);
              _adminController.getFilteredLocations(
                _adminController.bankNameController1.text,
                _adminController.regionController.text,
              );

              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
