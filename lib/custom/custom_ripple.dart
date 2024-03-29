
import 'package:flutter/material.dart';
/// @class : Ripple
/// @date : 2021/9/3
/// @name : jhf
/// @description :点击波纹效果Widget
class CustomRipple extends StatelessWidget{

  ///点击事件
  GestureTapCallback? onTap;
  ///圆角大小
  double circular;
  ///widget
  Widget child;

  CustomRipple({
    Key? key ,
    this.onTap,
    this.circular = 0,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(circular),
      ),
      onTap: onTap,
      splashColor: Theme.of(context).splashColor,
      highlightColor: Theme.of(context).highlightColor,
      child: child,
    );
  }


}