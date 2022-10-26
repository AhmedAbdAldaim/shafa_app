import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medical_app/src/cores/networkinfo.dart';
import 'package:medical_app/src/data_layer/data_sourse/local/sharedprefrencese_helper.dart';
import 'package:medical_app/src/data_layer/data_sourse/local/sqflite_helper.dart';
import 'package:medical_app/src/data_layer/data_sourse/remote/http_helper.dart';
import 'package:medical_app/src/data_layer/repostories/repostories.dart';
import 'package:medical_app/src/domin_layer/editprofile_cubit/editprofile_cubit.dart';
import 'package:medical_app/src/domin_layer/get_all_orders_cubit/get_all_orders_cubit.dart';
import 'package:medical_app/src/domin_layer/login_cubit/login_cubit.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_cubit.dart';
import 'package:medical_app/src/domin_layer/registeration_cubit/register_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerLazySingleton(() => RegisterCubit(repo: sl()));
  sl.registerLazySingleton(() => LoginCubit(repo: sl()));
  sl.registerLazySingleton(() => MedicineCubit(repo: sl()));

  sl.registerLazySingleton(() => GetAllOrdersCubit(repo: sl()));
  sl.registerLazySingleton(() => EditProfileCubit(repo: sl()));

  //repo
  sl.registerLazySingleton(
      () => Repostories(httpHelper: sl(), networkInfo: sl()));

  //datasourse
  sl.registerLazySingleton(() => HttpHelper(client: sl()));
  sl.registerLazySingleton(
      () => SharedPrefrencesHelper(sharedprefrences: sl()));

  //network
  sl.registerLazySingleton(() => NetworkInfo(internetConnectionChecker: sl()));

  //service
  final shared = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => shared);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
