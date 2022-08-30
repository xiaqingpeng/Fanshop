// import 'package:Fanshop/common/storage.dart';
import 'dart:convert';

import 'package:Fanshop/model/orders_model.dart';
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

// 获取商品分类
class GetOrder {
  static Future getOrder({required String user_id, String? status}) async {
    Map<String, dynamic> params = status == null
        ? {
            "user_id": user_id,
          }
        : {
            "user_id": user_id,
            "status": status,
          };
    var data = await HttpController.get("api/order/detail", params);

    List<dynamic> orderData = data['data']
        .map(
          (dynamic item) => Order.fromJson(item),
        )
        .toList();
    return orderData;
  }
}
