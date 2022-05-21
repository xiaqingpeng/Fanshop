// import 'package:Fanshop/common/storage.dart';
import 'package:Fanshop/service/dio.dart';
// ignore: unused_import
import 'package:Fanshop/utils/platform.dart';

// 获取商品分类
class FindCategory {
  Future getList() async {
    print('getList');
    // String? device = await Storage.getString('device');
    final data = await HttpController.get(
        "api/find_category", {"limit": 10, "offset": 1});
    return data;
  }
}

// 获取商品详情
class FindProduct {
  // ignore: non_constant_identifier_names
  Future getProduct(int? catagory_id) async {
    print(catagory_id.toString() + 'catagory_id');
    // String? device = await Storage.getString('device');
    final params = catagory_id != 0
        ? {"limit": 10, "offset": 1, "id": catagory_id}
        : {"limit": 10, "offset": 1};
    return await HttpController.get("api/find_product", params);
  }
}
