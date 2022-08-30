// To parse this JSON data, do
//
//     final Order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String OrderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.userId,
    required this.data,
    required this.platform,
    required this.v,
  });

  String id;
  String status;
  DateTime createdAt;
  String userId;
  List<Data> data;
  String platform;
  int v;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    userId: json["user_id"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    platform: json["platform"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "user_id": userId,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "platform": platform,
    "__v": v,
  };
}

class Data {
  Data({
    required this.productId,
    required this.productName,
    required this.currentPrice,
    required this.marketPrice,
    required this.currentCount,
    required this.checked,
    required this.productImage,
  });

  int productId;
  String productName;
  int currentPrice;
  int marketPrice;
  int currentCount;
  bool checked;
  String productImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productId: json["product_id"],
    productName: json["product_name"],
    currentPrice: json["current_price"],
    marketPrice: json["market_price"],
    currentCount: json["current_count"],
    checked: json["checked"],
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "current_price": currentPrice,
    "market_price": marketPrice,
    "current_count": currentCount,
    "checked": checked,
    "product_image": productImage,
  };
}
