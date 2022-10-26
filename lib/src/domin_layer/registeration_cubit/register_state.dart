
import 'package:medical_app/src/data_layer/models/register_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterModel registermodel;
  RegisterSuccess(this.registermodel);
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}

class ObscurePassword extends RegisterState{}
