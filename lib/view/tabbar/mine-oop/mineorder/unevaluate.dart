import 'package:flutter/material.dart';
import './enpty.dart';

class UnEvaluatePage extends StatelessWidget {
  int id;
  String name;
  String mark;
  UnEvaluatePage({required Key key, required this.name, required this.id, required this.mark}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Text('test');
    // return EnptyPage(name: name, id: id, mark: mark, key: null,);
  }
}
