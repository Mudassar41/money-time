// class AdminModel {
//   String? adminEmail;
//   String? role;
//   String? uid;
//   bool? isApproved;

//   AdminModel({this.adminEmail, this.role = "Admin", this.isApproved, this.uid});

//   AdminModel.fromJson(Map<String, dynamic> json) {
//     adminEmail = json['adminEmail'];
//     role = json['Role'];
//     isApproved = json['isApproved'];
//     uid = json['uid'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['adminEmail'] = this.adminEmail;
//     data['Role'] = this.role;
//     data['isApproved'] = this.isApproved;
//     data['uid'] = this.uid;
//     return data;
//   }
// }
