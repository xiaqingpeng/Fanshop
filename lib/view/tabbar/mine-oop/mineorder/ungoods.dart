// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UnGoodsPage extends StatefulWidget {
  int id;
  String name;
  String mark;
  UnGoodsPage({required Key key, required this.id, required this.mark, required this.name}) : super(key: key);

  @override
  _UnGoodsPage createState() =>
      // ignore: no_logic_in_create_state
      _UnGoodsPage(id: this.id, name: this.name, mark: this.mark, key: null);
}

class _UnGoodsPage extends State<UnGoodsPage> {
  int id;
  int _currentStep = 2;
  String name;
  String mark;
  // ignore: unused_element
  _UnGoodsPage({required Key key, required this.name, required this.id, required this.mark});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
      ),
      body: Center(
        child: Column(
          children: const [
           
            
          ],
        ),
      ),
    );
    // return EnptyPage(name: name, id: id,mark:mark);
  }
}
