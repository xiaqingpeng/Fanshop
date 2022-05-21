import 'package:flutter/material.dart';
import 'package:Fanshop/view/checkout/checkout.dart';
// ignore: duplicate_import
import 'package:Fanshop/view/checkout/checkout.dart';

class CheckOutViewmodel with ChangeNotifier {
  List _checkOutListData = []; //购物车数据
  List get checkOutListData => _checkOutListData;
  double _allPrice = 0; //总价
  double get allPrice => _allPrice;
  changeCheckOutListData(data, context) {
    _checkOutListData = data;
    // 2、跳转确认订单页面
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const CheckOut();
        },
      ),
    );
    computeAllPrice();
    notifyListeners();
  }

  //计算总价
  computeAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < _checkOutListData.length; i++) {
      tempAllPrice += _checkOutListData[i]['current_price'] *
          _checkOutListData[i]['current_count'];
    }
    _allPrice = tempAllPrice;
    notifyListeners();
  }
}
