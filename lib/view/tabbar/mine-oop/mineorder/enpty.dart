// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EnptyPage extends StatelessWidget {
  int id;
  String name;
  String mark;
  EnptyPage({required Key key, required this.name, required this.id, required this.mark}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mark == 'order'
          ? AppBar(
              title: Text(name),
            )
          : null,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.payment,
            size: 50.0,
            color: Colors.grey,
          ),
          Container(
            child: const Text('你还没有相关的订单'),
            margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
          ),
          Container(
            child: const Text('可以看看有哪些新买的'),
            margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
          ),
          RaisedButton(
            onPressed: () => Navigator.of(context).pushNamed('/home_page'),
            child: const Text("随便逛逛"),
            color: Colors.pink,
            textColor: Colors.white,
          ),
        ],
      )),
    );
  }
}
