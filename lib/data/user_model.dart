class UserModel {
  String? fullName;
  String? email;
  String? password;

  UserModel({this.fullName, this.email, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
