import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/views/authentication/custom_widgets/custom_curve.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/authentication/enter_employee_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeLoginScreen extends StatelessWidget {
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
              children: [
                CustomCurve(),
                CustomTextField(
                    controller: _authController.employeeLoginEmailController,
                    hint: "Unique code",
                    maxCharacters: 20,
                    validator: (v) =>
                        _authController.validateEmail(v!, "Employee"),
                    margin: getMargin(left: 20, right: 20, top: 20)),
                CustomTextField(
                  controller: _authController.employeeLoginPasswordController,
                  isPassword: true,
                  hint: "Password",
                  maxCharacters: 20,
                  validator: (v) => _authController.validatePassword(v!),
                  margin: getMargin(left: 20, right: 20),
                ),
                CustomButton(
                  title: "Sign In",
                  margin: getMargin(all: 20),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _authController.employeeSignIn();
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeText(
                        text: "New Team member? Register ",
                        size: getFontSize(18),
                        color: kBlack),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => EnterEmployeeDetailsScreen())!;
                          _authController.clearEmployeeControllers();
                        },
                        child: LargeText(
                            text: "Here",
                            size: getFontSize(18),
                            color: kTextButtonColor)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
