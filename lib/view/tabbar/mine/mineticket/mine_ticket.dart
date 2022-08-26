import 'package:flutter/material.dart';
import './wait_used.dart';
import './has_used.dart';
import './lose_used.dart';

// ignore: must_be_immutable
class MineTicketPage extends StatefulWidget {
  String name;
  int id;
  MineTicketPage({Key? key, required this.name, required this.id}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _Home2State createState() => _Home2State(name: name);
}

class _Home2State extends State<MineTicketPage> {
  String name;
  _Home2State({required this.name});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, //配置顶部tab的数量
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          //配置顶部导航栏
          bottom: const TabBar(
            labelColor: Colors.white,
            isScrollable: true,
            // labelStyle: TextStyle(fontSize: 12),
            tabs: <Widget>[
              Tab(text: "待使用"),
              Tab(text: "已使用"),
              Tab(text: "已失效"),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            WaitUsedPage(),
            HasUsedPage(),
            LoseUsedPage(),
          ],
        ),
      ),
    );
  }
}
