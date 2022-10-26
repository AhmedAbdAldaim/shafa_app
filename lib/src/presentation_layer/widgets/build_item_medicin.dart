import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:medical_app/src/data_layer/models/medicine_model.dart';
import 'package:medical_app/src/presentation_layer/widgets/build_item_detailes_bottomsheet.dart';
import 'package:medical_app/dependency_injection.dart' as di;
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_cubit.dart';

class BuildItemMedicine extends StatelessWidget {
  Medicine? model;
  var cubit = di.sl<MedicineCubit>();
  BuildItemMedicine({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return model == null
        ? Center(child: CircularProgressIndicator())
        : InkWell(
            onTap: () {
              showBottomSheet(
                  context: context,
                  builder: (context) {
                    return BuildBottomSheet(
                      model: model!,
                    );
                  });
            },
            child: Card(
              child: Container(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Builder(builder: (context) {
                      return Column(
                        children: [
                          
                          Container(
                            child: Image.asset(
                              'assets/images/medicine_img.png',
                              height: constraints.maxHeight * 0.6,
                            ),
                          ),
                          Container(
                              alignment: AlignmentDirectional.center,
                              height: constraints.maxHeight * 0.2,
                              child: Text(
                                model!.name,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.Mycolor,
                                    fontSize:
                                        AppMediaQuery.width(context: context) *
                                            0.03,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              )),
                          Container(
                              height: constraints.maxHeight * 0.2,
                              child: Text(
                                model!.price,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize:
                                        AppMediaQuery.width(context: context) *
                                            0.03,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              )),
                         
                          
                        ],
                      );
                    });
                  },
                ),
              ),
            ),
          );
  }
}
