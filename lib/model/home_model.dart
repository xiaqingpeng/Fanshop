import 'package:kuangxianjiaoapp/common/storage.dart';
import 'package:kuangxianjiaoapp/service/dio.dart';
// ignore: unused_import
import 'package:kuangxianjiaoapp/utils/platform.dart';

// 获取商品分类
class FindCategory {
  Future getList() async {
    String? device = await Storage.getString('device');
    if (device == 'true') {
      return await HttpController.get("/find_category", null);
    }
    return {
      "data": [
        {
          "category_id": 4,
          "category_name": "数码家电",
          "category_img":
              "https://p4.music.126.net/tKMAm5OvR-2lAj7dnEOhsg==/18623527952924939.jpg"
        },
        {
          "category_id": 5,
          "category_name": "手机通信",
          "category_img":
              "https://p4.music.126.net/tKMAm5OvR-2lAj7dnEOhsg==/18623527952924939.jpg"
        },
        {
          "category_id": 6,
          "category_name": "美妆护肤",
          "category_img":
              "https://p4.music.126.net/tKMAm5OvR-2lAj7dnEOhsg==/18623527952924939.jpg"
        },
        {
          "category_id": 7,
          "category_name": "家具百货",
          "category_img":
              "https://p4.music.126.net/tKMAm5OvR-2lAj7dnEOhsg==/18623527952924939.jpg"
        },
        {
          "category_id": 8,
          "category_name": "食品酒饮",
          "category_img":
              "https://p4.music.126.net/tKMAm5OvR-2lAj7dnEOhsg==/18623527952924939.jpg"
        },
        {
          "category_id": 9,
          "category_name": "医药健康",
          "category_img":
              "https://p4.music.126.net/tKMAm5OvR-2lAj7dnEOhsg==/18623527952924939.jpg"
        },
        {
          "category_id": 10,
          "category_name": "服装饰品",
          "category_img":
              "https://p4.music.126.net/tKMAm5OvR-2lAj7dnEOhsg==/18623527952924939.jpg"
        },
        {
          "category_id": 11,
          "category_name": "生鲜花束",
          "category_img":
              "https://p4.music.126.net/tKMAm5OvR-2lAj7dnEOhsg==/18623527952924939.jpg"
        },
        {
          "category_id": 12,
          "category_name": "文教办公",
          "category_img":
              "https://p4.music.126.net/tKMAm5OvR-2lAj7dnEOhsg==/18623527952924939.jpg"
        },
        {
          "category_id": 13,
          "category_name": "汽摩配套",
          "category_img":
              "https://p4.music.126.net/tKMAm5OvR-2lAj7dnEOhsg==/18623527952924939.jpg"
        }
      ],
      "total": 10
    };
  }
}

// 获取商品详情
class FindProduct {
  // ignore: non_constant_identifier_names
  Future getProduct(int catagory_id) async {
    String? device = await Storage.getString('device');
    if (device == 'true') {
      return await HttpController.get(
          "/find_product", "?category_id=$catagory_id");
    }
    if (catagory_id == 0) {
      return {
        "data": [
           {
            "category_id": 6,
            "product_id": 32,
            "product_name": "迪奥",
            "market_price": 499,
            "current_price": 299,
            "product_image":
                "https://kaola-haitao.oss.kaolacdn.com/vangoghTemp202202/e3ca931b62c84d18871b2f0f92f102c7_800_800.jpg"
          },
          {
            "category_id": 6,
            "product_id": 33,
            "product_name": "兰蔻",
            "market_price": 399,
            "current_price": 199,
            "product_image":
                "https://kaola-haitao.oss.kaolacdn.com/vangoghTemp202202/79c76f6f52ef485cb1d0c368da29ee1a_800_800.jpg?x-oss-process=image/resize,w_750,h_750/quality,q_85"
          },
          {
            "category_id": 4,
            "product_id": 18,
            "product_name": "创维液晶电视",
            "market_price": 4000,
            "current_price": 3000,
            "product_image":
                "https://kaola-haitao.oss.kaolacdn.com/vangoghTemp202202/b324a82a6e3a4718a44c38d3355110ed_800_800.jpg"
          },
          {
            "category_id": 4,
            "product_id": 23,
            "product_name": "佳能打印机",
            "market_price": 690,
            "current_price": 399,
            "product_image":
                "https://kaola-pop.oss.kaolacdn.com/04d2ce59b41d43589270cb3bff3be79d_800_800.jpg"
          },
          {
            "category_id": 5,
            "product_id": 30,
            "product_name": "三星智能手机",
            "market_price": 3999,
            "current_price": 2570,
            "product_image":
                "https://kaola-haitao.oss.kaolacdn.com/vangoghTemp202202/0a75e9c5a8ca4f1ba92b9ab121ce9096_800_800.jpg"
          },
          {
            "category_id": 5,
            "product_id": 31,
            "product_name": "苹果手机",
            "market_price": 15999,
            "current_price": 9999,
            "product_image":
                "https://kaola-haitao.oss.kaolacdn.com/6f1c8e0eaed392559594b0f281f5aae2.jpg"
          },
         
          {
            "category_id": 7,
            "product_id": 34,
            "product_name": "红星美凯龙",
            "market_price": 1599,
            "current_price": 1077,
            "product_image":
                "https://kaola-haitao.oss.kaolacdn.com/vangoghTemp202202/f783e68955e24ee2b747b9f64de4e987_800_800.jpg"
          },
          {
            "category_id": 8,
            "product_id": 35,
            "product_name": "天之蓝",
            "market_price": 400,
            "current_price": 300,
            "product_image":
                "https://kaola-haitao.oss.kaolacdn.com/vangoghTemp202202/25618c0635214cf080fa261d900ffd7f_800_800.jpg"
          },
          {
            "category_id": 8,
            "product_id": 36,
            "product_name": "茅台",
            "market_price": 400,
            "current_price": 300,
            "product_image":
                "https://kaola-pop.oss.kaolacdn.com/cdc5d218-2e7c-4a20-add1-39e2b7a0070f?x-oss-process=image/resize,w_750,h_750/quality,q_85"
          }
        ],
        "total": 19
      };
    }

    return {"data": [], "total": 19};
  }
}
