import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_cubit.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_state.dart';
import 'package:medical_app/dependency_injection.dart' as di;

class BuildItemCart extends StatelessWidget {
  var model;
  var cubit = di.sl<MedicineCubit>();
  BuildItemCart({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicineCubit, MedicineState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: AppMediaQuery.height(context: context) * 0.1,
          width: AppMediaQuery.width(context: context),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(
                  AppMediaQuery.width(context: context) * 0.02)),
          child: Padding(
            padding:
                EdgeInsets.all(AppMediaQuery.width(context: context) * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model['name'],
                          maxLines: 1,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize:
                                  AppMediaQuery.width(context: context) * 0.04),
                        ),
                        Text(
                          model['price'].toString(),
                          maxLines: 1,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize:
                                  AppMediaQuery.width(context: context) * 0.03),
                        ),
                      ],
                    )),

                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            cubit.incrementupdateAmount(
                                id: model['id'], amount: model['amount'] + 1);
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.Mycolor,
                            size: AppMediaQuery.width(context: context) * 0.06,
                          )),
                      Text(model['amount'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: AppMediaQuery.width(context: context) *
                                  0.05)),
                      IconButton(
                          onPressed: () {
                            cubit.incrementupdateAmount(
                                id: model['id'], amount: model['amount']>1? model['amount'] - 1 : model['amount']);
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.Mycolor,
                            size: AppMediaQuery.width(context: context) * 0.06,
                          ))
                    ],
                  ),
                ),

                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          cubit.deleteItemProducts(id: model['id']);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )))

                // Expanded(
                //     flex: 1,
                //     child: Text(model['amount'].toString(),
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             fontSize: AppMediaQuery.width(context: context) * 0.05))),
                // Expanded(
                //   flex: 2,
                //   child: IconButton(
                //       onPressed: () {},
                //       icon: Icon(
                //         Icons.remove_circle,
                //         color: Colors.Mycolor,
                //         size: AppMediaQuery.width(context: context) * 0.06,
                //       )),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
