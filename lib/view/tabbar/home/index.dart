import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
// ignore: must_be_immutable
class HomePage extends StatefulWidget {
 String name;
  HomePage({Key? key, required this.name}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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