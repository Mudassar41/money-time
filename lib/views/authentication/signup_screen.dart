import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/views/authentication/custom_widgets/auth_app_bar.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/authentication/employee_login_screen.dart';
import 'package:atm_tracker/views/authentication/enter_user_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  final String creator;

  SignupScreen({required this.creator});

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
                SizedBox(height: getVerticalSize(50)),
                Align(
                  alignment: Alignment.center,
                  child: titleTextSelector(),
                ),
                headingTextSelector(),
                CustomTextField(
                  margin: getMargin(top: 20, left: 20, right: 20),
                  hint: creator == "Employee" ? "Unique ID" : "Email",
                  maxCharacters: 50,
                  controller: _authController.signUpEmailOrIdController,
                  validator: (v) => _authController.validateEmail(v!, creator),
                  inputType: creator == "Employee"
                      ? TextInputType.text
                      : TextInputType.emailAddress,
                ),
                CustomButton(
                  title: "Continue",
                  width: Get.width,
                  margin: getMargin(top: 20, left: 20, right: 20),
                  onTap: () async {
                    if (creator == "User") {
                      if (_formKey.currentState!.validate())
                        Get.to(() => EnterUserDetailsScreen());
                    } else {
                      if (_formKey.currentState!.validate()) {
                        await _authController.assignEmployeeId();
                      }
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
                          if (creator == "Employee")
                            Get.offAll(() => EmployeeLoginScreen());
                          else
                            Get.back();
                          _authController.clearEmployeeControllers();
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

  LargeText titleTextSelector() {
    if (creator == 'User')
      return LargeText(
          text: "Create new account",
          size: getFontSize(28),
          margin: getMargin(top: 30, bottom: 20));
    else
      return LargeText(
          text: "Registration",
          size: getFontSize(28),
          margin: getMargin(top: 30, bottom: 30));
  }

  LargeText headingTextSelector() {
    if (creator == "Employee")
      return LargeText(
          text: "What's your Employee Id?",
          size: getFontSize(20),
          margin: getMargin(left: 20));
    else
      return LargeText(
          text: "What's your Email?",
          size: getFontSize(20),
          margin: getMargin(left: 20));
  }
}
