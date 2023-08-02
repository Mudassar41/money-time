import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/views/authentication/custom_widgets/auth_app_bar.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/authentication/employee_login_screen.dart';
import 'package:atm_tracker/views/authentication/forgot_password_screen.dart';
import 'package:atm_tracker/views/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoginScreen extends StatelessWidget {
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
                AuthAppBar(isFirstPage: true),
                SizedBox(height: getVerticalSize(30)),
                Center(
                  child: LargeText(
                    text: 'Welcome TO MONEY TIME',
                    color: kGreen,
                    fontFamily: AppFonts.montserratBold,
                  ),
                ),
                SizedBox(height: getVerticalSize(4)),
                Center(
                  child: LargeText(
                    text: 'Version: 1.2.4',
                    color: kBlack,
                    fontFamily: AppFonts.montserratBold,
                  ),
                ),
                SizedBox(height: Get.height * 0.12),
                CustomTextField(
                    hint: "Email",
                    controller: _authController.userLoginEmailController,
                    maxCharacters: 50,
                    validator: (v) => _authController.validateEmail(v!, "User"),
                    inputType: TextInputType.emailAddress),
                CustomTextField(
                    hint: "Password",
                    validator: (v) => _authController.validatePassword(v!),
                    maxCharacters: 20,
                    isPassword: true,
                    controller: _authController.userLoginPasswordController),
                SizedBox(height: getVerticalSize(30)),
                CustomButton(
                  title: "Sign In",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _authController.userSignIn();
                    }
                  },
                  width: Get.width,
                ),
                SizedBox(height: 15),
                InkWell(
                  onTap: () {
            Get.to(ForgotPassword());
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: LargeText(
                      text: "Forgot Password? ",
                      size: getFontSize(16),
                      fontFamily: AppFonts.montserratRegular,
                      color: kBlack,
                    ),
                  ),
                ),
                SizedBox(height: getVerticalSize(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeText(
                      text: "New Member? ",
                      size: getFontSize(18),
                      fontFamily: AppFonts.montserratBold,
                      color: kBlack,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignupScreen(creator: "User"));
                        _authController.clearUserControllers();
                      },
                      child: LargeText(
                          text: "Sign up Here",
                          fontFamily: AppFonts.montserratBold,
                          size: getFontSize(18),
                          color: kTextButtonColor),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeText(
                        text: "Team member click ",
                        fontFamily: AppFonts.montserratBold,
                        size: getFontSize(18),
                        color: kBlack),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => EmployeeLoginScreen());
                        _authController.clearUserControllers();
                      },
                      child: LargeText(
                        text: "Here",
                        fontFamily: AppFonts.montserratBold,
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
