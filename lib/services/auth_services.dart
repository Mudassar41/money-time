import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/services/firebase_services.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/views/employee_side/employee_dashboard.dart';
import 'package:atm_tracker/views/user_side/user_landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthServices {
  var _authController = Get.find<AuthController>();
  var auth = FirebaseAuth.instance;

  Future<User?> createAccount(String email, String password) async {
    try {
      return await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user);
    } on FirebaseAuthException catch (e) {
      Services.hideLoading();
      Get.snackbar("Failed", e.message!,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
      return null;
    } catch (e) {
      Services.hideLoading();
      Get.snackbar("Error", e.toString(),
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      return await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user);
    } on FirebaseAuthException catch (e) {
      Services.hideLoading();
      Get.snackbar("Error", e.message!,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
      return null;
    } catch (e) {
      Services.hideLoading();
      Get.snackbar("Error", e.toString(),
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
      return null;
    }
  }

  Future signOut() async {
    await auth.signOut();
  }

  Future sendVerificationCode(String phoneNumber) async {
    Services.showLoading();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 120),
        verificationCompleted: (phoneAuthCredentials) {
          Services.hideLoading();
          // _authController.verificationId.value =
          //     phoneAuthCredentials.verificationId!;
         // verifySmsCode();
        },
        verificationFailed: (e) {
          Services.hideLoading();
          Get.snackbar("Failed", e.message!,
              backgroundColor: kRed,
              colorText: Colors.white,
              margin: getMargin(all: 8));
        },
        codeSent: (String v, int? i) {
          Services.hideLoading();
          _authController.verificationId.value = v;
          Get.snackbar("Success", "Verification Code sent");
        },
        codeAutoRetrievalTimeout: (v) {});
  }

  verifySmsCode() async {
    Services.showLoading();
    final credentials = PhoneAuthProvider.credential(
      verificationId: _authController.verificationId.value,
      smsCode: _authController.phoneVerficiationController.text.trim(),
    );
    try {
      await FirebaseAuth.instance.currentUser!
          .linkWithCredential(credentials)
          .then((value) {
        FirebaseServices().updateUserVerified();
        if (_authController.firebaseUser.value!.displayName == "User") {
          Get.offAll(() => UserLandingPage())!.then((value) {
            Services.hideLoading();
          });
        } else
          Get.offAll(() => EmployeeDashboard())!
              .then((value) => Services.hideLoading());
        _authController.clearEmployeeControllers();
        _authController.clearUserControllers();
      });
    } on FirebaseAuthException catch (e) {
      Services.hideLoading();
      Get.snackbar("Failed", e.message!,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
    } catch (e) {
      Services.hideLoading();
      Get.snackbar("Error", e.toString(),
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
    }
  }
}
