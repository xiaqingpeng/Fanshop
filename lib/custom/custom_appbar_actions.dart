
import 'package:flutter/material.dart';
// ignore: non_constant_identifier_names
AppBar CustomAppbarActions(
    String? title, Color backgroundColor, List<Widget> actions,
    {content,double elevation = 4.0, bool centerTitle = true}) {
  return AppBar(
    title: content??Text(title!),
    elevation: elevation, // 阴影 默认4.0
    backgroundColor: backgroundColor,
    centerTitle: centerTitle,
    actions: actions,
  );
}
