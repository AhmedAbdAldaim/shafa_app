import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/src/cores/app_string.dart';
import 'package:medical_app/src/data_layer/data_sourse/local/sqflite_helper.dart';
import 'package:medical_app/src/data_layer/models/medicine_model.dart';
import 'package:medical_app/src/data_layer/models/set_order.dart';
import 'package:medical_app/src/data_layer/repostories/repostories.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_state.dart';


class MedicineCubit extends Cubit<MedicineState> {
  Repostories repo;
  MedicineCubit({
    required this.repo,
  }) : super(MedicineInitial());

  //getMedicine
  //List<Medicine>? list = [];
  MedicineModel? model;
  getAllMedicineFun() async {
    emit(MedicineLoading());
    var res = await repo.getAllMedicinsRepo();
    res.fold((l) {
      emit(MedicineError(AppString.getMeassgse(l)));
    }, (r) {
      model = r;
      emit(MedicineSuccess());
    });
  }

  //search
  searchMedicine({required String value}) {
    model!.filtermedicine = model!.medicine!.where((element) {
      return element.name.startsWith(value);
    }).toList();
    emit(MedicineSuccess());
  }

  // SqlIte

//create db
  createDb() {
    SqliteHelpr.createDatabase().then((value) {
      getProductsSqlite();
      getCountTable();
    }).catchError((error) {
      print(error);
    });
  }

  //insert cart
  addToCartFun({required int id, required String name, required int price}) {
    SqliteHelpr.insertProducts(id, id, name, price, amount).then((value) {
      print("insert Done!");
      getCountTable();
      countTotals();
      getProductsSqlite();
      emit(AddtoCart());
    }).catchError((error) {
      print(error);
    });
  }

  //check if add to cart
  int? checkIdisAdd;
  checkifAddedFun(id) {
    SqliteHelpr.isAddedToCart(id).then((value) {
      for (var element in value) {
        checkIdisAdd = element['id'];
        emit(AddtoCart());
        print(id);
      }
    });
  }

  int amount = 1;
//ADD
  addAmount() {
    amount++;
    emit(AddAmount());
  }

//clear
  clearAmount() {
    if (amount > 1) amount--;
    emit(ClearAmount());
  }

//count table
  int countTable = 0;
  getCountTable() {
    SqliteHelpr.getCountofTable().then((value) {
      countTable = value!;
      emit(CountTable());
      print(value);
    });
  }

//get all products
  var getAllBsketProducts = [];
  getProductsSqlite() {
    SqliteHelpr.getAllProducts().then((value) {
      getAllBsketProducts = [];
      getAllBsketProducts.addAll(value);
      countTotals();
    }).catchError((error) {
      print((error));
    });
  }

  //update amount inc
  incrementupdateAmount({required int id, required int amount}) {
    SqliteHelpr.updateAmount(id, amount).then((value) {
      getProductsSqlite();
    }).catchError((error) {
      print(error);
    });
  }

// update amount dec
  decrementupdateAmount({required int id, required int amount}) {
    SqliteHelpr.updateAmount(id, amount).then((value) {
      getProductsSqlite();
    }).catchError((error) {
      print(error);
    });
  }

//delete item
  deleteItemProducts({required int id}) {
    SqliteHelpr.deleteItemProduct(id).then((value) {
      getProductsSqlite();
      countTotals();
      getCountTable();
      emit(DeleteItem());
    });
  }

  //delet alll
  deleteAllProducts() {
    SqliteHelpr.deleteAllProducts().then((value) {
      getAllBsketProducts = [];
      totalPrice = 0;
      getCountTable();
      emit(DeleteAllProducts());
    });
  }

  int? totalPrice;
  countTotals() {
    SqliteHelpr.getCountPriceProducts().then((value) {
      totalPrice = 0;
      totalPrice = int.parse(value);
      emit(TotalProducst());
    });
  }

// post Purecache
  SetOrderModel? setOrderModel;
  sendOrders({
    required Map<String, dynamic> body,
  }) async {
    emit(SetOrderLoading());
    var res = await repo.setOrdersRepo(body: body);
    res.fold((l) {
      print(l);
      emit(SetOrderError());
    }, (r) {
      emit(SetOrderSuccess());
    });
  }
}
