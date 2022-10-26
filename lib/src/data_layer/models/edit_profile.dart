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
  late String passwrod;
  UserModel({required this.name, required this.email, required this.passwrod});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }
}
