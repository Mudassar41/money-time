class AdModel {
  final String adUrl;
  final num views;
  final String bankId;
  AdModel({
    required this.adUrl,
    required this.views,
    required this.bankId,
  });

  AdModel copyWith({
    String? adUrl,
    num? views,
    String? bankId,
  }) {
    return AdModel(
      adUrl: adUrl ?? this.adUrl,
      views: views ?? this.views,
      bankId: bankId ?? this.bankId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adUrl': adUrl,
      'views': views,
      'bankId': bankId,
    };
  }

  factory AdModel.fromMap(Map<String, dynamic> map) {
    return AdModel(
      adUrl: map['adUrl'] as String,
      views: map['views'] as num,
      bankId: map['bankId'] as String,
    );
  }
}
