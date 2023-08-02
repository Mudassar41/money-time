import 'package:atm_tracker/models/employee_id_model.dart';
import 'package:atm_tracker/services/firebase_services.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeIdController extends GetxController {
  TextEditingController employeeIdController = TextEditingController();
  final RxList<EmployeeIdModel> employeeIdList = RxList();
  final RxBool isLoading = RxBool(false);

  @override
  void onInit() async {
    isLoading(true);
    employeeIdList.bindStream(FirebaseServices().streamEmployeeIds());
    await Future.delayed(Duration(seconds: 1));
    isLoading(false);
    super.onInit();
  }

  @override
  void onClose() {
    employeeIdController.dispose();
    employeeIdList.close();
  }

  addEmployeeId() {
    if (employeeIdController.text.trim().isNotEmpty) {
      Services.showLoading();
      var employeeIdModel = EmployeeIdModel(
        id: employeeIdController.text.trim(),
        isOccupied: false,
      );
      FirebaseServices().uploadEmployeeId(employeeIdModel);
      employeeIdController.clear();
      Services.hideLoading();
    }
  }
}
