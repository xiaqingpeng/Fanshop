
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize{
  static void init(BuildContext context){
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
  }

  static double height(double value){
    return ScreenUtil.getInstance().setHeight(value).toDouble();
  }

  static double width(double value){
    return ScreenUtil.getInstance().setWidth(value).toDouble();
  }

  static double sp(double value){
    return ScreenUtil.getInstance().setSp(value).toDouble();
  }


}


