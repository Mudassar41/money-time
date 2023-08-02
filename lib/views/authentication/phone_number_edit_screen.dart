import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/authentication/custom_widgets/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberEditScreen extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthAppBar(isFirstPage: false),
              SizedBox(height: getVerticalSize(50)),
              LargeText(
                text: "Edit phone number",
                size: getFontSize(28),
                margin: getMargin(top: 30, bottom: 20, left: 20),
              ),
              SmallText(
                text: "Enter phone starting with '+'",
                margin: getMargin(left: 20),
              ),
              CustomTextField(
                margin: getMargin(top: 20, left: 20, right: 20),
                hint: "New phone number",
                maxCharacters: 20,
                controller: _authController.editPhoneNumberControler,
                validator: (v) => _authController.validatePhone(v!),
                inputType: TextInputType.phone,
              ),
              CustomButton(
                title: "Update",
                width: Get.width,
                margin: getMargin(top: 20, left: 20, right: 20, bottom: 20),
                onTap: () async {
                  if (_formKey.currentState!.validate())
                    _authController.updatePhoneNumber();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
