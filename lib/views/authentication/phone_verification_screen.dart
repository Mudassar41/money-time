import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/services/auth_services.dart';
import 'package:atm_tracker/services/firebase_services.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/views/authentication/custom_widgets/auth_app_bar.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/authentication/phone_number_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneVerificationScreen extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final RxBool codeSent = false.obs;

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
                AuthAppBar(isFirstPage: true),
                SizedBox(height: getVerticalSize(50)),
                LargeText(
                  text: "Verify phone number",
                  size: getFontSize(28),
                  margin: getMargin(top: 30, bottom: 20, left: 20),
                ),
                Obx(
                  () => FutureBuilder(
                      future: verificationInstructions(),
                      builder: (context, snap) {
                        return SmallText(
                          text: snap.data?.value ?? "",
                          maxLines: 4,
                          margin: getMargin(left: 20, right: 20),
                          align: TextAlign.justify,
                        );
                      }),
                ),
                Obx(
                  () => Visibility(
                    visible: codeSent.value,
                    child: CustomTextField(
                      margin: getMargin(top: 20, left: 20, right: 20),
                      hint: "Pin",
                      maxCharacters: 6,
                      controller: _authController.phoneVerficiationController,
                      validator: (v) =>
                          _authController.validateVerificationPin(v!),
                      inputType: TextInputType.phone,
                    ),
                  ),
                ),
                Obx(
                  () => CustomButton(
                    title: codeSent.value ? "Continue" : 'Send Code',
                    width: Get.width,
                    margin: getMargin(top: 20, left: 20, right: 20, bottom: 20),
                    onTap: () async {
                      if (codeSent.value) {
                        if (_formKey.currentState!.validate()) {
                          AuthServices().verifySmsCode();
                        }
                      } else {
                        codeSent(true);
                        String phoneNumber =
                            await FirebaseServices().getPhoneNumber();
                        await AuthServices().sendVerificationCode(phoneNumber);
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeText(
                      text: "Code not received? ",
                      size: getFontSize(18),
                      color: kBlack,
                    ),
                    TextButton(
                      onPressed: () async {
                        String phoneNumber =
                            await FirebaseServices().getPhoneNumber();
                        await AuthServices().sendVerificationCode(phoneNumber);
                      },
                      child: LargeText(
                          text: "Resend",
                          size: getFontSize(18),
                          color: kTextButtonColor),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: kTextButtonColor,
                      size: getFontSize(18),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeText(
                        text: "Want to change phone number? ",
                        size: getFontSize(18),
                        color: kBlack),
                    GestureDetector(
                        onTap: () {
                          _authController.phoneVerficiationController.clear();
                          Get.to(() => PhoneNumberEditScreen());
                        },
                        child: LargeText(
                            text: "Edit here",
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

  Future<RxString> verificationInstructions() async {
    String phoneNumber = await FirebaseServices().getPhoneNumber();
    if (_authController.firebaseUser.value?.displayName == "User") {
      String lastTwoChars = phoneNumber.substring(phoneNumber.length - 2);
      return "We have sent a verification pin to ***$lastTwoChars to confirm your phone number. Please enter the pin in the app to complete the verification process"
          .obs;
    } else {
      String lastTwoChars = phoneNumber.substring(phoneNumber.length - 2);
      return "We have sent a verification pin to ***$lastTwoChars to confirm your phone number. Please enter the pin in the app to complete the verification process"
          .obs;
    }
  }
}
