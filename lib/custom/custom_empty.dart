// 自定义按钮封装
import 'package:flutter/material.dart';

enum NavigatorBarCloseType { close, back }

// 自定义导航封装
class CustomEmpty extends StatelessWidget {
  const CustomEmpty({
    Key? key,
    this.radius,
    this.title,
    this.icon,
  }) : super(
          key: key,
        );
  final String? title;
  final Widget? icon;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: radius ?? 50,
            backgroundColor: Colors.grey[200],
            child: icon ??
                const Icon(
                  Icons.shopping_cart,
                  size: 40.0,
                  color: Colors.white,
                ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(title ?? '暂无数据'),
        ],
      ),
    );
  }
}
