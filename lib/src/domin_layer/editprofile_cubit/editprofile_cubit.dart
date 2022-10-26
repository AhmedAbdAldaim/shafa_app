import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:medical_app/src/cores/app_string.dart';
import 'package:medical_app/src/data_layer/repostories/repostories.dart';
import 'package:medical_app/src/domin_layer/editprofile_cubit/editprofile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  Repostories repo;
  EditProfileCubit({required this.repo}) : super(EditProfileInitial());

  editProfileCubitFun({required Map<String, dynamic> body}) async {
    emit(EditProfileLoading());
    final res = await repo.profileRepo(body: body);
    res.fold((l) {
      emit(EditProfileError(AppString.getMeassgse(l)));
    }, (r) {
      emit(EditProfileSuccess(r));
    });
  }

  dispose(TextEditingController name, TextEditingController email,
      TextEditingController password, TextEditingController confirmpassword) {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmpassword.dispose();
  }

  // ObscurePassword
  bool ispassword = true;
  obscurePasswordFun() {
    ispassword = !ispassword;
    emit(ObscurePassword());
  }
}
