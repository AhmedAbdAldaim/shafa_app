import 'package:flutter/material.dart';
import 'package:medical_app/src/presentation_layer/screens/cart_screen.dart';
import 'package:medical_app/src/presentation_layer/screens/edit_profile_screen.dart';
import 'package:medical_app/src/presentation_layer/screens/get_all_orders.dart';
import 'package:medical_app/src/presentation_layer/screens/home_screen.dart';
import 'package:medical_app/src/presentation_layer/screens/login_screen.dart';
import 'package:medical_app/src/presentation_layer/screens/register_screen.dart';
import 'package:medical_app/src/presentation_layer/screens/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String homeScreen = '/homeScreen';
  static const String cartScreen = "/cartScreen";
  static const String editProfileScreen = "/editProfileScreen";
  static const String getAllOrdersScreen = "/getAllOrdersScreen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case cartScreen:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case getAllOrdersScreen:
        return MaterialPageRoute(builder: (_) => GetAllOrdersScreen());
      case editProfileScreen:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
