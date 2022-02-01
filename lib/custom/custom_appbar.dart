import 'package:flutter/material.dart';
// ignore: non_constant_identifier_names
AppBar CustomAppbar(String title, Color backgroundColor,
    {leading,double elevation = 4.0, bool centerTitle = true}) {
  return AppBar(
    title: Text(title),
    elevation: elevation, // 阴影 默认4.0
    backgroundColor: backgroundColor,
    centerTitle: centerTitle,
    leading: leading,
  );
}

