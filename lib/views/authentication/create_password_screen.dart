import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/views/authentication/custom_widgets/auth_app_bar.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePasswordScreen extends StatelessWidget {
  final String creator;

  CreatePasswordScreen({required this.creator});

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
                SizedBox(height: Get.height * 0.1),
                LargeText(
                    text: "Create a password for your account",
                    size: getFontSize(28),
                    maxLines: 2,
                    margin: getMargin(top: 30, bottom: 20)),
                CustomTextField(
                  controller: _authController.signUpPasswordController,
                  hint: "Password",
                  maxCharacters: 20,
                  validator: (v) => _authController.validatePassword(v!),
                  isPassword: true,
                ),
                CustomTextField(
                  controller: _authController.signUpConfirmPasswordController,
                  maxCharacters: 20,
                  hint: "Confirm Password",
                  isPassword: true,
                  validator: (v) => _authController.validateConfirmPassword(v!),
                  margin: getMargin(bottom: 20),
                ),
                CustomButton(
                  title: "Create account",
                  width: Get.width,
                  onTap: () {
                    if (creator == "User") {
                      if (_formKey.currentState!.validate())
                        _authController.userSignUp();
                      // _authController.adminSignUp();
                    } else {
                      if (_formKey.currentState!.validate())
                        _authController.employeeSignUp();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
