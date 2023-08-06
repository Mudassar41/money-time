import 'dart:io';
import 'package:atm_tracker/models/modelV1/atm/atm_v1.dart';
import 'package:atm_tracker/models/modelV1/location/location_v1.dart';
import 'package:atm_tracker/servicesV1/collections_ref.dart';
import 'package:firebase_storage/firebase_storage.dart';

final class FirestoreServiceV1 extends CollectionsRef {
  Future<String> addLocation(LocationV1 location) async {
    try {
      final ref = locationRef.doc();
      location = location.copyWith(locationId: ref.id);
      await ref.set(location.toJson());
      return location.locationId ?? "";
    } on FirebaseException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  static Future<String> uploadFile(File file, String serverPath) async {
    Reference reference = FirebaseStorage.instance.ref().child(serverPath);
    UploadTask uploadTask = reference.putFile(file);
    try {
      TaskSnapshot snapshot = await uploadTask;
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> addAtm(String locationId, AtmV1 atm) async {
    try {
      final ref = locationRef.doc().collection('Atms').doc(locationId);
      atm = atm.copyWith(atmId: ref.id);
      await ref.set(atm.toJson());
    } on FirebaseException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
