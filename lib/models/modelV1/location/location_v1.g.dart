// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocationV1 _$$_LocationV1FromJson(Map<String, dynamic> json) =>
    _$_LocationV1(
      locationId: json['locationId'] as String?,
      locationName: json['locationName'] as String?,
      locationAdress: json['locationAdress'] as String?,
      imageUrl: json['imageUrl'] as String?,
      region: json['region'] as String?,
      avgWaitInHrs: json['avgWaitInHrs'] as String?,
      avgWaitInMins: json['avgWaitInMins'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$$_LocationV1ToJson(_$_LocationV1 instance) =>
    <String, dynamic>{
      'locationId': instance.locationId,
      'locationName': instance.locationName,
      'locationAdress': instance.locationAdress,
      'imageUrl': instance.imageUrl,
      'region': instance.region,
      'avgWaitInHrs': instance.avgWaitInHrs,
      'avgWaitInMins': instance.avgWaitInMins,
      'city': instance.city,
    };
