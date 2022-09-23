class ResponseLogin {
  Data? data;

  ResponseLogin({this.data});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Login? login;

  Data({this.login});

  Data.fromJson(Map<String, dynamic> json) {
    login = json['login'] != null ? new Login.fromJson(json['login']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.login != null) {
      data['login'] = this.login!.toJson();
    }
    return data;
  }
}

class Login {
  String? token;
  User? user;
  Null? error;
  Null? message;

  Login({this.token, this.user, this.error, this.message});

  Login.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}

class User {
  String? fullName;
  Email? email;
  String? password;

  User({this.fullName, this.email, this.password});

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'] != null ? new Email.fromJson(json['email']) : null;
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    if (this.email != null) {
      data['email'] = this.email!.toJson();
    }
    data['password'] = this.password;
    return data;
  }
}

class Email {
  String? emailStr;
  bool? isVerified;

  Email({this.emailStr, this.isVerified});

  Email.fromJson(Map<String, dynamic> json) {
    emailStr = json['email_str'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_str'] = this.emailStr;
    data['is_verified'] = this.isVerified;
    return data;
  }
}
