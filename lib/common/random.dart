 

 import 'dart:math';
 import 'package:flutter/material.dart';
// 获取随机数
String getRandom(int len) {
    String scopeF = '123456789'; //首位
    String scopeC = '0123456789'; //中间
    String result = '';
    for (int i = 0; i < len; i++) {
      if (i == 0) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    return result;
}



// 获取随机颜色
 Color getRandomColor({int r = 255, int g = 255, int b = 255, a = 255}) {
   if (r == 0 || g == 0 || b == 0) return Colors.black;
   if (a == 0) return Colors.white;
   return Color.fromARGB(
     a,
     r != 255 ? r : Random.secure().nextInt(r),
     g != 255 ? g : Random.secure().nextInt(g),
     b != 255 ? b : Random.secure().nextInt(b),
   );
 }