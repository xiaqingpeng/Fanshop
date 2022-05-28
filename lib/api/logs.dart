// import 'package:Fanshop/common/storage.dart';
import 'package:Fanshop/common/SharedPreferences.dart';
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
  Future addLogs(String? desc, {Map<dynamic, dynamic>? data}) async {
    Map<dynamic, dynamic> userInfo =
        await SharedPreferencesUserUtils.getUserInfo("userInfo");
    await HttpController.post("api/add_logs", {
      "handler": userInfo['telephone'].toString(),
      "desc": desc,
      "data": data,
      "platform": getPlatform(),
      "environment": getEnvironment()
    });
  }
}
