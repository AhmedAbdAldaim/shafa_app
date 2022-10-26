import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/src/config/app_routes.dart';
import 'package:medical_app/src/config/app_theme.dart';
import 'package:medical_app/src/cores/observer.dart';
import 'package:medical_app/src/domin_layer/editprofile_cubit/editprofile_cubit.dart';
import 'package:medical_app/src/domin_layer/medicine_cubit/medicine_cubit.dart';
import 'package:medical_app/src/domin_layer/registeration_cubit/register_cubit.dart';
import 'dependency_injection.dart' as di;
import 'src/domin_layer/get_all_orders_cubit/get_all_orders_cubit.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.Mycolor,
      systemNavigationBarColor: Colors.Mycolor,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> di.sl<MedicineCubit>()..getAllMedicineFun()..createDb()),
        BlocProvider(create: (context)=> di.sl<GetAllOrdersCubit>()),
         BlocProvider(create: (context)=> di.sl<EditProfileCubit>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ligthTheme,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
