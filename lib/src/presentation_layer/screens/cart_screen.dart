import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:medical_app/src/config/app_routes.dart';
import 'package:medical_app/src/cores/components/components.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:medical_app/src/data_layer/models/set_order.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_cubit.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_state.dart';
import 'package:medical_app/dependency_injection.dart' as di;
import 'package:medical_app/src/presentation_layer/widgets/build_item_cart.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  var cubit = di.sl<MedicineCubit>();

  final value = intl.NumberFormat("#,##0.00", "ar");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicineCubit, MedicineState>(
      listener: (context, state) {
        if (state is SetOrderSuccess) {
          cubit.deleteAllProducts();
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.homeScreen, (route) => false);

          defaultSnakbar(
              color: Colors.green, content: "تم الطلب بنجاح", context: context);
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: AppBar(
                title: const Text('السلة'),
                centerTitle: true,
              ),
              body: Padding(
                padding: EdgeInsets.all(
                    AppMediaQuery.width(context: context) * 0.05),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('الطلبات',
                              style: TextStyle(
                                  fontSize:
                                      AppMediaQuery.width(context: context) *
                                          0.04)),
                          Text(' | ${cubit.countTable}'),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                cubit.deleteAllProducts();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: AppMediaQuery.height(context: context) * 0.02,
                      ),
                      Expanded(
                          child: cubit.getAllBsketProducts.isEmpty
                              ? Center(child: Text('السلة خالية'))
                              : ConditionalBuilder(
                                  condition:
                                      cubit.getAllBsketProducts.isNotEmpty,
                                  builder: (context) {
                                    return ListView.separated(
                                        itemCount:
                                            cubit.getAllBsketProducts.length,
                                        itemBuilder: (context, index) {
                                          return BuildItemCart(
                                              model: cubit
                                                  .getAllBsketProducts[index]);
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                SizedBox(
                                                  height: AppMediaQuery.height(
                                                          context: context) *
                                                      0.02,
                                                ));
                                  },
                                  fallback: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ))),
                      SizedBox(
                        height: AppMediaQuery.height(context: context) * 0.02,
                      ),
                      Text('الملخص',
                          style: TextStyle(
                              fontSize: AppMediaQuery.width(context: context) *
                                  0.04)),
                      SizedBox(
                        height: AppMediaQuery.height(context: context) * 0.02,
                      ),
                      Row(
                        children: [
                          Text('المجموع الكلي',
                              style: TextStyle(
                                  fontSize:
                                      AppMediaQuery.width(context: context) *
                                          0.03,
                                  fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text(value.format(cubit.totalPrice).replaceAll('.00', ''),
                              style: TextStyle(
                                  fontSize:
                                      AppMediaQuery.width(context: context) *
                                          0.03,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        height: AppMediaQuery.height(context: context) * 0.02,
                      ),
                      state is SetOrderLoading
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              width: AppMediaQuery.width(context: context),
                              child: ElevatedButton(
                                  onPressed: () {
                                    for (var element
                                        in cubit.getAllBsketProducts) {
                                      SetOrderModel setOrderModel =
                                          SetOrderModel(
                                              ordermodel: OrderModel(
                                                  medicineId:
                                                      element['id'].toString(),
                                                  amount: element['amount']
                                                      .toString()));

                                      cubit.sendOrders(
                                          body: setOrderModel.ordermodel!
                                              .toMap());
                                    }
                                  },
                                  child: Text('موافق',
                                      style: TextStyle(
                                          fontSize: AppMediaQuery.width(
                                                  context: context) *
                                              0.03))))
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
