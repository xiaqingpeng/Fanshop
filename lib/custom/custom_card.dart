import 'package:flutter/material.dart';
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

