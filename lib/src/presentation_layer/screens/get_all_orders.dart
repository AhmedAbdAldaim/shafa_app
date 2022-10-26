import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:medical_app/src/domin_layer/get_all_orders_cubit/get_all_orders_cubit.dart';
import 'package:medical_app/src/domin_layer/get_all_orders_cubit/get_all_orders_state.dart';
import 'package:medical_app/dependency_injection.dart' as di;
import 'package:medical_app/src/presentation_layer/widgets/build_item_cart.dart';
import 'package:medical_app/src/presentation_layer/widgets/build_item_order.dart';

class GetAllOrdersScreen extends StatelessWidget {
  GetAllOrdersScreen({super.key});
  var cubit = di.sl<GetAllOrdersCubit>();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      cubit.getAllOrdersFun();
      return BlocConsumer<GetAllOrdersCubit, GetAllOrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('الطلبات السابقة'),
                centerTitle: true,
              ),
              body: Padding(
                padding: EdgeInsets.all(
                    AppMediaQuery.width(context: context) * 0.04),
                child: ConditionalBuilder(
                  condition: state is GetAllOrdersSuccess,
                  builder: (context) {
                    return cubit.list.isEmpty
                        ? const Center(child: Text("لا توجد طلبات ."))
                        : ListView.builder(
                            itemCount: cubit.list.length,
                            itemBuilder: (context, index) {
                              return BuildItemOrder(model: cubit.list[index]);
                            });
                  },
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
