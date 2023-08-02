class AtmModel {
  final bool isWorking;
  final String atmName;
  final String bankName;
  final bool isSmart;
  final bool isDualCurrency;
  final bool driveThrough;

  AtmModel({
    required this.isWorking,
    required this.atmName,
    required this.bankName,
    required this.isSmart,
    required this.isDualCurrency,
    required this.driveThrough,
  });

  AtmModel copyWith({
    bool? isWorking,
    String? atmName,
    String? bankName,
    bool? isSmart,
    bool? isDualCurrency,
    bool? driveThrough,
  }) {
    return AtmModel(
      isWorking: isWorking ?? this.isWorking,
      atmName: atmName ?? this.atmName,
      bankName: bankName ?? this.bankName,
      isSmart: isSmart ?? this.isSmart,
      isDualCurrency: isDualCurrency ?? this.isDualCurrency,
      driveThrough: driveThrough ?? this.driveThrough,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isWorking': isWorking,
      'atmName': atmName,
      'bankName': bankName,
      'isSmart': isSmart,
      'isDualCurrency': isDualCurrency,
      'driveThrough': driveThrough,
    };
  }

  factory AtmModel.fromMap(Map<String, dynamic> map) {
    return AtmModel(
      isWorking: map['isWorking'] as bool,
      atmName: map['atmName'] as String,
      bankName: map['bankName'] as String,
      isSmart: map['isSmart'] as bool,
      isDualCurrency: map['isDualCurrency'] as bool,
      driveThrough: map['driveThrough'] as bool,
    );
  }
}
