import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/views/authentication/custom_widgets/auth_app_bar.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterEmployeeDetailsScreen extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthAppBar(),
                SizedBox(height: Get.height * 0.06),
                Align(
                  alignment: Alignment.center,
                  child: LargeText(
                      text: "Registration",
                      size: getFontSize(28),
                      margin: getMargin(top: 30, bottom: 20)),
                ),
                Padding(
                  padding: getPadding(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LargeText(text: "First Name", size: getFontSize(20)),
                      SizedBox(width: getHorizontalSize(130)),
                      LargeText(text: "Last Name", size: getFontSize(20))
                    ],
                  ),
                ),
                SizedBox(height: getVerticalSize(10)),
                Padding(
                  padding: getPadding(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: Get.width * 0.4,
                          child: CustomTextField(
                              controller:
                                  _authController.employeeFirstNameController,
                              validator: (v) =>
                                  _authController.validateFullName(v!),
                              maxCharacters: 20,
                              hint: "First Name")),
                      SizedBox(width: getHorizontalSize(40)),
                      Container(
                          width: Get.width * 0.4,
                          child: CustomTextField(
                              controller:
                                  _authController.employeeLastNameController,
                              maxCharacters: 20,
                              validator: (v) =>
                                  _authController.validateFullName(v!),
                              hint: "Last Name")),
                    ],
                  ),
                ),
                LargeText(
                    text: "Phone number",
                    size: getFontSize(20),
                    margin: getMargin(bottom: 10, left: 20)),
                SmallText(
                    text: "Please enter phone staring with '+'",
                    margin: getMargin(bottom: 10, left: 20)),
                CustomTextField(
                    controller: _authController.employeePhoneNumberController,
                    validator: (v) => _authController.validatePhone(v!),
                    maxCharacters: 20,
                    margin: getMargin(left: 20, right: 20),
                    inputType: TextInputType.phone,
                    hint: "+01-23-34444-4"),
                LargeText(
                    text: "Email",
                    size: getFontSize(20),
                    margin: getMargin(bottom: 10, left: 20)),
                CustomTextField(
                    hint: "james12@gmail.com",
                    controller: _authController.employeeSignUpEmailController,
                    maxCharacters: 50,
                    margin: getMargin(left: 20, right: 20),
                    validator: (v) => _authController.validateEmail(v!, "User"),
                    inputType: TextInputType.emailAddress),
                SizedBox(height: getVerticalSize(30)),
                CustomButton(
                  title: "Next",
                  margin: getMargin(left: 20, right: 20),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Get.to(() => SignupScreen(creator: "Employee"));
                    }
                  },
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeText(
                        text: "Already have an account? ",
                        size: getFontSize(18),
                        color: kBlack),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                          _authController.clearEmployeeControllers();
                        },
                        child: LargeText(
                            text: "Sign in",
                            size: getFontSize(18),
                            color: kTextButtonColor))
                  ],
                ),
                SizedBox(height: getVerticalSize(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
