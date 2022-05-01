// import 'package:kuangxianjiaoapp/common/storage.dart';
import 'package:kuangxianjiaoapp/service/dio.dart';
// ignore: unused_import
import 'package:kuangxianjiaoapp/utils/platform.dart';

// 获取商品分类
class FindCategory {
  Future getList() async {
    // String? device = await Storage.getString('device');
    return await HttpController.get("/find_category", null);
  }
}

// 获取商品详情
class FindProduct {
  // ignore: non_constant_identifier_names
  Future getProduct(int catagory_id) async {
    // String? device = await Storage.getString('device');

    return await HttpController.get(
        "/find_product", "?category_id=$catagory_id");
  }
}
