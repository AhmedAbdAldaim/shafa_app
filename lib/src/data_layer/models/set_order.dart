class SetOrderModel {
  late bool status;
  OrderModel? ordermodel;

  SetOrderModel({required this.ordermodel});

  SetOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    ordermodel = OrderModel.fromJson(json['order']);
  }
}

class OrderModel {
  late int id;
  late dynamic medicineId;
  late dynamic amount;
  OrderModel({required this.medicineId, required this.amount});
  
  OrderModel.fromJson(dynamic json) {
    id = json['id'];
    medicineId = json['medicine_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toMap() {
    return {
    'medicine_id': medicineId, 
    'amount': amount
    };
  }
}
