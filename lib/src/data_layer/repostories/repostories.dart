import 'package:dartz/dartz.dart';
import 'package:medical_app/src/cores/errors/exceptionss.dart';
import 'package:medical_app/src/cores/errors/failure.dart';
import 'package:medical_app/src/cores/networkinfo.dart';
import 'package:medical_app/src/data_layer/data_sourse/remote/http_helper.dart';
import 'package:medical_app/src/data_layer/models/edit_profile.dart';
import 'package:medical_app/src/data_layer/models/get_orders.dart';
import 'package:medical_app/src/data_layer/models/login_model.dart';
import 'package:medical_app/src/data_layer/models/medicine_model.dart';
import 'package:medical_app/src/data_layer/models/register_model.dart';
import 'package:medical_app/src/data_layer/models/set_order.dart';

class Repostories {
  HttpHelper httpHelper;
  NetworkInfo networkInfo;
  Repostories({required this.httpHelper, required this.networkInfo});

//registerRepo
  Future<Either<Failure, RegisterModel>> registerRepo({required Map<String,dynamic> body}) async {
    
      try {
        RegisterModel registerModels =
            await httpHelper.registerHttp(body);
        return Right(registerModels);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
   
  }

//loginRepo
  Future<Either<Failure, LoginModel>> loginRepo({required Map<String,dynamic> body}) async {
    
      try {
        LoginModel loginModels = await httpHelper.loginHttp(body);
        return Right(loginModels);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
   
  }

//profile
  Future<Either<Failure, EditProfileModel>> profileRepo({required Map<String, dynamic> body}) async {

      try {
        EditProfileModel editProfileModel = await httpHelper.editProfileHttp(body);
        return Right(editProfileModel);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    
  }


//Mechines
  Future<Either<Failure, MedicineModel>> getAllMedicinsRepo() async {
   
      try {
        return Right(await httpHelper.getMedicineHttp());
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    
  }


//setOrder
Future<Either<Failure, SetOrderModel>> setOrdersRepo({required Map<String,dynamic> body}) async {
   
      try {
        SetOrderModel setOrderModels = await httpHelper.setOrderhttp(body);
        return Right(setOrderModels);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
 
  }

//getOrders
 Future<Either<Failure, GetOrderModel>> getOrdersRepo() async {

      try {
        return Right(await httpHelper.getAllOrdershttp());
      } on ServerExceptions {
        return Left(ServerFailure());
      }
   
  }


}
