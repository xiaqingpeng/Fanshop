// import 'package:Fanshop/common/storage.dart';
import 'package:Fanshop/service/dio.dart';
// ignore: unused_import
import 'package:Fanshop/utils/platform.dart';



// 获取环境
String getEnvironment() {
  if (PlatformUtils.isProd == true) return 'production';
  return 'development';
}

// 添加用户
class AddOrder {
 static Future addOrder(String userId, List? data) async {
    await HttpController.post("api/order/add", {
      "user_id": userId,
      "data": data,
      "platform": getPlatform(),
    });
  }
}
