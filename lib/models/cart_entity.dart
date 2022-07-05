class CartEntity {
  late CartModel cartModel;

  CartEntity({required this.cartModel});
  CartEntity.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      cartModel = new CartModel.fromJson(json);
    }
  }
}

class CartModel {
  late String msg;
  late int code;
  CartModel({required this.msg, required this.code});
  CartModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'].toString();
    code = int.parse(json['code'].toString());
  }
}
