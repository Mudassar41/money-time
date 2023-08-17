import 'dart:io';
import 'package:atm_tracker/models/ad_model.dart';
import 'package:atm_tracker/models/atm_model.dart';
import 'package:atm_tracker/models/banks_model.dart';
import 'package:atm_tracker/models/employee_model.dart';
import 'package:atm_tracker/models/location_model.dart';
import 'package:atm_tracker/models/regions_model.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/utils/log/custom_loger.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/views/admin_side/ad_uploading_screen.dart';
import 'package:atm_tracker/views/admin_side/add_or_edit_location_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:atm_tracker/services/firebase_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  final log = CustomLogger(className: 'Admin Controller');
  RxList<EmployeeModel> employeesList = RxList();
  RxList<LocationModel> locationsList = RxList();
  RxBool isEmployeeListLoading = RxBool(false);
  RxBool isLocationListLoading = RxBool(false);
  Rxn<File> atmImage = Rxn();
  RxString atmImageUrl = ''.obs;
  VideoPlayerController? videoPlayerController;
  VideoPlayerController? remoteVideoController;
  RxBool videoReady = false.obs;
  XFile? video;
  RxString fetchedAdVideo = ''.obs;
  RxNum views = RxNum(0);
  final ImagePicker imagePicker = ImagePicker();
  final GlobalKey<FormState> locationFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> atmFormKey = GlobalKey<FormState>();

  final TextEditingController locationNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController parishController = TextEditingController();
  final TextEditingController atmNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();

  final TextEditingController bankNameController1 = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final RxString employeeId = ''.obs;
  final RxBool offSite = true.obs;
  final RxBool branch = true.obs;
  final RxBool isBranch = true.obs;
  final RxBool isWorking = false.obs;
  final RxBool isSmart = false.obs;
  final RxBool driveThrough = false.obs;
  final RxBool isDualCurrency = false.obs;
  final RxBool isFiltered = false.obs;
  final RxList<AtmModel> atmsList = RxList();
  final RxList<Region> regions = RxList();

  //<------------------------>
  RxBool isLoading = false.obs;
  RxBool isLoadingRegionBanks = false.obs;

  final RxMap<String, List<LocationModel>> parishMap = RxMap();
  RxList<Bank> regionBanks = RxList();

  @override
  void onInit() {
    super.onInit();
    getLocationsList();

    getRegions();
  }

  @override
  dispose() {
    print('disposed called');
    videoPlayerController?.dispose();
    remoteVideoController?.dispose();
    super.dispose();
  }

  clearValues() {
    atmImage.value = null;
    locationNameController.clear();
    cityController.clear();
    addressController.clear();
    parishController.clear();
    atmNameController.clear();
    bankNameController.clear();
    employeeId.value = '';
    isWorking(false);
    isSmart(false);
    isDualCurrency(false);
    atmsList.value = [];
  }

  getEmployees() async {
    isEmployeeListLoading(true);
    employeesList.value = await FirebaseServices().getEmployeesList();
    isEmployeeListLoading(false);
  }

  handleAddOrUpdateButtonPress(bool isNewLocation, String locationId,
      {LocationModel? locationModel}) {
    if (locationFormKey.currentState!.validate()) {
      if (atmsList.isEmpty) {
        Get.snackbar("Error", "Please add an ATM",
            backgroundColor: kRed,
            colorText: Colors.white,
            margin: getMargin(all: 8));
      } else if (employeeId.value == '') {
        Get.snackbar("Error", "Please select an Employee",
            backgroundColor: kRed,
            colorText: Colors.white,
            margin: getMargin(all: 8));
      } else {
        if (isNewLocation) {
          addNewLocation();
        } else {
          updateLocation(locationId, locationModel!);
        }
      }
    }
  }

  getLocations() async {
    isLocationListLoading(true);
    locationsList.value = await FirebaseServices().getLocationsList();
    //  List<String> newRegions = [];
    // for (int i = 0; i < locationsList.length; i++) {
    //   newRegions.add(locationsList[i].parish);
    // }

    //  regions.value = getUniqueRegions(newRegions);
    isLocationListLoading(false);
  }

  getFilteredLocations(String bankName, String region) async {
    isLocationListLoading(true);
    locationsList.value =
        await FirebaseServices().getSortedLocations(bankName, region);
    isLocationListLoading(false);
  }

  List<String> getUniqueRegions(List<String> locationsList) {
    Set<String> uniqueRegions = locationsList.toSet();
    List<String> uniqueRegionsList = uniqueRegions.toList();
    return uniqueRegionsList;
  }

  addAtmToList() {
    if (atmFormKey.currentState!.validate())
      atmsList.add(AtmModel(
        isWorking: isWorking.value,
        atmName: atmNameController.text.trim(),
        bankName: bankNameController.text.trim(),
        isSmart: isSmart.value,
        isDualCurrency: isDualCurrency.value,
        driveThrough: driveThrough.value,
        offSite: offSite.value,
        branch: branch.value,
      ));
    atmNameController.clear();
    isWorking(false);
    bankNameController.clear();
  }

  addNewLocation() async {
    Services.showLoading();
    if (atmImage.value != null) {
      atmImageUrl.value = await Services.uploadFile(atmImage.value!,
          "AtmPictures/${DateTime.now().millisecondsSinceEpoch}");
    }
    //todo
    LocationModel locationModel = LocationModel(
      locationName: locationNameController.text.trim(),
      city: cityController.text.trim(),
      locationId: "",
      address: addressController.text.trim(),
      // offSite: offSite.value,
      // branch: branch.value,
      parish: parishController.text.trim(),
      employeeId: employeeId.value,
      imageUrl: atmImageUrl.value,
      atms: atmsList,
      avgWaitTimeInHrs: '0',
      avgWaitTimeInMin: '0',
      updatedAt: Timestamp.now(),
      updated: false,
    );

    print(locationModel.toMap());

    final id = await FirebaseServices().uploadNewLocation(locationModel);
    if (id == null) return;
    getLocations();
    Get.back();
    clearValues();
    Services.hideLoading();
  }

  updateLocation(String locationId, LocationModel locationModel1) async {
    Services.showLoading();
    if (atmImage.value != null && atmImage.value!.path.isNotEmpty) {
      atmImageUrl.value = (await Services.updateUploadedFile(
          atmImage.value,
          "AtmPictures/${DateTime.now().millisecondsSinceEpoch}",
          atmImageUrl.value))!;
      atmImage.value = null;
    }
    //todo
    LocationModel locationModel = LocationModel(
      locationName: locationNameController.text.trim(),
      city: cityController.text.trim(),
      locationId: locationId,
      address: addressController.text.trim(),
      // offSite: offSite.value,
      // branch: branch.value,
      parish: parishController.text.trim(),
      employeeId: employeeId.value,
      imageUrl: atmImageUrl.value,
      atms: atmsList,
      avgWaitTimeInMin: locationModel1.avgWaitTimeInMin,
      avgWaitTimeInHrs: locationModel1.avgWaitTimeInHrs,
      updatedAt: locationModel1.updatedAt,
      updated: false,
    );

    print(locationModel);
    await FirebaseServices().updateExistingLocation(locationModel);
    getLocations();
    Get.back();
    clearValues();
    Services.hideLoading();
  }

