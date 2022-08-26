// ignore_for_file: unnecessary_this

import 'package:Fanshop/view/tabbar/mine/mineticket/enpty.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UnGoodsPage extends StatefulWidget {
  int id;
  String name;
  UnGoodsPage({Key? key, required this.id, required this.name})
      : super(key: key);

  // ignore: empty_constructor_bodies
  @override
  _UnGoodsPage createState() {
    return _UnGoodsPage();
  }
}

class _UnGoodsPage extends State<UnGoodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.id < 10
          ? AppBar(
              title: Text(widget.name),
            )
          : null,
      body: const EnptyPage(),
    );
  }
}
