import 'package:flutter/material.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:medical_app/src/data_layer/models/get_orders.dart';

class BuildItemOrder extends StatelessWidget {
  OrderModel model;
  BuildItemOrder({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildtitle(title: 'اسم الدواء :', context: context),
            buildcontent(content: model.medicineOrderModel.name, context: context),
            buildtitle(title: 'اسم الشركة المصنعة :', context: context),
            buildcontent(content: model.medicineOrderModel.company, context: context),
            buildtitle(title: 'تاريخ الصلاحية :', context: context),
            buildcontent(content: model.medicineOrderModel.expaireDate, context: context),
            buildtitle(title: 'الكمية :', context: context),
            buildcontent(content: model.amount, context: context),
            buildtitle(title: 'السعر :', context: context),
            buildcontent(content: model.medicineOrderModel.price, context: context),
           ],
        ),
      ),
    );
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
      maxLines: 2,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Colors.black,
        fontSize: AppMediaQuery.width(context: context) * 0.03,
      ),
    );
  }
}
