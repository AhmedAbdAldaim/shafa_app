import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_cubit.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_state.dart';
import 'package:medical_app/dependency_injection.dart' as di;
import '../../data_layer/models/medicine_model.dart';

class BuildBottomSheet extends StatelessWidget {
  Medicine model;
  var cubit = di.sl<MedicineCubit>();
  BuildBottomSheet({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      cubit.checkifAddedFun(model.id);
      cubit.amount = 1;

      print(cubit.checkIdisAdd);
      print("--");
      print(model.id);
      return BlocBuilder<MedicineCubit, MedicineState>(
        builder: (context, state) {
          // String v =  cubit.getamount(model.id).toString();
          // print(v+"dddd");
          // cubit.checkifAdded(model.id);
          // cubit.getamount(model.id);
          return Container(
            height: AppMediaQuery.height(context: context) / 2,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [BoxShadow(blurRadius: 2)],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      AppMediaQuery.width(context: context) * 0.1),
                  topRight: Radius.circular(
                      AppMediaQuery.width(context: context) * 0.1),
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppMediaQuery.width(context: context) * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.clear,
                              color: Colors.red,
                              size:
                                  AppMediaQuery.height(context: context) * 0.04,
                            ))),
                    buildtitle(title: 'اسم الدواء :', context: context),
                    buildcontent(content: model.name, context: context),
                    buildtitle(title: 'اسم الشركة المصنعة :', context: context),
                    buildcontent(content: model.company, context: context),
                    buildtitle(title: 'اسم الصيدلية  :', context: context),
                    buildcontent(content: model.pharma.name, context: context),
                    buildtitle(title: 'موقع الصيدلية  :', context: context),
                    buildcontent(
                        content: model.pharma.addres, context: context),
                    buildtitle(title: 'السعر :', context: context),
                    buildcontent(content: model.price, context: context),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      IconButton(
                          onPressed: () => cubit.addAmount(),
                          icon: CircleAvatar(
                              child: Icon(
                            Icons.add,
                            size: AppMediaQuery.height(context: context) * 0.03,
                          ))),
                      Text(
                        cubit.amount.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              AppMediaQuery.width(context: context) * 0.03,
                        ),
                      ),
                      IconButton(
                          onPressed: () => cubit.clearAmount(),
                          icon: CircleAvatar(
                              child: Icon(
                            Icons.remove,
                            size: AppMediaQuery.height(context: context) * 0.03,
                          ))),
                    ]),
                    Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child:cubit.getAllBsketProducts.isNotEmpty && cubit.checkIdisAdd != null &&
                                cubit.checkIdisAdd == model.id
                            ? Stack(
                                alignment: AlignmentDirectional.topStart,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.bagShopping,
                                    color: Colors.green.shade900,
                                  ),
                                  const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            : IconButton(
                                onPressed: () {
                                  AudioPlayer()
                                      .play(
                                          AssetSource('sounds/add_to_cart.mp3'))
                                      .then((value) {
                                    cubit.addToCartFun(
                                      id: model.id,
                                      name: model.name,
                                      price: int.parse(model.price),
                                    );
                                    Navigator.of(context).pop();
                                  });
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.cartPlus,
                                  color: Colors.Mycolor,
                                )))
                 
                 
                  ],
                ),
            
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildtitle({required String title, required BuildContext context}) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: AppMediaQuery.width(context: context) * 0.04,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildcontent(
      {required String content, required BuildContext context}) {
    return Text(
      content,
      style: TextStyle(
        color: Colors.black,
        fontSize: AppMediaQuery.width(context: context) * 0.03,
      ),
    );
  }
}
