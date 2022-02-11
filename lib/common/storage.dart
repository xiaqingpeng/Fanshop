// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  //设置值
  static Future<void> setString(key, value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var result = sp.setString(key, value);
  }
 
  //获取值
  static Future<String?> getString(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    var result = sp.getString(key);
    return result;
  }

  //删除值
  static Future<void> remove(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }
  
  //清理值
  static Future<void> clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}

