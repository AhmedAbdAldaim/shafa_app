import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/src/config/app_routes.dart';
import 'package:medical_app/src/cores/components/components.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:medical_app/src/data_layer/data_sourse/local/sharedprefrencese_helper.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_cubit.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_state.dart';
import 'package:medical_app/dependency_injection.dart' as di;
import 'package:medical_app/src/presentation_layer/widgets/build_item_medicin.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  var cubit = di.sl<MedicineCubit>();
  var shared = di.sl<SharedPrefrencesHelper>();
  var searchcontrollrt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<MedicineCubit, MedicineState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('شفاء'),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.cartScreen);
                      },
                      icon: Stack(
                        children: [
                          const FaIcon(FontAwesomeIcons.cartShopping),
                          CircleAvatar(
                              radius:
                                  AppMediaQuery.width(context: context) * 0.02,
                              backgroundColor: Colors.red,
                              child: FittedBox(
                                  child: Text(
                                cubit.countTable.toString(),
                                style: TextStyle(
                                    fontSize:
                                        AppMediaQuery.width(context: context) *
                                            0.03,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ))),
                        ],
                      ))
                ],
              ),
              drawer: Drawer(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                        accountName: Text(shared.getData(key: 'name')),
                        accountEmail:  Text(shared.getData(key: 'email'))),
                    defaultListTitle(
                      title: const Text('تعديل الملف الشخصي'),
                      leading: const Icon(Icons.person),
                      onTap: ()=> Navigator.of(context).pushNamed(AppRoutes.editProfileScreen)
                      ),
                       defaultListTitle(
                      title: const Text('الطلبات السابقة'),
                      leading: const Icon(Icons.book),
                      onTap: ()=> Navigator.of(context).pushNamed(AppRoutes.getAllOrdersScreen)
                      ),
                       defaultListTitle(
                      title: const Text('تسجيل خروج'),
                      leading: const Icon(Icons.logout),
                      onTap: ()=> shared.clearData().then((value) => Navigator.of(context).restorablePushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false)
                ))],
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(
                    AppMediaQuery.width(context: context) * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الأدوية',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: AppMediaQuery.width(context: context) * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(
                      height: AppMediaQuery.height(context: context) * 0.01,
                    ),
                   
                     defaultSearch(onChange: (val)=>cubit.searchMedicine(value: val),
                     
                      hint: 'بحث', 
                      type: TextInputType.name,
                      action: TextInputAction.done, 
                      controller: searchcontrollrt),
                    SizedBox(
                      height: AppMediaQuery.height(context: context) * 0.01,
                    ),
                    Expanded(
                      child:  ConditionalBuilder(
                        condition: cubit.model!= null,
                        builder: (context) {
                          return cubit.model!.filtermedicine!.isEmpty 
                              ? const Center(child: Text("لا توجد ادوية ."))
                              :  GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: AppMediaQuery.width(
                                                  context: context) *
                                              0.04,
                                          crossAxisSpacing: AppMediaQuery.width(
                                                  context: context) *
                                              0.04,
                                          childAspectRatio: AppMediaQuery.width(
                                                  context: context) /
                                              AppMediaQuery.height(
                                                  context: context) /
                                              0.6,
                                          crossAxisCount: 2),
                                  itemCount:cubit.model!.filtermedicine!.length,
                                  itemBuilder: (context, index) {
                                    return BuildItemMedicine(
                                        model:cubit.model!.filtermedicine![index]);
                                  });
                        },
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
