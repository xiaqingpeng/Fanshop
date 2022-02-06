import '../service/dio.dart';

// 获取商品分类
class FindCategory {
  Future getList() async {
    return await HttpController.get("/find_category", null);
   
  }
}

// 获取商品详情
class FindProduct {
  // ignore: non_constant_identifier_names
  Future getProduct(int catagory_id) async {
    return await HttpController.get(
        "/find_product", "?category_id=$catagory_id");
  }
}
