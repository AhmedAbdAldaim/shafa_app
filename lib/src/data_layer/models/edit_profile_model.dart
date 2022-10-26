class EditProfileModel {
  late bool status;
  late UserModel usermodel;

  EditProfileModel({required this.usermodel});
  EditProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    usermodel = UserModel.fromJson(json['user']);
  }
}

class UserModel {
  late String name;
  late String email;
  late String password;
  UserModel({required this.name, required this.email, required this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }
  
  Map<String, dynamic> toMap() {
      return {'name':name, 'email': email, 'password': password};
  }
}
