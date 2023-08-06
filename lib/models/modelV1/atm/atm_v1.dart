import 'package:atm_tracker/models/modelV1/time_converter/time_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'atm_v1.freezed.dart';

part 'atm_v1.g.dart';

@freezed
class AtmV1 with _$AtmV1 {
  const factory AtmV1({
    String? atmId,
    String? atmName,
    String? bank,
    bool? isDriveThu,
    bool? isDualCurrency,
    bool? isSmart,
    bool? isWorking,
    bool? offSite,
    bool? branch,
    @TimestampConverter() DateTime? createdAt,
  }) = _AtmV1;

  factory AtmV1.fromJson(Map<String, Object?> json) => _$AtmV1FromJson(json);
}
