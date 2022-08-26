import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Fanshop/common/storage.dart';
import 'package:Fanshop/viewmodel/category/category.dart';

class CartViewmodel with ChangeNotifier {
  List _cartList = []; //购物车数据
  bool _isCheckAll = false; //全选
  double _allPrice = 0; //总价
  double _allCount = 0; //总数量
  double _accountCount = 0; //总数量

  List get cartList => _cartList;
  bool get isCheckAll => _isCheckAll;
  double get allPrice => _allPrice;
  double get allCount => _allCount;
  double get accountCount => _accountCount;

  // ignore: non_constant_identifier_names
  Cart() {
    init();
  }

  //初始化的时候获取购物车数据
  init() async {
    String? cartList = await Storage.getString(('cartList'));
    if (cartList != null) {
      List cartListData = json.decode(cartList);
      _cartList = cartListData;
    } else {
      _cartList = [];
    }
    updateCartList();
    notifyListeners();
  }

  updateCartList() {
    //获取全选的状态
    isCheckedAll();
    //计算总价
    computeAllPrice();
    //计算总数
    computeAllCount();
    Storage.setString('cartList', json.encode(_cartList));
  }

  // 添加商品
  setAddProduct(Product item) {
    if (_cartList.isNotEmpty) {
      for (var i = 0; i < _cartList.length; i++) {
        if (_cartList[i]['product_id'] == item.product_id) {
          _cartList[i]['current_count']++;
          Storage.setString('cartList', json.encode(_cartList));
          notifyListeners();
          return false;
        }
      }
      _cartList.add(
        {
          "product_id": item.product_id,
          "product_name": item.product_name,
          "current_price": item.current_price,
          "market_price": item.market_price,
          "current_count": 1,
          "checked": false,
          "product_image": item.product_image,
        },
      );
      Storage.setString('cartList', json.encode(_cartList));
      notifyListeners();
      return false;
    }
    if (_cartList.isEmpty) {
      _cartList.add({
        "product_id": item.product_id,
        "product_name": item.product_name,
        "current_price": item.current_price,
        "market_price": item.market_price,
        "current_count": 1,
        "checked": false,
        "product_image": item.product_image,
      });
      Storage.setString('cartList', json.encode(_cartList));
      notifyListeners();
      return false;
    }
  }

  itemCountChange(_itemData) {
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['product_id'] == _itemData['product_id']) {
        _cartList[i]['current_count'] = _itemData['current_count'];
      }
    }
    updateCartList();
    notifyListeners();
  }

  //全选 反选
  checkAll(value) {

    for (var i = 0; i < _cartList.length; i++) {
      _cartList[i]['checked'] = value;
    }
    _isCheckAll = value;
    updateCartList();
    notifyListeners();
  }

  //判断是否全选
  isCheckedAll() {


    if (_cartList.every((element) => element['checked'])) {
      _isCheckAll = true;
    } else {
      _isCheckAll = false;
    }
  }

  //监听每一项的选中事件
  itemChage(_itemData) {
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['product_id'] == _itemData['product_id']) {
        _cartList[i]['checked'] = _itemData['checked'];
      }
    }
    updateCartList();
    notifyListeners();
  }

  //计算总价
  computeAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['checked'] == true) {
        tempAllPrice +=
            _cartList[i]['current_price'] * _cartList[i]['current_count'];
      }
    }

    _allPrice = tempAllPrice;
    notifyListeners();
  }

  //计算结算总数和购物车中商品总数量
  computeAllCount() {
    double tempAllCount = 0;
    double tempAccountCount = 0;
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['checked'] == true) {
        tempAccountCount += _cartList[i]['current_count'];
      }
      tempAllCount += _cartList[i]['current_count'];
    }
    _allCount = tempAllCount; // 购物车中商品总量
    _accountCount = tempAccountCount; // 购物车中结算商品总量
    notifyListeners();
  }

  //删除数据
  removeItem() {
    List tempList = [];
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]['checked'] == false) {
        tempList.add(_cartList[i]);
      }
    }
    _cartList = tempList;
    updateCartList();
    notifyListeners();
  }
}
