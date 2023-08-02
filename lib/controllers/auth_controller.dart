import 'package:atm_tracker/models/employee_model.dart';
import 'package:atm_tracker/models/user_model.dart';
import 'package:atm_tracker/services/auth_services.dart';
import 'package:atm_tracker/services/firebase_services.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/utils/log/custom_loger.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/views/admin_side/admin_dashboard.dart';
import 'package:atm_tracker/views/authentication/create_password_screen.dart';
import 'package:atm_tracker/views/authentication/employee_login_screen.dart';
import 'package:atm_tracker/views/authentication/phone_verification_screen.dart';
import 'package:atm_tracker/views/authentication/user_login_screen.dart';
import 'package:atm_tracker/views/employee_side/employee_dashboard.dart';
import 'package:atm_tracker/views/user_side/user_landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _log = CustomLogger(className: "AuthController");

  static AuthController get instance => Get.find();
  final Rx<User?> firebaseUser = FirebaseAuth.instance.currentUser.obs;

  String get currentUserId =>
      firebaseUser.value != null ? firebaseUser.value!.uid : '';
  RxString verificationId = ''.obs;
  RxBool isSigningUp = false.obs;
  RxString userSexValue = "Male".obs;
  TextEditingController userLoginEmailController = TextEditingController();
  TextEditingController userLoginPasswordController = TextEditingController();
  TextEditingController signUpEmailOrIdController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  TextEditingController userBankNameController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController userAgeController = TextEditingController();
  TextEditingController phoneVerficiationController = TextEditingController();
  TextEditingController employeeFirstNameController = TextEditingController();
  TextEditingController employeeLastNameController = TextEditingController();
  TextEditingController employeePhoneNumberController = TextEditingController();
  TextEditingController employeeSignUpEmailController = TextEditingController();
  TextEditingController employeeLoginEmailController = TextEditingController();
  TextEditingController employeeLoginPasswordController =
      TextEditingController();
  TextEditingController editPhoneNumberControler = TextEditingController();

  @override
  void onReady() {
    navigateToDestinationAccordingly(firebaseUser.value);
    ever(firebaseUser, navigateToDestinationAccordingly);

    super.onReady();
  }

  @override
  void onInit() {
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
    super.onInit();
  }

  @override
  void onClose() {
    disposeControllers();
    firebaseUser.close();
    super.onClose();
  }

  disposeControllers() {
    userLoginEmailController.dispose();
    userLoginPasswordController.dispose();
    signUpEmailOrIdController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    userBankNameController.dispose();
    userPhoneNumberController.dispose();
    userAgeController.dispose();
    employeeFirstNameController.dispose();
    employeeLastNameController.dispose();
    employeePhoneNumberController.dispose();
    employeeSignUpEmailController.dispose();
    employeeLoginEmailController.dispose();
    employeeLoginPasswordController.dispose();
  }

  clearUserControllers() {
    _log.i('clear fields');
    userLoginEmailController.clear();
    userLoginPasswordController.clear();
    signUpEmailOrIdController.clear();
    userBankNameController.clear();
    userAgeController.clear();
    userPhoneNumberController.clear();
    signUpPasswordController.clear();
    signUpConfirmPasswordController.clear();
  }

  clearEmployeeControllers() {
    employeeLoginEmailController.clear();
    employeeLoginPasswordController.clear();
    signUpEmailOrIdController.clear();
    signUpPasswordController.clear();
    signUpConfirmPasswordController.clear();
    employeeFirstNameController.clear();
    employeeLastNameController.clear();
    employeePhoneNumberController.clear();
    employeeSignUpEmailController.clear();
  }

  navigateToDestinationAccordingly(User? user) async {
    if (!isSigningUp.value) {
      if (user != null) {
        bool checkPhoneVerification =
            await FirebaseServices().checkPhoneVerification();
        if (checkPhoneVerification) {
          if (user.displayName == 'User') {
            await Get.offAll(() => UserLandingPage());
          } else if (user.displayName == 'Employee') {
            await Get.offAll(() => EmployeeDashboard());
          } else if (user.displayName == 'Admin') {
            await Get.offAll(() => AdminDashboard());
          }
        } else
          Get.offAll(() => PhoneVerificationScreen());
      } else {
        await Get.offAll(() => UserLoginScreen());
      }
    }
  }

  userSignUp() async {
    Services.showLoading();
    isSigningUp.value = true;
    User? user = await AuthServices().createAccount(
      signUpEmailOrIdController.text.trim(),
      signUpConfirmPasswordController.text.trim(),
    );
    if (user != null) {
      await user.updateDisplayName("User");
      await user.reload();
      UserModel userModel = UserModel(
        userEmail: signUpEmailOrIdController.text.trim(),
        bankName: userBankNameController.text.trim(),
        age: userAgeController.text.trim(),
        sex: userSexValue.value,
        uid: user.uid,
        phoneNumber: userPhoneNumberController.text.trim(),
      );
      var uploadUserDataValue =
          await FirebaseServices().uploadUserData(userModel);
      await user.reload();
      final currentUser = FirebaseAuth.instance.currentUser;
      firebaseUser(currentUser);
      if (uploadUserDataValue == null) {
        Get.offAll(() => PhoneVerificationScreen());
      }
      Services.hideLoading();
      isSigningUp.value = false;
    }
  }

  // adminSignUp() async {
  //   User? user = await AuthServices().createAccount(
  //       signUpEmailOrIdController.text.trim(),
  //       signUpConfirmPasswordController.text.trim());
  //   if (user != null) {
  //     await user.updateDisplayName("Admin");
  //     await user.reload();
  //     firebaseUser(user);
  //     navigateToDestinationAccordingly(user);
  //   }
  // }

  employeeSignUp() async {
    Services.showLoading();
    isSigningUp.value = true;
    // creating account for user in FirebaseAuth
    User? user = await AuthServices().createAccount(
      employeeSignUpEmailController.text,
      signUpConfirmPasswordController.text,
    );
    if (user != null) {
      user.updateDisplayName("Employee");
      user.reload();
      EmployeeModel employeeModel = EmployeeModel(
        email: employeeSignUpEmailController.text.trim(),
        firstName: employeeFirstNameController.text.trim(),
        lastName: employeeLastNameController.text.trim(),
        phoneNumber: employeePhoneNumberController.text.trim(),
        uid: user.uid,
        employeeId: signUpEmailOrIdController.text.trim(),
      );

      //add employee to firestore
      var uploadEmployeeDataValue =
          await FirebaseServices().uploadEmployeeData(employeeModel);
      //updating emplyeeID
      await FirebaseServices().updateEmployeeId();
      await user.reload();
      final x = FirebaseAuth.instance.currentUser;
      firebaseUser(x);
      if (uploadEmployeeDataValue == null) {
        Get.offAll(() => PhoneVerificationScreen());
      }
      Services.hideLoading();
      isSigningUp.value = false;
    }
  }

  userSignIn() async {
    Services.showLoading();
    isSigningUp.value = true;
    User? user = await AuthServices().signIn(
        userLoginEmailController.text.trim(),
        userLoginPasswordController.text.trim());
    if (user != null) {
      if (user.displayName == "User" || user.displayName == "Admin") {
        firebaseUser(user);
        isSigningUp.value = false;
        clearUserControllers();
        navigateToDestinationAccordingly(user);
        Services.hideLoading();
      } else {
        AuthServices().signOut();
        Services.hideLoading();
        Get.snackbar("Failed", "Account not registered",
            backgroundColor: kRed,
            colorText: Colors.white,
            margin: getMargin(all: 8));
      }
    }
    isSigningUp.value = false;
  }

  employeeSignIn() async {
    Services.showLoading();
    isSigningUp.value = true;
    FirebaseAuth.instance.signInAnonymously();
    String? email = await FirebaseServices()
        .getEmployeeEmail()
        .whenComplete(() => AuthServices().signOut());
    if (email == null || email.isEmpty) {
      Services.hideLoading();
      Get.snackbar("Failed", "Please provide a valid employee ID",
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
    } else {
      User? user = await AuthServices()
          .signIn(email, employeeLoginPasswordController.text.trim());
      if (user != null) {
        firebaseUser(user);
        clearEmployeeControllers();
        isSigningUp.value = false;
        navigateToDestinationAccordingly(user);
        Services.hideLoading();
      }
    }
  }

  userOrAdminLogOut() {
    Services.showLoading();
    AuthServices().signOut();
    Get.offAll(() => UserLoginScreen());
    Services.hideLoading();
  }

  employeeLogOut() {
    Services.showLoading();
    AuthServices().signOut();
    Get.offAll(() => EmployeeLoginScreen());
    Services.hideLoading();
  }

  Future<void> assignEmployeeId() async {
    Services.showLoading();
    bool isAvailable = await FirebaseServices().checkEmployeeIdAvailability();

    if (isAvailable) {
      Services.hideLoading();
      Get.to(() => CreatePasswordScreen(creator: "Employee"));
    } else {
      Services.errorMessage("Please enter a valid Employee ID");
    }
  }

  updatePhoneNumber() async {
    Services.showLoading();
    bool isUpdated = await FirebaseServices().updatePhoneNumber();
    if (isUpdated) {
      await Get.offAll(() => PhoneVerificationScreen());
      editPhoneNumberControler.clear();
    } else {
      Services.errorMessage("Failed to update phone number");
    }
  }

  String? validateEmail(String em, String creator) {
    RegExp regExp = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (creator == "Employee") {
      if (em.isEmpty)
        return "This is required field";
      else
        return null;
    } else {
      if (regExp.hasMatch(em))
        return null;
      else
        return 'Please enter a valid email address';
    }
  }

  String? validateFullName(String fullName) {
    String pattern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = new RegExp(pattern);
    if (fullName.isEmpty)
      return 'Please enter your name';
    else if (fullName.trim().isEmpty)
      return 'Please do not use whitespaces';
    else if (!regExp.hasMatch(fullName))
      return 'Please enter valid name';
    else
      return null;
  }

  String? validatePassword(String pass) {
    if (pass.length < 6)
      return 'Password Must be at least 6 characters';
    else if (pass.isEmpty)
      return 'This is required field';
    else if (pass.trim().isEmpty)
      return 'Please do not use whitespaces';
    else
      return null;
  }

  String? validateConfirmPassword(String pass) {
    if (pass.isEmpty)
      return 'This is required field';
    else if (pass != signUpPasswordController.text)
      return 'Passwords do not match';
    else
      return null;
  }

  String? validateBankName(String bankName) {
    if (bankName.isEmpty)
      return 'This is required field';
    else
      return null;
  }

  String? validateAge(String age) {
    if (age.isEmpty)
      return 'This is required field';
    else if (age.trim().isEmpty)
      return 'Please do not use whitespaces';
    else if (int.parse(age) < 6 || int.parse(age) > 120)
      return 'Please enter a valid age';
    else
      return null;
  }

  String? validateSex(String sex) {
    if (sex.toLowerCase() != 'male' && sex.toLowerCase() != 'female')
      return 'Please enter a valid sex';
    else if (sex.isEmpty)
      return 'This is required field';
    else
      return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty)
      return 'This is required field';
    else if (value.trim().isEmpty)
      return 'Please do not use whitespaces';
    else if (!value.startsWith("+"))
      return 'Please enter phone number with country code';
    return null;
  }

  String? validateVerificationPin(String pin) {
    if (pin.isEmpty)
      return "This is required field";
    else if (pin.trim().isEmpty)
      return 'Please do not use whitespaces';
    else
      return null;
  }
}
