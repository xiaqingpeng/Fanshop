import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// 自定义按钮封装
class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    this.onPressed,
    this.height = 48.0,
    this.horizontal = 0.0,
    this.vertical = 0.0,
    this.width = double.infinity,
    this.borderRadius = 10.0,
    this.fontSize = 18.0,
    this.content,
    this.loading = false,
    this.title = "",
    this.disable = false,
    this.backgroundColor,
  }) : super(
          key: key,
        );
  final double width;
  final double height;
  final double horizontal;
  final double vertical;
  final double borderRadius;
  final double fontSize;
  final String title;
  final bool loading;
  final bool disable;
  final Color? backgroundColor;
  final Widget? content;

  // 点击回调
  final GestureTapCallback? onPressed;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.vertical, horizontal: widget.horizontal),
      child: GestureDetector(
        onTap: widget.disable ? null : widget.onPressed,
        child: Opacity(
          opacity: widget.disable ? 0.7 : 1,
          child: Container(
            alignment: Alignment.center,
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
            ),
            // ignore: unrelated_type_equality_checks
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.loading
                    ? const CupertinoActivityIndicator()
                    : const SizedBox(),
                widget.content ??
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.white, fontSize: widget.fontSize),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
