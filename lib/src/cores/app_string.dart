import 'package:medical_app/src/cores/errors/failure.dart';

class AppString {
  //dataSourse "http://192.168.119.50:8000/api/v1/";
  static const String baseUel = "http://192.168.133.50:8000/api/v1/";
  static const String register = "register";
  static const String login = "login";
  static const String medicine = "medicine";
  static const String order = "order";
  static const String profile = "profile";

  //Failure
  static const String errorServer = "هناك خطأ في الإتصال بالخادم";
  static String getMeassgse(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'هناك خطأ في الإتصال بالخادم';
      case EmptyCacheFailure:
        return 'لا توجد اي بيانات';
      case OfflineFailure:
        return 'هناك خطأ في الإتصال بالإنترنت';
      default:
        return 'هناك خطا حدث';
    }
  }
}
