import 'package:atm_tracker/models/employee_model.dart';
import 'package:atm_tracker/models/location_model.dart';
import 'package:atm_tracker/services/firebase_services.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  static EmployeeController get instance => Get.find();
  final RxList<LocationModel> locationsList = RxList();
  final Rxn<EmployeeModel> employeeModel = Rxn();
  final RxBool isLoading = RxBool(false);
  final Rxn<LocationModel> locationModel = Rxn();
  var isHours = false.obs;

  @override
  void onInit() async {
    isLoading(true);
    employeeModel.value = await FirebaseServices().getEmployeeData();
    locationsList.bindStream(FirebaseServices()
        .streamLocationsForEmployees(employeeModel.value!.employeeId));
    await Future.delayed(Duration(seconds: 1));
    isLoading(false);
    print("Is Loading: ${isLoading.value}");
    super.onInit();
  }

  @override
  void onClose() {
    locationsList.close();
  }

  setHour(bool val) {
    isHours(val);
  }

  updateAtmDetails() async {
    try {
      Services.showLoading();
      await FirebaseServices().updateExistingLocation(locationModel.value!);
      Get.back();

      Services.hideLoading();
      Services.successMessage('Data Updated');
    } catch (e) {}
  }
}
