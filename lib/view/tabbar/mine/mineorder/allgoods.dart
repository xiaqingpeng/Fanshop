import 'package:flutter/material.dart';
import '../mineticket/enpty.dart';

// ignore: must_be_immutable
class AllGoodsPage extends StatelessWidget {
  AllGoodsPage({Key? key,required this.name, required this.id}) : super(key: key);
   int id;
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: id<10?AppBar(
        title: Text(name),
      ):null,
      body: const EnptyPage()
    );
  
  }
}
