import 'package:LinJia/models/goods_entity.dart';

class HotEntity {
  late List<GoodsModel> goods;
  HotEntity({required this.goods});
  HotEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      goods = <GoodsModel>[];
//			print(goods.runtimeType);
      List<Map> dataList = (json['data'] as List).cast();
      dataList.forEach((v) {
        goods.add(new GoodsModel.fromJson(v as Map<String,dynamic>));
//				print(goods.length);
      });
    }
  }
}
