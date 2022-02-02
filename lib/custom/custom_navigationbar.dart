import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum NavigatorBarCloseType { close, back }

// 自定义导航封装
class CustomNavigatorBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomNavigatorBar({
    Key? key,
    this.height = 55.0,
    this.fromHeight = 55.0,
    this.title,
    this.navigatorBarCloseType = NavigatorBarCloseType.close,
    this.bgColor = Colors.red,
    this.baseColor = Colors.white,
    this.closeCallBack,
  }) : super(
          key: key,
        );
  final NavigatorBarCloseType? navigatorBarCloseType;
  final double? height;
  final double? fromHeight;
  final Color? bgColor;
  final Color? baseColor;
  final String? title;
  final Function? closeCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Get.context!.mediaQueryPadding.top),// getx获取状态栏的高度
      color: bgColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: Container(
              width: 100,
              alignment: Alignment.center,
              child: TextButton(
                child: navigatorBarCloseType == NavigatorBarCloseType.close
                    ? Icon(
                        Icons.close,
                        color: baseColor,
                        size: 30,
                      )
                    : Icon(
                        Icons.arrow_back,
                        color: baseColor,
                        size: 30,
                      ),
                onPressed: () => closeCallBack != null
                    ? closeCallBack?.call()
                    : Navigator.of(context).pop(),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // ignore: todo
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(fromHeight!);
}