//todo
  editLocationValues(int index) {
    locationNameController.text = locationsList[index].locationName;
    cityController.text = locationsList[index].city;
    addressController.text = locationsList[index].address;
    // offSite.value = locationsList[index].offSite;
    // branch.value = locationsList[index].branch;
    parishController.text = locationsList[index].parish;
    isSmart.value = locationsList[index].atms[0].isSmart;
    isDualCurrency.value = locationsList[index].atms[0].isDualCurrency;
    employeeId.value = locationsList[index].employeeId;
    atmsList.value = locationsList[index].atms;
    atmImageUrl.value = locationsList[index].imageUrl!;
    print(parishController.text);
    // getSingleRegion(locationsList[index].parish);

    Get.to(() {
      return AddEditLocationScreen(
        isNewLocation: false,
        locationModel: locationsList[index],
      );
    });
  }

  fieldValidator(String value) {
    if (value.trim().isEmpty)
      return "This is required field";
    else
      return null;
  }

  pickVideo() async {
    video = await imagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      videoPlayerController = VideoPlayerController.file(File(video!.path))
        ..initialize().then((value) async {
          videoPlayerController!.initialize();
          videoReady(true);
          await videoPlayerController!.play();
          videoReady(false);
        });
    }
  }

  uploadVideo(String bankId, XFile video) async {
    Services.showLoading();
    await FirebaseServices().uploadAdVideo(video.path, bankId);
    views.value = 0;
    Services.hideLoading();
    Services.successMessage("Ad Video Uploaded");
  }

  getRemoteAdVideo(String bankId) async {
    Services.showLoading();
    AdModel? adModel = await FirebaseServices().getAd(bankId);

    views.value = adModel!.views;

    fetchedAdVideo.value = adModel.adUrl;
    if (fetchedAdVideo.value != '') {
      remoteVideoController =
          VideoPlayerController.network(fetchedAdVideo.value);
      await remoteVideoController?.initialize();
      videoReady(true);
      await remoteVideoController!.play();
      videoReady(false);
    }
    Services.hideLoading();
    Get.to(
      () => AdUploadingScreen(
        bankId: bankId,
      ),
    );
  }

  getLocationsList() async {
    isLoading(true);
    locationsList.value = await FirebaseServices().getLocationsList();

    List<String> regionsList = [];
    for (int i = 0; i < locationsList.value.length; i++) {
      regionsList.add(locationsList[i].parish);
    }

    //  regions.value = getUniqueRegions(regionsList);

    print(regions.value);
    isLoading(false);
  }

  Map<String, List<LocationModel>> createMap(List<LocationModel> locationList) {
    Map<String, List<LocationModel>> map = {};

    for (var location in locationList) {
      if (map.containsKey(location.parish)) {
        map[location.parish]!.add(location);
      } else {
        map[location.parish] = [location];
      }
    }

    return map;
  }

  getRegions() async {
    List<Region> regionsList = await FirebaseServices().getRegions();
    regions.value = regionsList;

    await getRegionBanks(regions.value.first.id!);
  }

  Future<void> getRegionBanks(String regionId) async {
    isLoadingRegionBanks(true);
    List<Bank> regionsList = await FirebaseServices().getRegionBanks(regionId);
    regionBanks(regionsList);
    isLoadingRegionBanks(false);
  }

  getSingleRegion(String regionId) async {
    Region region = await FirebaseServices().getRegion(regionId);
    print(region.name);
    if (region.name != '') {
      parishController.text = region.name;
    } else {
      parishController.text = 'Select Region';
    }
  }
}
