import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesHelper {
  final SharedPreferences sharedprefrences;
  SharedPrefrencesHelper({required this.sharedprefrences});

  //putdata
  Future<bool> setData({required String key, required dynamic value}) async {
    if (value is String) return await sharedprefrences.setString(key, value);
    if (value is int) return await sharedprefrences.setInt(key, value);
    if (value is bool) return await sharedprefrences.setBool(key, value);
    return await sharedprefrences.setDouble(key, value);
  }

  //getData
  dynamic getData({required String key}) {
    return sharedprefrences.get(key);
  }

  //clearData
  Future<bool> clearData() async {
    return await sharedprefrences.clear();
  }
}
