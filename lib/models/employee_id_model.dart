class EmployeeIdModel {
  String id;
  bool isOccupied;
  String? employeeEmail;
  String? employeeName;
  EmployeeIdModel({
    required this.id,
    required this.isOccupied,
     this.employeeEmail,
     this.employeeName,
  });


  EmployeeIdModel copyWith({
    String? id,
    bool? isOccupied,
    String? employeeEmail,
    String? employeeName,
  }) {
    return EmployeeIdModel(
      id: id ?? this.id,
      isOccupied: isOccupied ?? this.isOccupied,
      employeeEmail: employeeEmail ?? this.employeeEmail,
      employeeName: employeeName ?? this.employeeName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isOccupied': isOccupied,
      'employeeEmail': employeeEmail,
      'employeeName': employeeName,
    };
  }

  factory EmployeeIdModel.fromMap(Map<String, dynamic> map) {
    return EmployeeIdModel(
      id: map['id'] as String,
      isOccupied: map['isOccupied'] as bool,
      employeeEmail: map['employeeEmail'] != null ? map['employeeEmail'] as String : null,
      employeeName: map['employeeName'] != null ? map['employeeName'] as String : null,
    );
  }
}
