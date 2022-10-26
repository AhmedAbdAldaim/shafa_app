
import 'package:medical_app/src/data_layer/models/get_orders.dart';

abstract class GetAllOrdersState {}

class GetAllOrdersInitial extends GetAllOrdersState {}

class GetAllOrdersLoading extends GetAllOrdersState {}

class GetAllOrdersSuccess extends GetAllOrdersState {
  final GetOrderModel? getAllOrdersmodel;
  GetAllOrdersSuccess(this.getAllOrdersmodel);
}

class GetAllOrdersError extends GetAllOrdersState {
  final String message;
  GetAllOrdersError(this.message);
}
