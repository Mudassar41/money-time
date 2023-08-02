import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/utils/widgets/custom_text_field.dart';
import 'package:atm_tracker/views/authentication/custom_widgets/auth_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme/colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final _emailTextEditingController = TextEditingController();

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
                CustomTextField(
                  margin: getMargin(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  hint: "Email",
                  maxCharacters: 50,
                  controller: _emailTextEditingController,
                  inputType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Field is required';
                    }
                  },
                ),



                if(isLoading)
                  Center(child: CircularProgressIndicator(
                    color: kPrimary,
                  ))
                  else
                CustomButton(
                  title: "Reset Password",
                  width: Get.width,
                  margin: getMargin(top: 20, left: 20, right: 20),
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    } else {
                      _formKey.currentState!.save();
                      isLoading = true;
                      setState(() {});

                      FirebaseAuth.instance
                          .sendPasswordResetEmail(
                              email: _emailTextEditingController.text)
                          .then((value) {
                        Services.successMessage(
                          'Please check your email.Password reset link has been sent',
                        );
                        _emailTextEditingController.clear();
                        isLoading = false;
                        setState(() {});
                      }).catchError((onError) {
                        Services.errorMessage(onError);
                        isLoading = false;
                        setState(() {});
                      });
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
