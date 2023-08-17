import 'package:atm_tracker/models/ad_model.dart';
import 'package:atm_tracker/models/location_model.dart';
import 'package:atm_tracker/services/firebase_services.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/views/user_side/ads_screen.dart';
import 'package:atm_tracker/views/user_side/atm_details_screen.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class UserController extends GetxController {
  List<LocationModel> _locationsList = [];
  RxList<LocationModel> filteredList = RxList();
  final RxList favouriteAtmsList = RxList();
  RxString bankName = ''.obs;
  RxString parishName = ''.obs;
  RxString filter = 'None'.obs;
  RxBool isLoading = false.obs;
  RxBool videoReady = false.obs;
  RxBool isAdLoading = false.obs;
  VideoPlayerController? videoPlayerController;
  RxString adVideoUrl = ''.obs;
  final RxMap<String, List<LocationModel>> parishMap = RxMap();

  @override
  void onInit() async {
    super.onInit();
    getLocationsList();
    favouriteAtmsList.bindStream(FirebaseServices().favouritesList());
  }

  getLocationsList() async {
    isLoading(true);
    _locationsList = await FirebaseServices().getLocationsList();
    parishMap.value = createMap(_locationsList);

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

  getFilteredList() {
    isLoading(true);
    RxList<LocationModel> parishFilteredList = _locationsList
        .where((location) => location.parish == parishName.value)
        .toList()
        .obs;
    RxList<LocationModel> bankFilteredList = parishFilteredList
        .where((location) {
          for (int i = 0; i < location.atms.length; i++) {
            if (location.atms[i].bankName == bankName.value) return true;
          }
          return false;
        })
        .toList()
        .obs;
    if (filter.value == "Favourites") {
      print('fav');
      RxList<LocationModel> favouriteFilteredList = RxList();
      for (LocationModel location in bankFilteredList) {
        if (favouriteAtmsList.contains(location.locationId)) {
          favouriteFilteredList.add(location);
        }
      }
      filteredList = favouriteFilteredList;
    } else if (filter.value == "Dual Currency") {
      filteredList = bankFilteredList
          .where((location) {
            for (int i = 0; i < location.atms.length; i++) {
              if (location.atms[i].isDualCurrency) return true;
            }
            return false;
          })
          .toList()
          .obs;
    } else if (filter.value == "Smart") {
      print('smart');
      filteredList = bankFilteredList
          .where((location) {
            for (int i = 0; i < location.atms.length; i++) {
              if (location.atms[i].isSmart) return true;
            }
            return false;
          })
          .toList()
          .obs;
    } else if (filter.value == "branch") {

      filteredList = bankFilteredList
          .where((location) {
        for (int i = 0; i < location.atms.length; i++) {
          if (location.atms[i].branch) return true;
        }
        return false;
      })
          .toList()
          .obs;
    } else if (filter.value == "offSite") {
      //todo
      // RxList<LocationModel> offSiteFilteredList = bankFilteredList
      //     .where((location) => location.offSite == true)
      //     .toList()
      //     .obs;
      //
      // filteredList = offSiteFilteredList;




      filteredList = bankFilteredList
          .where((location) {
        for (int i = 0; i < location.atms.length; i++) {
          if (location.atms[i].offSite) return true;
        }
        return false;
      })
          .toList()
          .obs;
    } else if (filter.value == 'drive') {
      filteredList = bankFilteredList
          .where((location) {
            for (int i = 0; i < location.atms.length; i++) {
              if (location.atms[i].driveThrough) return true;
            }
            return false;
          })
          .toList()
          .obs;
    } else {
      filteredList = bankFilteredList;
    }
    isLoading(false);
  }

  String getAtmDetails(int index) {
    String details = '';
    String dualCurrency = '';
    String smart = '';
    String offSite = '';
    String branch = '';
    String driveThrough='';
    for (int i = 0; i < filteredList[index].atms.length; i++) {
      if (filteredList[index].atms[i].isDualCurrency) {
        dualCurrency = "Dual Currency";
        break;
      }
    }
    for (int i = 0; i < filteredList[index].atms.length; i++) {
      if (filteredList[index].atms[i].isSmart) {
        smart = "Smart";
        break;
      }
    }


    for (int i = 0; i < filteredList[index].atms.length; i++) {
      if (filteredList[index].atms[i].driveThrough) {
        driveThrough = "Drive Through";
        break;
      }
    }
    //todo

    // if (filteredList[index].offSite) offSite = "Offsite";
    //
    // if (filteredList[index].branch) branch = "Branch";
    List<String> detailsList = [smart, dualCurrency, offSite, branch,driveThrough];

    for (String v in detailsList) {
      if (v != '') {
        details += "$v/";
      }
    }
    return details;
  }

  addOrRemoveFavourite(String locationId) async {
    List newList = favouriteAtmsList;
    if (favouriteAtmsList.contains(locationId)) {
      newList.remove(locationId);
    } else {
      newList.add(locationId);
    }
    await FirebaseServices().addOrRemoveFavouriteAtm(newList);
  }

//todo will fix later
  getRemoteAdVideo(
    int index,
    String bankId,
  ) async {
    Services.showLoading(isBackEnabled: false);
    AdModel? adModel = await FirebaseServices().getAd(bankId);

    adVideoUrl.value = adModel!.adUrl;
    print("=>>>>>>>>>>>>>>>>>>>>>${adVideoUrl.value}");
    if (adVideoUrl.value != '') {
      await FirebaseServices().incrementAdCount(bankId);
      videoPlayerController = VideoPlayerController.network(adVideoUrl.value);
      await videoPlayerController?.initialize();
      videoReady(true);
      await videoPlayerController!.play();
      videoReady(false);
      Services.hideLoading();
      Get.to(() => AdScreen(index: index));
    } else {
      Services.hideLoading();
      Get.to(() => AtmDetailsScreen(locationModel: filteredList[index]));
    }
  }
}
