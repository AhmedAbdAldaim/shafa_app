import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_app/src/cores/app_string.dart';
import 'package:medical_app/src/cores/errors/exceptionss.dart';
import 'package:medical_app/src/data_layer/data_sourse/local/sharedprefrencese_helper.dart';
import 'package:medical_app/src/data_layer/models/edit_profile.dart';
import 'package:medical_app/src/data_layer/models/get_orders.dart';
import 'package:medical_app/src/data_layer/models/login_model.dart';
import 'package:medical_app/src/data_layer/models/medicine_model.dart';
import 'package:medical_app/src/data_layer/models/register_model.dart';
import 'package:medical_app/dependency_injection.dart' as di;
import 'package:medical_app/src/data_layer/models/set_order.dart';

class HttpHelper {
  final http.Client client;
  HttpHelper({required this.client});

//register
  Future<RegisterModel> registerHttp(Map<String, dynamic> body) async {
    http.Response response = await client.post(
        Uri.parse('${AppString.baseUel}${AppString.register}'),
        body: body);

    if (response.statusCode == 200) {
      print(response.body);
      RegisterModel registerModel =
          RegisterModel.fromJson(jsonDecode(response.body));
      return registerModel;
    } else {
      print('sks');
      throw ServerExceptions();
    }
  }

//login
  Future<LoginModel> loginHttp(Map<String, dynamic> body) async {
    http.Response response = await client
        .post(Uri.parse('${AppString.baseUel}${AppString.login}'), body: body);
    if (response.statusCode == 200) {
      LoginModel loginmodel = LoginModel.fromJson(jsonDecode(response.body));
      return loginmodel;
    } else {
      throw ServerExceptions();
    }
  }

//profile
  Future<EditProfileModel> editProfileHttp(Map<String, dynamic> body) async {
    http.Response response = await client
        .post(Uri.parse('${AppString.baseUel}${AppString.profile}'), headers: {
      'Authorization': di.sl<SharedPrefrencesHelper>().getData(key: 'token')
    }, body: body);
    if (response.statusCode == 200) {
      EditProfileModel editProfileModel = EditProfileModel.fromJson(jsonDecode(response.body));
      return editProfileModel;
    } else {
      throw ServerExceptions();
    }
  }

//get Medicines
  Future<MedicineModel> getMedicineHttp() async {
    http.Response response = await client
        .get(Uri.parse('${AppString.baseUel}${AppString.medicine}'), headers: {
      'Authorization': di.sl<SharedPrefrencesHelper>().getData(key: 'token')
    });
    if (response.statusCode == 200) {
      // var resBody = jsonDecode(response.body) as List;
      MedicineModel medicineModel =
          MedicineModel.fromJson(jsonDecode(response.body));
      return medicineModel;
    } else {
      throw ServerExceptions();
    }
  }

  //set Orders
  Future<SetOrderModel> setOrderhttp(Map<String, dynamic> body) async {
    http.Response response = await client.post(
      Uri.parse('${AppString.baseUel}${AppString.order}'),
      headers: {
        'Authorization': di.sl<SharedPrefrencesHelper>().getData(key: 'token')
      },
      body: body,
    );
    if (response.statusCode == 200) {
      SetOrderModel orderModel =
          SetOrderModel.fromJson(jsonDecode(response.body));
  
      return orderModel;
    } else {
      throw ServerExceptions();
    }
  }

  //get Orders
  Future<GetOrderModel> getAllOrdershttp() async {
    http.Response response = await client.get(
      Uri.parse('${AppString.baseUel}${AppString.order}'),
      headers: {
        'Authorization': di.sl<SharedPrefrencesHelper>().getData(key: 'token')
      },
    );
    if (response.statusCode == 200) {
      GetOrderModel getOrderModel =
          GetOrderModel.fromJson(jsonDecode(response.body));
      print(getOrderModel.status);
      return getOrderModel;
    } else {
      throw ServerExceptions();
    }
  }
}
