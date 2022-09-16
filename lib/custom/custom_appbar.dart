import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: non_constant_identifier_names
AppBar CustomAppbar(String? title, Color backgroundColor,
    {content, leading, double elevation = 4.0, bool centerTitle = true}) {
  return AppBar(
    title: content ?? Text(title!),
    elevation: elevation, // 阴影 默认4.0
    backgroundColor: backgroundColor,
    centerTitle: centerTitle,
    leading: leading, 
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
