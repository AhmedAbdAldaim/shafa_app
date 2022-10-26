class GetOrderModel {
  late bool status;
  List<OrderModel>? ordermodel = [];

  GetOrderModel({required this.ordermodel});

  GetOrderModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['order'] != null) {
      json['order'].forEach((element) {
        print(element);
        ordermodel!.add(OrderModel.fromJson(element));
      });
    } else {
      print('sss');
    }
  }
}

class OrderModel {
  late int id;
  late dynamic amount;
  late MedicineOrderModel medicineOrderModel;

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    medicineOrderModel = MedicineOrderModel.fromJson(json['medicine']);
  }
}

class MedicineOrderModel {
  late int id;
  late String name;
  late String company;
  late String expaireDate;
  late String price;

  MedicineOrderModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    company = json['company'];
    expaireDate = json['expaire_date'];
    price = json['price'];
  }
}
