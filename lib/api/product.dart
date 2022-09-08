// 搜索商品
// import 'package:Fanshop/model/product_model.dart';
import 'package:Fanshop/common/sharedPreferences.dart';
import 'package:Fanshop/service/dio.dart';
import 'package:Fanshop/utils/platform.dart';
import 'package:Fanshop/viewmodel/category/category.dart';

// 获取环境
String getEnvironment() {
  if (PlatformUtils.isProd == true) return 'production';
  return 'development';
}

class SearchProduct {
  // ignore: non_constant_identifier_names
  static Future searchProduct(String? product_name) async {
    final params = {"product_name":product_name};
    var data = await HttpController.get("api/search_product", params);
    return  Product.fromJson(data);
  }
}


class RecordProduct {
  // ignore: non_constant_identifier_names
  static Future recordProduct() async {

    var data = await HttpController.get("api/all_historys",{'id':0});
    return  data;
  }
}

class AddHistorys {
  // ignore: non_constant_identifier_names
  static Future addHistorys(String text) async {
    Map<dynamic, dynamic> userInfo =
    await SharedPreferencesUserUtils.getUserInfo("userInfo");
    var res = await HttpController.post("api/add_historys",{
      "handler": userInfo['telephone'].toString(),

      "data": text,
      "platform": getPlatform(),
      "environment": getEnvironment()
    });
    return  res;
  }
}