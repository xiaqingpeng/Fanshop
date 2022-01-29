import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom.dart';
// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
 String name;
  CategoryPage({Key? key, required this.name}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(widget.name, Theme.of(context).primaryColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Text(widget.name),
          ],
        ),
      ),
    );
  }
}