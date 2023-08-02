
import 'package:freezed_annotation/freezed_annotation.dart';
part 'atmV1.freezed.dart';
part 'atmV1.g.dart';

@freezed
class AtmV1 with _$AtmV1 {
  const factory AtmV1({
    String? atmV1Name,
    String? bank,
    bool? isDriveThu,
    bool? isDualCurrency,
    bool? isSmart,
    bool? isWorking,
    bool? offSite,
    bool? branch
  }) = _AtmV1;

  factory AtmV1.fromJson(Map<String, Object?> json)
  => _$AtmV1FromJson(json);
}