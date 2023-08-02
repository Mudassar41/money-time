class EmployeeModel {
  String firstName;
  String lastName;
  String phoneNumber;
  bool isPhoneVerified;
  String uid;
  String email;
  String role;
  String employeeId;
  EmployeeModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
     this.isPhoneVerified = false,
    required this.uid,
    required this.email,
     this.role = 'Employee',
    required this.employeeId,
  });

  EmployeeModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    bool? isPhoneVerified,
    String? uid,
    String? email,
    String? role,
    String? employeeId,
  }) {
    return EmployeeModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      role: role ?? this.role,
      employeeId: employeeId ?? this.employeeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'isPhoneVerified': isPhoneVerified,
      'uid': uid,
      'email': email,
      'role': role,
      'employeeId': employeeId,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      isPhoneVerified: map['isPhoneVerified'] as bool,
      uid: map['uid'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      employeeId: map['employeeId'] as String,
    );
  }
}
