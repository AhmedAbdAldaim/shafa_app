import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/src/cores/app_string.dart';
import 'package:medical_app/src/data_layer/models/login_model.dart';
import 'package:medical_app/src/data_layer/repostories/repostories.dart';
import 'package:medical_app/src/domin_layer/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repostories repo;
  LoginCubit({required this.repo}) : super(LoginInitial());

  //cubit login
  loginCubitFun({required Map<String, dynamic> body}) async {
    emit(LoginLoading());
    final res = await repo.loginRepo(body: body);
    res.fold((l) {
      emit(LoginError(AppString.getMeassgse(l)));
    }, (r) {
      emit(LoginSuccess(r));
    });
  }

  // ObscurePassword
  bool ispassword = true;
  obscurePasswordFun() {
    ispassword = !ispassword;
    emit(ObscurePassword());
  }
}
