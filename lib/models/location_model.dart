import 'package:atm_tracker/models/atm_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  final String locationName;
  final String city;
  final String locationId;
  final String address;

  // final bool offSite;
  // final bool branch;
  final String parish;
  final String? noOfPersons;
  final String? averageWaitingTime;
  final String? avgWaitTimeInMin;
  final String? avgWaitTimeInHrs;
  final String employeeId;
  final String? imageUrl;
  final List<AtmModel> atms;
  final Timestamp? updatedAt;
  final bool? updated;

  LocationModel({
    required this.locationName,
    required this.city,
    required this.locationId,
    required this.address,
    // required this.offSite,
    // required this.branch,
    required this.parish,
    this.noOfPersons = '0',
    this.averageWaitingTime = '1',
    required this.employeeId,
    this.imageUrl,
    this.atms = const [],
    this.avgWaitTimeInHrs,
    this.avgWaitTimeInMin,
    this.updatedAt,
    this.updated,
  });

  LocationModel copyWith({
    String? locationName,
    String? city,
    String? locationId,
    String? address,
    bool? offSite,
    bool? branch,
    String? parish,
    String? noOfPersons,
    String? averageWaitingTime,
    String? employeeId,
    String? imageUrl,
    String? avgWaitTimeInMin,
    String? avgWaitTimeInHrs,
    List<AtmModel>? atms,
    Timestamp? updatedAt,
    bool? updated,
  }) {
    return LocationModel(
      locationName: locationName ?? this.locationName,
      city: city ?? this.city,
      locationId: locationId ?? this.locationId,
      address: address ?? this.address,
      // offSite: offSite ?? this.offSite,
      // branch: branch ?? this.branch,
      parish: parish ?? this.parish,
      avgWaitTimeInHrs: avgWaitTimeInHrs ?? this.avgWaitTimeInHrs,
      avgWaitTimeInMin: avgWaitTimeInMin ?? this.avgWaitTimeInMin,
      noOfPersons: noOfPersons ?? this.noOfPersons,
      averageWaitingTime: averageWaitingTime ?? this.averageWaitingTime,
      employeeId: employeeId ?? this.employeeId,
      imageUrl: imageUrl ?? this.imageUrl,
      atms: atms ?? this.atms,
      updatedAt: updatedAt ?? this.updatedAt,
      updated: updated??this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locationName': locationName,
      'city': city,
      'locationId': locationId,
      'address': address,
      // 'offSite': offSite,
      // 'branch': branch,
      'parish': parish,
      'avgWaitTimeInMin': avgWaitTimeInMin,
      'avgWaitTimeInHrs': avgWaitTimeInHrs,
      'noOfPersons': noOfPersons,
      'averageWaitingTime': averageWaitingTime,
      'employeeId': employeeId,
      'imageUrl': imageUrl,
      'atms': atms.map((x) => x.toMap()).toList(),
      'updatedAt':updatedAt,
      'updated':updated,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      locationName: map['locationName'] as String,
      city: map['city'] as String,
      locationId: map['locationId'] as String,
      address: map['address'] as String,
      // offSite: map['offSite'] as bool,
      // branch: map['branch'] as bool,
      parish: map['parish'] as String,
      noOfPersons:
          map['noOfPersons'] != null ? map['noOfPersons'] as String : null,
      averageWaitingTime: map['averageWaitingTime'] != null
          ? map['averageWaitingTime'] as String
          : null,
      avgWaitTimeInMin: map['avgWaitTimeInMin'] != null
          ? map['avgWaitTimeInMin'] as String
          : null,
      avgWaitTimeInHrs: map['avgWaitTimeInHrs'] != null
          ? map['avgWaitTimeInHrs'] as String
          : null,
      employeeId: map['employeeId'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      atms: List<AtmModel>.from(
        (map['atms'] as List).map<AtmModel>(
          (x) => AtmModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as Timestamp : null,
      updated: map['updated'] != null ? map['updated'] as bool : null,
    );
  }
}
