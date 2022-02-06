import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/model/category_model.dart';

class Category {
  // ignore: non_constant_identifier_names
  late final int category_id;
  // ignore: non_constant_identifier_names
  late final String category_name;

  Category({
    // ignore: non_constant_identifier_names
    required this.category_id,
    // ignore: non_constant_identifier_names
    required this.category_name,
  });
  static List<Category> fromJson(Map json) {
    // ignore: avoid_print

    List<Category> _category = [];

    // JsonDecoder decoder = const JsonDecoder();
    // var mapData = decoder.convert(json);
    var mapData = json['data'];

    mapData.forEach((obj) {
      Category categorys = Category(
        category_id: obj['category_id'],
        category_name: obj['category_name'],
      );
      _category.add(categorys);
    });
    return _category;
  }
}

class Product {
  // ignore: non_constant_identifier_names
  late final int category_id;
  // ignore: non_constant_identifier_names
  late final String product_image;
  // ignore: non_constant_identifier_names
  late final int current_price;
  // ignore: non_constant_identifier_names
  late final int market_price;
  // ignore: non_constant_identifier_names
  late final String product_name;
  // ignore: non_constant_identifier_names
  late final int product_id;

  Product({
    // ignore: non_constant_identifier_names
    required this.category_id,
    // ignore: non_constant_identifier_names
    required this.current_price,
    // ignore: non_constant_category_identifier_names, non_constant_identifier_names
    required this.market_price,
    // ignore: non_constant_identifier_names
    required this.product_image,
    // ignore: non_constant_category_identifier_names, non_constant_identifier_names
    required this.product_name,
    // ignore: non_constant_identifier_names
    required this.product_id,
    // ignore: non_constant_identifier_names
  
  });
  static List<Product> fromJson(Map json) {
    List<Product> _product = [];
    var mapData = json['data'];
    mapData.forEach(
      (obj) {
        Product products = Product(
          category_id: obj['category_id'],
          current_price: obj['current_price'],
          market_price: obj['market_price'],
          product_image: obj['product_image'],
          product_name: obj['product_name'],
          product_id: obj['product_id'],
        );
        _product.add(products);
      },
    );
    return _product;
  }
}

class CategoryViewmodel extends ChangeNotifier {
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
