import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Fanshop/model/home_model.dart';
import 'package:Fanshop/viewmodel/category/category.dart';

class HomeViewmodel extends ChangeNotifier {
  List<Product> _products = [];
  get getProducts {
    return _products;
  }

  void setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  getProduct(int catagory_id) async {
    final FindProduct _model = FindProduct();
    var products = await _model.getProduct(catagory_id);
    setProducts(Product.fromJson(products));
    return Product.fromJson(products);
  }

  List<Category> _categorys = [];
  get getCategorys {
    return _categorys;
  }

  void setCategorys(List<Category> categorys) {
    _categorys = categorys;
    notifyListeners();
  }

  getCategory() async {
    final FindCategory _model = FindCategory();
    var categorys = await _model.getList();
    setCategorys(Category.fromJson(categorys));
    return Category.fromJson(categorys);
  }
}
