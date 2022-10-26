class MedicineModel {
  late bool? status;
  List<Medicine>? medicine = [];
  List<Medicine>? filtermedicine = [];
  MedicineModel.fromJson(dynamic json) {
    status = json['status'];

    json['medicine'].forEach((element) {
      medicine!.add(Medicine.fromJson(element));
      filtermedicine = medicine;
    });
  }
}

class Medicine {
  late int id;
  late String name;
  late String company;
  late String expaireDate;
  late String price;
  late Pharma pharma;
  Medicine.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    company = json['company'];
    expaireDate = json['expaire_date'];
    price = json['price'];
    pharma = Pharma.fromJson(json['pharma']);
  }
}

class Pharma {
  late String name;
  late String addres;

  Pharma.fromJson(dynamic json) {
    name = json['name'];
    addres = json['addres'];
  }
}
