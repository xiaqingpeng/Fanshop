import 'cart_goods_query_entity.dart';

class OrderEntity {
 late List<OrderModel>   orderModel;
  OrderEntity({required this.orderModel});

  OrderEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      orderModel = <OrderModel>[];
      (json['data']['records'] as List).forEach((v) {
        orderModel.add(new OrderModel.fromJson(v));
      });

    }
  }
}
class OrderModel {

late  String orderSn;
late  int realPrice;
late  int totalPrice;
 late String statusName;
 late int status;
 late List<GoodsListModel> goods;
  OrderModel({required this.orderSn, required this.realPrice,required this.totalPrice,required this.statusName,
    required this.status,required this.goods});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderSn = json['orderSn'];
    realPrice = json['realPrice'];
    totalPrice = json['totalPrice'];
    statusName = json['statusName'];
    status =json['status'];
    goods=<GoodsListModel>[];
    (json['items'] as List).forEach((v) {
      goods.add(new GoodsListModel.fromJson(v));
    });

  }

}
