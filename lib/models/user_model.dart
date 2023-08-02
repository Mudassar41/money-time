class UserModel {
  String userEmail;
  String bankName;
  String uid;
  String age;
  bool isPhoneVerified;
  String sex;
  String role;
  String phoneNumber;
  List favouriteAtms;
  UserModel({
    required this.userEmail,
    required this.bankName,
    required this.uid,
    required this.age,
    this.isPhoneVerified = false,
    required this.sex,
    this.role = 'User',
    required this.phoneNumber,
   this.favouriteAtms = const [],
  });

  UserModel copyWith({
    String? userEmail,
    String? bankName,
    String? uid,
    String? age,
    bool? isPhoneVerified,
    String? sex,
    String? role,
    String? phoneNumber,
    List? favouriteAtms,
  }) {
    return UserModel(
      userEmail: userEmail ?? this.userEmail,
      bankName: bankName ?? this.bankName,
      uid: uid ?? this.uid,
      age: age ?? this.age,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      sex: sex ?? this.sex,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      favouriteAtms: favouriteAtms ?? this.favouriteAtms,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userEmail': userEmail,
      'bankName': bankName,
      'uid': uid,
      'age': age,
      'isPhoneVerified': isPhoneVerified,
      'sex': sex,
      'role': role,
      'phoneNumber': phoneNumber,
      'favouriteAtms': favouriteAtms,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        userEmail: map['userEmail'] as String,
        bankName: map['bankName'] as String,
        uid: map['uid'] as String,
        age: map['age'] as String,
        isPhoneVerified: map['isPhoneVerified'] as bool,
        sex: map['sex'] as String,
        role: map['role'] as String,
        phoneNumber: map['phoneNumber'] as String,
        favouriteAtms: List.from(
          (map['favouriteAtms'] as List),
        ));
  }
}
