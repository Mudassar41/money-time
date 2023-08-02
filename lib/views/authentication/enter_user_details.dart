import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/utils/constant/strings.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/views/authentication/create_password_screen.dart';
import 'package:atm_tracker/views/authentication/custom_widgets/auth_app_bar.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/authentication/user_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterUserDetailsScreen extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: getPadding(left: 20, right: 20),
        child: Container(
          height: Get.height,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthAppBar(),
                SizedBox(height: getVerticalSize(50)),
                Center(
                  child: LargeText(
                      text: "Create new account",
                      size: getFontSize(28),
                      margin: getMargin(top: 30, bottom: 20)),
                ),
                LargeText(
                    text: "Enter your details",
                    size: getFontSize(20),
                    decoration: TextDecoration.underline),
                LargeText(
                    text: "Primary Bank",
                    size: getFontSize(20),
                    margin: getMargin(top: 20, bottom: 10)),
                CustomTextField(
                    controller: _authController.userBankNameController,
                    validator: (v) => _authController.validateBankName(v!),
                    maxCharacters: 100,
                    hint: "Bank name",
                    readOnly: true,
                    suffixIcon: PopupMenuButton(
                      icon: Icon(Icons.arrow_drop_down, size: getSize(30)),
                      itemBuilder: (_) {
                        return List.generate(
                            banksList.length,
                            (index) => PopupMenuItem(
                                onTap: () {
                                  _authController.userBankNameController.text =
                                      banksList[index];
                                },
                                child: SmallText(text: banksList[index])));
                      },
                    )),
                // Padding(
                //   padding: getPadding(bottom: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       LargeText(text: "Age", size: getFontSize(20)),
                //       SizedBox(width: getHorizontalSize(160)),
                //       LargeText(text: "Sex", size: getFontSize(20)),
                //     ],
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Container(
                //         width: Get.width * 0.3,
                //         child: CustomTextField(
                //           controller: _authController.userAgeController,
                //           validator: (v) => _authController.validateAge(v!),
                //           hint: "Age in years",
                //           maxCharacters: 3,
                //           inputType: TextInputType.number,
                //         )),
                //     SizedBox(width: getHorizontalSize(50)),
                //     Obx(
                //       () => Radio(
                //           activeColor: kPrimary,
                //           value: "Male",
                //           groupValue: _authController.userSexValue.value,
                //           onChanged: (v) {
                //             _authController.userSexValue.value = v!;
                //           }),
                //     ),
                //     SmallText(text: "Male"),
                //     Obx(
                //       () => Radio(
                //           activeColor: kPrimary,
                //           value: "Female",
                //           groupValue: _authController.userSexValue.value,
                //           onChanged: (v) {
                //             _authController.userSexValue.value = v!;
                //           }),
                //     ),
                //     SmallText(text: "Female")
                //   ],
                // ),
                LargeText(
                    text: "Phone number",
                    size: getFontSize(20),
                    margin: getMargin(bottom: 10)),
                SmallText(
                    text: "Please enter phone starting with '+'",
                    margin: getMargin(bottom: 10)),
                CustomTextField(
                    controller: _authController.userPhoneNumberController,
                    validator: (v) => _authController.validatePhone(v!),
                    maxCharacters: 20,
                    inputType: TextInputType.phone,
                    hint: "+01-23-34444-4"),
                CustomButton(
                  title: "Continue",
                  width: Get.width,
                  margin: getMargin(top: 20, bottom: 10),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Get.to(() => AgeAndSexEnterView());
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
                      color: kBlack,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => UserLoginScreen());
                        _authController.clearUserControllers();
                      },
                      child: LargeText(
                        text: "Sign In",
                        size: getFontSize(18),
                        color: kTextButtonColor,
                      ),
                    )
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

class AgeAndSexEnterView extends StatelessWidget {
  AgeAndSexEnterView({Key? key}) : super(key: key);
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: getPadding(left: 20, right: 20),
        child: Container(
          height: Get.height,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthAppBar(),
                SizedBox(height: getVerticalSize(50)),
                Center(
                  child: LargeText(
                      text: "Create new account",
                      size: getFontSize(28),
                      margin: getMargin(top: 30, bottom: 20)),
                ),
                Padding(
                  padding: getPadding(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LargeText(text: "Age", size: getFontSize(20)),
                      SizedBox(width: getHorizontalSize(160)),
                      LargeText(text: "Sex", size: getFontSize(20)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.3,
                      child: CustomTextField(
                        controller: _authController.userAgeController,
                        validator: (v) => _authController.validateAge(v!),
                        hint: "Age in years",
                        maxCharacters: 3,
                        inputType: TextInputType.number,
                      ),
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Radio(
                            activeColor: kPrimary,
                            value: "Male",
                            groupValue: _authController.userSexValue.value,
                            onChanged: (v) {
                              _authController.userSexValue.value = v!;
                            },
                          ),
                        ),
                        SmallText(text: "Male"),
                        Obx(
                          () => Radio(
                            activeColor: kPrimary,
                            value: "Female",
                            groupValue: _authController.userSexValue.value,
                            onChanged: (v) {
                              _authController.userSexValue.value = v!;
                            },
                          ),
                        ),
                        SmallText(text: "Female")
                      ],
                    )
                  ],
                ),
                // LargeText(text: "Sex", size: getFontSize(20)),
                // Row(
                //   children: [
                //     Obx(
                //       () => Radio(
                //         activeColor: kPrimary,
                //         value: "Male",
                //         groupValue: _authController.userSexValue.value,
                //         onChanged: (v) {
                //           _authController.userSexValue.value = v!;
                //         },
                //       ),
                //     ),
                //     SmallText(text: "Male"),
                //     Obx(
                //       () => Radio(
                //         activeColor: kPrimary,
                //         value: "Female",
                //         groupValue: _authController.userSexValue.value,
                //         onChanged: (v) {
                //           _authController.userSexValue.value = v!;
                //         },
                //       ),
                //     ),
                //     SmallText(text: "Female"),
                //   ],
                // ),
                CustomButton(
                  title: "Continue",
                  width: Get.width,
                  margin: getMargin(top: 20, bottom: 10),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Get.to(() => CreatePasswordScreen(creator: "User"));
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
                          Get.offAll(() => UserLoginScreen());
                          _authController.clearUserControllers();
                        },
                        child: LargeText(
                            text: "Sign In",
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
