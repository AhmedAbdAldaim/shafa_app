class LoginModel {
  late bool status;
  late String message;
  String? token;
  UserModel? usermodel;

  LoginModel({required this.usermodel});

  LoginModel.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    token = json['token'];
    usermodel = json['user']!=null?UserModel.fromJson(json['user']): null;
  }
}

class UserModel {
  late String name;
  late String email;
  late String password;
  late String? photo;

  UserModel({required this.email, required this.password});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }
}
