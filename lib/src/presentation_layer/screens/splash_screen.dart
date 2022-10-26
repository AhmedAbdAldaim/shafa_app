import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:medical_app/src/config/app_routes.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:medical_app/dependency_injection.dart' as di;
import 'package:medical_app/src/data_layer/data_sourse/local/sharedprefrencese_helper.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  final String? token = di.sl<SharedPrefrencesHelper>().getData(key: 'token');
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((Duraton) {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
         token!=null?AppRoutes.homeScreen: AppRoutes.loginScreen, (route) => false);
      });
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              width: MediaQuery.of(context).size.width * 0.40,
            ),
            SizedBox(
              height: AppMediaQuery.height(context: context) * 0.03,
            ),
            Text(
              'شفاء',
              style: TextStyle(
                  fontSize: AppMediaQuery.width(context: context) * 0.04,
                  fontWeight: FontWeight.bold),
            )
          ],
        )),
      ),
    );
  }
}
