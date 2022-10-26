import 'package:medical_app/src/data_layer/models/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginmodel;
  LoginSuccess(this.loginmodel);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class ObscurePassword extends LoginState{}