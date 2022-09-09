// import 'package:Fanshop/common/storage.dart';
import 'package:Fanshop/common/SharedPreferences.dart';
import 'package:Fanshop/model/logs_model.dart';
import 'package:Fanshop/service/dio.dart';
// ignore: unused_import
import 'package:Fanshop/utils/platform.dart';

// 获取环境
String getEnvironment() {
  if (PlatformUtils.isProd == true) return 'production';
  return 'development';
}

// 获取商品分类
class AddLogs {
  Future addLogs(String? path, String? desc,
      {Map<dynamic, dynamic>? data}) async {
    Map<dynamic, dynamic> userInfo =
        await SharedPreferencesUserUtils.getUserInfo("userInfo");
    await HttpController.post("api/add_logs", {
      "handler": userInfo['telephone'].toString(),
      "path": path,
      "desc": desc,
      "data": data,
      "platform": getPlatform(),
      "environment": getEnvironment()
    });
  }
}

// 获取商品分类
class GetAllLogs {
  static Future getAllLogs({required int limit, required int offset}) async {
     Map<dynamic, dynamic> userInfo =
        await SharedPreferencesUserUtils.getUserInfo("userInfo");
    var data = await HttpController.get("api/logs/all_logs", {
      "limit": limit,
      "offset": offset,
      "handler": userInfo['telephone'].toString(),
    });
    // print(data);
    return Log.fromJson(data);
  }
}

// 获取商品分类
class GetInfoLogs {
  static Future getInfoLogs(
      {required String menuTime,
      required String platform}) async {
    Map<dynamic, dynamic> userInfo =
    await SharedPreferencesUserUtils.getUserInfo("userInfo");
    var data = await HttpController.get("api/logs/info", {
      "_start": menuTime,
      "handler": userInfo['telephone'].toString(),
      "platform": platform,
    });
    return data["data"]['data'];
  }
}
