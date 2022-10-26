import 'package:medical_app/src/data_layer/models/medicine_model.dart';

abstract class MedicineState {}

class MedicineInitial extends MedicineState {}

class MedicineLoading extends MedicineState {}

class MedicineSuccess extends MedicineState {

}

class MedicineError extends MedicineState {
  final String message;
  MedicineError(this.message);
}

class SearchMedicine extends MedicineState{}

class AddtoCart extends MedicineState{}
class AddAmount extends MedicineState{}
class ClearAmount extends MedicineState{}

class CountTable extends MedicineState{}
class DeleteItem extends MedicineState{}
class DeleteAllProducts extends MedicineState{}

class TotalProducst  extends MedicineState{}

class SetOrderLoading extends MedicineState{}
class SetOrderSuccess extends MedicineState{}
class SetOrderError extends MedicineState{}

