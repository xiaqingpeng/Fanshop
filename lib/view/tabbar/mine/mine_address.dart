// ignore_for_file: unnecessary_this

import 'package:Fanshop/custom/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:bruno/bruno.dart';
import 'dart:math';

import 'package:Fanshop/custom/custom_appbar_actions.dart';

// ignore: must_be_immutable
class MineAddressPage extends StatefulWidget {
  int id;
  String name;
  // ignore: use_key_in_widget_constructors
  MineAddressPage({required this.name, required this.id});
  @override
  // ignore: no_logic_in_create_state
  _MyAppState createState() => _MyAppState(id: this.id, name: this.name);
}

class _MyAppState extends State<MineAddressPage> {
  int id;
  String name;

  _MyAppState({required this.name, required this.id});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        name,
        Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[],
        ),
      ),
    );
  }
}
