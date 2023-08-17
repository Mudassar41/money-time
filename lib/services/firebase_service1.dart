import 'dart:io';

import 'package:atm_tracker/models/ad_model.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServiceV1 {
  CollectionReference adsCollection =
      FirebaseFirestore.instance.collection('AdsCollection');
  final storageRef = FirebaseStorage.instance.ref('adVideos');

  addUpdateAd(String bankId, String filePath) async {
    Services.showLoading();
    bool isAdExist = await adExist(bankId);
    if (isAdExist) {
      await storageRef.child('Ad $bankId').delete();
      await updateAd(bankId, filePath);
      Services.hideLoading();
      Services.successMessage("Ad Video Updated");
    } else {
      await uploadAdVideo(bankId, filePath);
      Services.hideLoading();
      Services.successMessage("Ad Video Uploaded");
    }
  }

  Future<bool> adExist(String bankId) async {
    QuerySnapshot data =
        await adsCollection.where('bankId', isEqualTo: bankId).get();

    if (data.size > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateAd(String bankId, String path) async {
    var task;
    try {
      task = await storageRef.child('Ad $bankId').putFile(
        File(path),
      );
    } on FirebaseException catch (e) {
      Services.errorMessage(e.message!);
    }
    var adUrl = await task.ref.getDownloadURL();

    print('Add url is ---------------------------> $adUrl');

    try {
      var data = await adsCollection.where('bankId', isEqualTo: bankId).get();
      DocumentSnapshot adDoc = data.docs.first;
      AdModel adModel = AdModel(
        adUrl: adUrl,
        views: adDoc['views'],
        bankId: adDoc['bankId'],
      );
      await adDoc.reference.update(adModel.toMap());
    } on FirebaseException catch (e) {
      Services.errorMessage(e.message!);
    }
  }

  Future<void> uploadAdVideo(String bankId, String path) async {
    var task;
    try {
      task = await storageRef.child('Ad $bankId').putFile(
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
      await adsCollection.add(adModel.toMap());
    } on FirebaseException catch (e) {
      Services.errorMessage(e.message!);
    }
  }
}
