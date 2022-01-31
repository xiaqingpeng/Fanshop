import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
AppBar CustomAppbar(String title, Color backgroundColor,
    {double elevation = 4.0, bool centerTitle = true}) {
  return AppBar(
    title: Text(title),
    elevation: elevation, // 阴影 默认4.0
    backgroundColor: backgroundColor,
    centerTitle: centerTitle,
  );
}

// ignore: non_constant_identifier_names
AppBar CustomAppbarActions(
    String title, Color backgroundColor, List<Widget> actions,
    {double elevation = 4.0, bool centerTitle = true}) {
  return AppBar(
    title: Text(title),
    elevation: elevation, // 阴影 默认4.0
    backgroundColor: backgroundColor,
    centerTitle: centerTitle,
    actions: actions,
  );
}

class CustomCard extends StatefulWidget {
  const CustomCard({
    Key? key,
    this.padding = 8.0,
    this.margin = 0.0,
    this.onPressed,
    this.height = 100,
    this.shadowColor = Colors.grey,
    this.elevation = 4.0,
    this.child,
  }) : super(
          key: key,
        );

  // 按钮宽高
  // ignore: empty_constructor_bodies
  final double padding;
  final double margin;
  final double height;

  final Widget? child;

  final Color shadowColor;
  final double elevation;

  // 点击回调
  final GestureTapCallback? onPressed;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Card(
          shadowColor: widget.shadowColor, // 阴影颜色
          elevation: widget.elevation, // 阴影深度
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(widget.margin),
                child: widget.child,
                height: widget.height,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

  // 按钮宽高
  // ignore: empty_constructor_bodies
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
