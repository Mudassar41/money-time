import 'dart:io';
import 'package:atm_tracker/models/modelV1/time_converter/time_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_v1.freezed.dart';

part 'location_v1.g.dart';

@freezed
class LocationV1 with _$LocationV1 {
  const factory LocationV1({
    String? locationId,
    String? locationName,
    String? locationAdress,
    String? imageUrl,
    String? region,
    String? avgWaitInHrs,
    String? avgWaitInMins,
    String? city,
    @JsonKey(includeToJson: false, includeFromJson: false) File? imageFile,
    @TimestampConverter() DateTime? createdAt,
  }) = _LocationV1;

  factory LocationV1.fromJson(Map<String, Object?> json) =>
      _$LocationV1FromJson(json);
}
