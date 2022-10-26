import '../../data_layer/models/edit_profile.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final EditProfileModel EditProfilemodel;
  EditProfileSuccess(this.EditProfilemodel);
}

class EditProfileError extends EditProfileState {
  final String message;
  EditProfileError(this.message);
}

class ObscurePassword extends EditProfileState {}
