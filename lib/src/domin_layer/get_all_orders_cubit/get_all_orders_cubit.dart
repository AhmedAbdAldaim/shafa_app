import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/src/cores/app_string.dart';
import 'package:medical_app/src/data_layer/models/get_orders.dart';
import 'package:medical_app/src/data_layer/repostories/repostories.dart';
import 'package:medical_app/dependency_injection.dart' as di;
import 'package:medical_app/src/domin_layer/get_all_orders_cubit/get_all_orders_state.dart';

class GetAllOrdersCubit extends Cubit<GetAllOrdersState> {
  Repostories repo;
  GetAllOrdersCubit({
    required this.repo,
  }) : super(GetAllOrdersInitial());

  //getAllOrders
  List<OrderModel> list = [];
  getAllOrdersFun() async {
    emit(GetAllOrdersLoading());
    var res = await repo.getOrdersRepo();
    res.fold((l) {
      emit(GetAllOrdersError(AppString.getMeassgse(l)));
    }, (r) {
      list = r.ordermodel!;
      emit(GetAllOrdersSuccess(r));
    });
  }
}
