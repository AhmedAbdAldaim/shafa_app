import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:medical_app/src/cores/app_string.dart';
import 'package:medical_app/src/data_layer/models/register_model.dart';
import 'package:medical_app/src/data_layer/repostories/repostories.dart';
import 'package:medical_app/src/domin_layer/registeration_cubit/register_state.dart';

import '../../cores/errors/failure.dart';

class RegisterCubit extends Cubit<RegisterState> {
  Repostories repo;
  RegisterCubit({required this.repo}) : super(RegisterInitial());

  registerCubitFun(
      {required Map<String,dynamic>body}) async {
    emit(RegisterLoading());
    final res = await repo.registerRepo(body: body);
    res.fold((l) {
      emit(RegisterError(AppString.getMeassgse(l)));
    }, (r) {
      emit(RegisterSuccess(r));
    });
  }

   // ObscurePassword
  bool ispassword = true;
  obscurePasswordFun() {
    ispassword = !ispassword;
    emit(ObscurePassword());
  }

  

}
