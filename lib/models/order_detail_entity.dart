import 'cart_goods_query_entity.dart';

class OrderDetailEntry {
 late OrderDetailModel orderDetailModel;
  OrderDetailEntry({required this.orderDetailModel});

  OrderDetailEntry.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      orderDetailModel= new OrderDetailModel.fromJson(json['data']);
    }
  }
}
class OrderDetailModel {
 late String orderSn;
 late int realPrice;
 late int totalPrice;
  late String addressDetail;
 late String areaCode;
 late String city;
 late String district;
 late String name;
 late String tel;
 late int status;
 late String statusName;
 late String province;
 late String createTime;
 late List<GoodsListModel> goods;
  OrderDetailModel({required this.orderSn, required this.realPrice,required this.totalPrice,required this.statusName,
  required this.status,required this.goods});
  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    orderSn = json['orderSn'];
    realPrice = json['realPrice'];
    totalPrice = json['totalPrice'];
    statusName = json['statusName'];
    status =json['status'];
    addressDetail =json['address']['addressDetail'];
    areaCode =json['address']['areaCode'];
    city =json['address']['city'];
    district =json['address']['district'];
    name =json['address']['name'];
    tel =json['address']['tel'];
    province =json['address']['province'];
    status =json['status'];
    createTime =json['createTime'];
    goods=<GoodsListModel>[];
    List<Map> dataList= (json['items'] as List).cast();
    dataList.forEach((v) {
      goods.add(GoodsListModel.fromJson(v as Map<String,dynamic>));
    });

  }

}
