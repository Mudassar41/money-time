import 'dart:io';
import 'package:atm_tracker/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import '../utils/theme/colors.dart';
import '../utils/utils.dart';

class Services {
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseStorage get storage => FirebaseStorage.instance;
  static FirebaseAuth get auth => FirebaseAuth.instance;

  static initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        name: "money-time", options: DefaultFirebaseOptions.currentPlatform);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: 512000000,
      sslEnabled: true,
    );
  }

  static Future<String> uploadFile(File file, String serverPath) async {
    Reference reference = storage.ref().child(serverPath);
    UploadTask uploadTask = reference.putFile(file);
    try {
      TaskSnapshot snapshot = await uploadTask;
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return "";
    }
  }

  static Future<String?> updateUploadedFile(
    File? file,
    String path,
    String? xUrl,
  ) async {
    if (file != null && file.path.isNotEmpty) {
      final url = await uploadFile(file, path);
      if (xUrl != null && xUrl.isNotEmpty) {
        Reference reference = storage.refFromURL(xUrl);
        await reference.delete();
      }
      return url;
    }
    return null;
  }

  static Future<void> pickDate(
      {CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
      DateTime? maxDate,
      DateTime? minDate,
      DateTime? initialDate,
      required void Function(DateTime v) onChanged}) async {
    return await showCupertinoModalPopup<void>(
        context: Get.context!,
        builder: (BuildContext context) => Container(
              height: 300,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: kWhite,
              child: SafeArea(
                top: false,
                child: CupertinoDatePicker(
                    initialDateTime: initialDate ?? DateTime.now(),
                    maximumDate: maxDate,
                    minimumDate: minDate,
                    mode: mode,
                    onDateTimeChanged: onChanged),
              ),
            ));
  }

  static Future<void> errorMessage(String message) async {
    Get.closeAllSnackbars();
    Get.snackbar('Alert', message,
        backgroundColor: kRed,
        colorText: Colors.white,
        margin: getMargin(all: 8));
    await Future.delayed(500.milliseconds);
    Services.hideLoading();
  }

  static Future<void> successMessage(String message) async {
    Get.closeAllSnackbars();
    Get.snackbar('Success', message,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: getMargin(all: 8));
    await Future.delayed(500.milliseconds);
    Services.hideLoading();
  }

  static bool _isLoading = false;
  static void showLoading({bool isBackEnabled = true}) {
    if (!_isLoading) {
      Get.dialog(
        WillPopScope(
          onWillPop: () async {
            return isBackEnabled;
          },
          child: const Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 4,
              backgroundColor: kWhite,
              valueColor: AlwaysStoppedAnimation<Color>(
                kPrimary,
              ),
            ),
          ),
        ),
        barrierDismissible: kDebugMode,
      );
      _isLoading = true;
    }
  }

  static void hideLoading() {
    if (_isLoading) Get.back();
    _isLoading = false;
  }
}
