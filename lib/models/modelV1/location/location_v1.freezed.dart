// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_v1.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocationV1 _$LocationV1FromJson(Map<String, dynamic> json) {
  return _LocationV1.fromJson(json);
}

/// @nodoc
mixin _$LocationV1 {
  String? get locationId => throw _privateConstructorUsedError;
  String? get locationName => throw _privateConstructorUsedError;
  String? get locationAdress => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get avgWaitInHrs => throw _privateConstructorUsedError;
  String? get avgWaitInMins => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationV1CopyWith<LocationV1> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationV1CopyWith<$Res> {
  factory $LocationV1CopyWith(
          LocationV1 value, $Res Function(LocationV1) then) =
      _$LocationV1CopyWithImpl<$Res, LocationV1>;
  @useResult
  $Res call(
      {String? locationId,
      String? locationName,
      String? locationAdress,
      String? imageUrl,
      String? region,
      String? avgWaitInHrs,
      String? avgWaitInMins,
      String? city});
}

/// @nodoc
class _$LocationV1CopyWithImpl<$Res, $Val extends LocationV1>
    implements $LocationV1CopyWith<$Res> {
  _$LocationV1CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationId = freezed,
    Object? locationName = freezed,
    Object? locationAdress = freezed,
    Object? imageUrl = freezed,
    Object? region = freezed,
    Object? avgWaitInHrs = freezed,
    Object? avgWaitInMins = freezed,
    Object? city = freezed,
  }) {
    return _then(_value.copyWith(
      locationId: freezed == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String?,
      locationName: freezed == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationAdress: freezed == locationAdress
          ? _value.locationAdress
          : locationAdress // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      avgWaitInHrs: freezed == avgWaitInHrs
          ? _value.avgWaitInHrs
          : avgWaitInHrs // ignore: cast_nullable_to_non_nullable
              as String?,
      avgWaitInMins: freezed == avgWaitInMins
          ? _value.avgWaitInMins
          : avgWaitInMins // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocationV1CopyWith<$Res>
    implements $LocationV1CopyWith<$Res> {
  factory _$$_LocationV1CopyWith(
          _$_LocationV1 value, $Res Function(_$_LocationV1) then) =
      __$$_LocationV1CopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? locationId,
      String? locationName,
      String? locationAdress,
      String? imageUrl,
      String? region,
      String? avgWaitInHrs,
      String? avgWaitInMins,
      String? city});
}

/// @nodoc
class __$$_LocationV1CopyWithImpl<$Res>
    extends _$LocationV1CopyWithImpl<$Res, _$_LocationV1>
    implements _$$_LocationV1CopyWith<$Res> {
  __$$_LocationV1CopyWithImpl(
      _$_LocationV1 _value, $Res Function(_$_LocationV1) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationId = freezed,
    Object? locationName = freezed,
    Object? locationAdress = freezed,
    Object? imageUrl = freezed,
    Object? region = freezed,
    Object? avgWaitInHrs = freezed,
    Object? avgWaitInMins = freezed,
    Object? city = freezed,
  }) {
    return _then(_$_LocationV1(
      locationId: freezed == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String?,
      locationName: freezed == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationAdress: freezed == locationAdress
          ? _value.locationAdress
          : locationAdress // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      avgWaitInHrs: freezed == avgWaitInHrs
          ? _value.avgWaitInHrs
          : avgWaitInHrs // ignore: cast_nullable_to_non_nullable
              as String?,
      avgWaitInMins: freezed == avgWaitInMins
          ? _value.avgWaitInMins
          : avgWaitInMins // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocationV1 implements _LocationV1 {
  const _$_LocationV1(
      {this.locationId,
      this.locationName,
      this.locationAdress,
      this.imageUrl,
      this.region,
      this.avgWaitInHrs,
      this.avgWaitInMins,
      this.city});

  factory _$_LocationV1.fromJson(Map<String, dynamic> json) =>
      _$$_LocationV1FromJson(json);

  @override
  final String? locationId;
  @override
  final String? locationName;
  @override
  final String? locationAdress;
  @override
  final String? imageUrl;
  @override
  final String? region;
  @override
  final String? avgWaitInHrs;
  @override
  final String? avgWaitInMins;
  @override
  final String? city;

  @override
  String toString() {
    return 'LocationV1(locationId: $locationId, locationName: $locationName, locationAdress: $locationAdress, imageUrl: $imageUrl, region: $region, avgWaitInHrs: $avgWaitInHrs, avgWaitInMins: $avgWaitInMins, city: $city)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocationV1 &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.locationAdress, locationAdress) ||
                other.locationAdress == locationAdress) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.avgWaitInHrs, avgWaitInHrs) ||
                other.avgWaitInHrs == avgWaitInHrs) &&
            (identical(other.avgWaitInMins, avgWaitInMins) ||
                other.avgWaitInMins == avgWaitInMins) &&
            (identical(other.city, city) || other.city == city));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, locationId, locationName,
      locationAdress, imageUrl, region, avgWaitInHrs, avgWaitInMins, city);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationV1CopyWith<_$_LocationV1> get copyWith =>
      __$$_LocationV1CopyWithImpl<_$_LocationV1>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationV1ToJson(
      this,
    );
  }
}

abstract class _LocationV1 implements LocationV1 {
  const factory _LocationV1(
      {final String? locationId,
      final String? locationName,
      final String? locationAdress,
      final String? imageUrl,
      final String? region,
      final String? avgWaitInHrs,
      final String? avgWaitInMins,
      final String? city}) = _$_LocationV1;

  factory _LocationV1.fromJson(Map<String, dynamic> json) =
      _$_LocationV1.fromJson;

  @override
  String? get locationId;
  @override
  String? get locationName;
  @override
  String? get locationAdress;
  @override
  String? get imageUrl;
  @override
  String? get region;
  @override
  String? get avgWaitInHrs;
  @override
  String? get avgWaitInMins;
  @override
  String? get city;
  @override
  @JsonKey(ignore: true)
  _$$_LocationV1CopyWith<_$_LocationV1> get copyWith =>
      throw _privateConstructorUsedError;
}
