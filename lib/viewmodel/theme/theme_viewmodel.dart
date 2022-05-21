import 'package:flutter/material.dart';
import 'package:Fanshop/global/global_theme.dart';

class ThemeViewmodel extends ChangeNotifier {
  int _color = 0;
  get getColor {
    return _color;
  }

  void setColor(int index) {
    if (index > themes.length - 1) return;
    _color = index;
    notifyListeners();
  }
}
