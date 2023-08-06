import 'package:cloud_firestore/cloud_firestore.dart';

base class CollectionsRef {
  CollectionReference locationRef =
      FirebaseFirestore.instance.collection('Locations');



}
