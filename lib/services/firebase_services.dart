import 'dart:developer';
import 'dart:io';

import 'package:atm_tracker/controllers/auth_controller.dart';
import 'package:atm_tracker/models/ad_model.dart';
import 'package:atm_tracker/models/atm_model.dart';
import 'package:atm_tracker/models/banks_model.dart';
import 'package:atm_tracker/models/employee_id_model.dart';
import 'package:atm_tracker/models/employee_model.dart';
import 'package:atm_tracker/models/location_model.dart';
import 'package:atm_tracker/models/regions_model.dart';
import 'package:atm_tracker/models/user_model.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/utils/constant/firestore_strings.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseServices {
  var _authController = Get.find<AuthController>();
  CollectionReference regionCollectionRef =
      FirebaseFirestore.instance.collection('Regions');

  Future uploadUserData(UserModel userModel) async {
    return await FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userModel.uid)
        .set(userModel.toMap())
        .then((value) {
      return value;
    }).catchError((onError) {
      Services.hideLoading();
      Get.snackbar("Error", onError.message,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
      return onError.message;
    });
  }

  Future uploadEmployeeData(EmployeeModel employeeModel) async {
    return await FirebaseFirestore.instance
        .collection(employeesCollection)
        .doc(employeeModel.uid)
        .set(employeeModel.toMap())
        .then((value) {
      return value;
    }).catchError((onError) {
      Get.snackbar("Error", onError.message,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
      return onError.message;
    });
  }

  Future<String?> getEmployeeEmail() async {
    var snapshot = await FirebaseFirestore.instance
        .collection(employeeIdCollection)
        .doc(_authController.employeeLoginEmailController.text.trim())
        .get();
    if (snapshot.exists) {
      EmployeeIdModel employeeIdModel =
          EmployeeIdModel.fromMap(snapshot.data()!);
      return employeeIdModel.employeeEmail;
    } else
      return null;
  }

  Future<String> getPhoneNumber() async {
    if (_authController.firebaseUser.value!.displayName == "User") {
      var data = await FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(_authController.firebaseUser.value!.uid)
          .get();
      UserModel userModel = UserModel.fromMap(data.data()!);
      return userModel.phoneNumber;
    } else {
      var data = await FirebaseFirestore.instance
          .collection(employeesCollection)
          .doc(_authController.firebaseUser.value!.uid)
          .get();
      EmployeeModel employeeModel = EmployeeModel.fromMap(data.data()!);

      print('Employee phone number is=> ${employeeModel.phoneNumber}');
      return employeeModel.phoneNumber;
    }
  }

  Future<bool> updatePhoneNumber() async {
    if (_authController.firebaseUser.value!.displayName == "User") {
      try {
        await FirebaseFirestore.instance
            .collection(usersCollection)
            .doc(_authController.firebaseUser.value!.uid)
            .update({
          'phoneNumber': _authController.editPhoneNumberControler.text.trim()
        });
        return true;
      } on FirebaseException catch (_) {
        return false;
      }
    } else {
      try {
        await FirebaseFirestore.instance
            .collection(employeesCollection)
            .doc(_authController.firebaseUser.value!.uid)
            .update({
          'phoneNumber': _authController.editPhoneNumberControler.text.trim()
        });
        return true;
      } on FirebaseException catch (_) {
        return false;
      }
    }
  }

  Future<bool> checkPhoneVerification() async {
    if (_authController.firebaseUser.value!.displayName == "User") {
      var data = await FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(_authController.firebaseUser.value!.uid)
          .get();
      UserModel userModel = UserModel.fromMap(data.data()!);
      return userModel.isPhoneVerified;
    } else if (_authController.firebaseUser.value!.displayName == "Employee") {
      var data = await FirebaseFirestore.instance
          .collection(employeesCollection)
          .doc(_authController.firebaseUser.value!.uid)
          .get();
      EmployeeModel employeeModel = EmployeeModel.fromMap(data.data()!);
      return employeeModel.isPhoneVerified;
    } else if (_authController.firebaseUser.value!.displayName == "Admin")
      return true;
    else
      return false;
  }

  Future updateUserVerified() async {
    if (_authController.firebaseUser.value!.displayName == "User") {
      await FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(_authController.firebaseUser.value!.uid)
          .update({"isPhoneVerified": true});
    } else if (_authController.firebaseUser.value!.displayName == "Employee") {
      await FirebaseFirestore.instance
          .collection(employeesCollection)
          .doc(_authController.firebaseUser.value!.uid)
          .update({"isPhoneVerified": true});
    }
  }

  Future<void> uploadEmployeeId(EmployeeIdModel employeeIdModel) async {
    try {
      var collectionRef =
          FirebaseFirestore.instance.collection(employeeIdCollection);
      var doc = await collectionRef.doc(employeeIdModel.id).get();
      if (!doc.exists) {
        await collectionRef
            .doc(employeeIdModel.id)
            .set(employeeIdModel.toMap(), SetOptions(merge: true));
      } else
        Get.snackbar("Failed", "ID already exists",
            backgroundColor: kRed,
            colorText: Colors.white,
            margin: getMargin(all: 8));
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message!,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
    }
  }

  Future<bool> checkEmployeeIdAvailability() async {
    try {
      var collectionRef =
          FirebaseFirestore.instance.collection(employeeIdCollection);
      var doc = await collectionRef
          .doc(_authController.signUpEmailOrIdController.text.trim())
          .get();
      if (doc.exists) {
        EmployeeIdModel employeeIdModel = EmployeeIdModel.fromMap(doc.data()!);
        if (employeeIdModel.isOccupied) {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message!,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
      return false;
    }
  }

  Future updateEmployeeId() async {
    try {
      var collectionRef =
          FirebaseFirestore.instance.collection(employeeIdCollection);
      await collectionRef
          .doc(_authController.signUpEmailOrIdController.text.trim())
          .update({
        "isOccupied": true,
        "employeeEmail":
            _authController.employeeSignUpEmailController.text.trim(),
        "employeeName":
            _authController.employeeFirstNameController.text.trim() +
                " " +
                _authController.employeeLastNameController.text.trim()
      });
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message!,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
    }
  }

  Stream<List<EmployeeIdModel>> streamEmployeeIds() {
    return FirebaseFirestore.instance
        .collection(employeeIdCollection)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => EmployeeIdModel.fromMap(e.data())).toList());
  }

  Stream<List<LocationModel>> streamLocations() {
    return FirebaseFirestore.instance
        .collection(atmsCollection)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => LocationModel.fromMap(e.data())).toList());
  }

  Stream<List<LocationModel>> streamLocationsForEmployees(String employeeId) {
    return FirebaseFirestore.instance
        .collection(atmsCollection)
        .where("employeeId", isEqualTo: employeeId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => LocationModel.fromMap(e.data())).toList());
  }

  Future<List<EmployeeModel>> getEmployeesList() async {
    return await FirebaseFirestore.instance
        .collection(employeesCollection)
        .where('isPhoneVerified', isEqualTo: true)
        .get()
        .then((event) =>
            event.docs.map((e) => EmployeeModel.fromMap(e.data())).toList());
  }

  Future<String?> uploadNewLocation(LocationModel locationModel) async {
    try {
      var ref = FirebaseFirestore.instance.collection(atmsCollection).doc();
      locationModel = locationModel.copyWith(locationId: ref.id);
      await ref.set(locationModel.toMap());
      return ref.id;
    } on FirebaseException catch (e) {
      Get.snackbar("Failed", e.message!,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
      return null;
    }
  }

  Future<void> updateExistingLocation(LocationModel locationModel) async {
    try {
      log('${locationModel.toMap()}');
      await FirebaseFirestore.instance
          .collection(atmsCollection)
          .doc(locationModel.locationId)
          .update(locationModel.toMap());
    } on FirebaseException catch (e) {
      Get.snackbar("Failed", e.message!,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
      rethrow;
    }
  }

  Future<List<LocationModel>> getLocationsList() async {
    return await FirebaseFirestore.instance
        .collection(atmsCollection)
        .get()
        .then((event) =>
            event.docs.map((e) => LocationModel.fromMap(e.data())).toList());
  }

  Future<List<LocationModel>> getSortedLocations(
      String bankName, String region) async {
    List<LocationModel> sortedLocations = [];
    if (bankName.isNotEmpty && region.isNotEmpty) {
      QuerySnapshot data =
          await FirebaseFirestore.instance.collection(atmsCollection).get();

      for (var element in data.docs) {
        Map<String, dynamic> map = element.data() as Map<String, dynamic>;
        LocationModel location = LocationModel.fromMap(map);
        if (location.parish.toLowerCase() == region.toLowerCase()) {
          List<AtmModel> matchedAtms =
              location.atms.where((atm) => atm.bankName == bankName).toList();
          if (matchedAtms.isNotEmpty) {
            sortedLocations.add(location.copyWith(atms: matchedAtms));
          }
        }
      }
    } else if (bankName.isEmpty && region.isNotEmpty) {
      QuerySnapshot data =
          await FirebaseFirestore.instance.collection(atmsCollection).get();

      for (var element in data.docs) {
        Map<String, dynamic> map = element.data() as Map<String, dynamic>;
        LocationModel location = LocationModel.fromMap(map);
        if (location.parish.toLowerCase() == region.toLowerCase()) {
          sortedLocations.add(location);
        }
      }
    } else if (bankName.isEmpty && region.isNotEmpty) {
      QuerySnapshot data =
          await FirebaseFirestore.instance.collection(atmsCollection).get();

      for (var element in data.docs) {
        Map<String, dynamic> map = element.data() as Map<String, dynamic>;
        LocationModel location = LocationModel.fromMap(map);
        if (location.parish.toLowerCase() == region.toLowerCase()) {
          List<AtmModel> matchedAtms =
              location.atms.where((atm) => atm.bankName == bankName).toList();
          if (matchedAtms.isNotEmpty) {
            sortedLocations.add(location.copyWith(atms: matchedAtms));
          }
        }
      }
    }

    return sortedLocations;
  }

  Future<EmployeeModel> getEmployeeData() async {
    var doc = await FirebaseFirestore.instance
        .collection(employeesCollection)
        .doc(_authController.currentUserId)
        .get();
    return EmployeeModel.fromMap(doc.data()!);
  }

  Stream<List> favouritesList() {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(_authController.currentUserId)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!).favouriteAtms);
  }

  Future<void> addOrRemoveFavouriteAtm(List newList) async {
    try {
      await FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(_authController.currentUserId)
          .update({"favouriteAtms": newList});
    } on FirebaseException catch (e) {
      Get.snackbar("Failed", e.message!,
          backgroundColor: kRed,
          colorText: Colors.white,
          margin: getMargin(all: 8));
    }
  }

  uploadAdVideo(String path, bankId) async {
    var task;
    try {
      task = await FirebaseStorage.instance.ref('adVideos').putFile(
            File(path),
          );
    } on FirebaseException catch (e) {
      Services.errorMessage(e.message!);
    }
    var adUrl = await task.ref.getDownloadURL();
    AdModel adModel = AdModel(
      adUrl: adUrl,
      views: 0,
      bankId: bankId,
    );
    try {
      await FirebaseFirestore.instance
          .collection(adsCollection)
          .add(adModel.toMap());
    } on FirebaseException catch (e) {
      Services.errorMessage(e.message!);
    }
  }

  Future<AdModel?> getAd(int bankId) async {
    try {
      print("BankID=>>>>${bankId}");
      var snapshot = await FirebaseFirestore.instance
          .collection(adsCollection)
          .where('bankId', isEqualTo: bankId)
          .get();
      print('size is => ${snapshot.size}');

      print('data => $snapshot');
      if (snapshot.docs.isEmpty) {
        return AdModel(adUrl: '', views: 0, bankId: 401);
      } else {
        var adData = snapshot.docs.first.data();
        return AdModel.fromMap(adData);
      }
    } on FirebaseException catch (e) {
      Services.errorMessage(e.message!);
      return null;
    }
  }

  Future incrementAdCount(int bankId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(adsCollection)
        .where('bankId', isEqualTo: bankId)
        .get();

    DocumentSnapshot adDoc = querySnapshot.docs.first;
    adDoc.reference.update({"views": FieldValue.increment(1)});
  }

  Future<List<Region>> getRegions() async {
    List<Region> regions = [];

    QuerySnapshot data = await regionCollectionRef.get();

    for (var element in data.docs) {
      Map<String, dynamic> map = element.data() as Map<String, dynamic>;

      Region region = Region(
        name: map['name'],
        id: element.id,
      );
      regions.add(region);
    }

    return regions;
  }

  Future<List<Bank>> getRegionBanks(String regionId) async {
    List<Bank> banks = [];

    QuerySnapshot data =
        await regionCollectionRef.doc(regionId).collection('banks').get();

    for (var element in data.docs) {
      Map<String, dynamic> map = element.data() as Map<String, dynamic>;

      Bank bank = Bank(
        name: map['name'],
        id: element.id,
      );
      banks.add(bank);
    }

    return banks;
  }

  Future<Region> getRegion(String regionId) async {
    print('id=>>> $regionId');
    DocumentSnapshot data = await regionCollectionRef.doc(regionId).get();
    print('data =>> ${data.data()}');
    if (data.exists) {
      return Region.fromMap(data.data() as Map<String, dynamic>);
    } else {
      return Region(name: '');
    }
  }
}
