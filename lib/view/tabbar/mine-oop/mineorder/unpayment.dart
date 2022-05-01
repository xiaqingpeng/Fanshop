import 'package:flutter/material.dart';
import './enpty.dart';

class UnPaymentPage extends StatelessWidget {
 int id;
  String name;
  String mark;
  UnPaymentPage({required Key key, required this.name, required this.id, required this.mark}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return EnptyPage(name: name, id: id, mark: mark, key: null,);
    return const Text('test');
  }
}