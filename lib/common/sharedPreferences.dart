// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences 工具类
class SharedPreferencesUserUtils {
  // 保存数据
  static Future setUserInfo(String key, Map value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, const JsonEncoder().convert(value));
  }

  // 获取数据
  static Future getUserInfo(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String str=sp.getString(key)??const JsonEncoder().convert({});
    return const JsonDecoder().convert(str);
  }

  // 清除数据
  static Future deleteUserInfo(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }
}

class SharedPreferencesThemeUtils {
  // 保存数据
  static Future setThemeInfo(String key, int value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(key, value);
  }

  // 获取数据
  static Future getThemeInfo(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }

  // 清除数据
  static Future deleteThemeInfo(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }
}
