import 'package:Fanshop/view/tabbar/mine/mineticket/enpty.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UnEvaluatePage extends StatelessWidget {
  int id;
  String name;
  UnEvaluatePage({Key? key, required this.name, required this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: id < 10
            ? AppBar(
                title: Text(name),
              )
            : null,
        body: const EnptyPage());
  }
}
