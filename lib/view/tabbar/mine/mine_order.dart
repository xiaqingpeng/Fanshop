import 'package:Fanshop/view/tabbar/mine/mineorder/unpayment.dart';
import 'package:flutter/material.dart';
import 'mineorder/allgoods.dart';
import 'mineorder/undelivery.dart';
import 'mineorder/ungoods.dart';
import 'mineorder/unevaluate.dart';

// ignore: must_be_immutable
class MineOrderPage extends StatefulWidget {
  String title;
  int id;
  MineOrderPage({Key? key, required this.title, required this.id})
      : super(key: key);
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<MineOrderPage> {
  final List<Map<String, dynamic>> navigatorList = [
    {
      'name': '全部',
      'id': 10,
      'icon': 0xe651,
      "widget": AllGoodsPage(
        name: '全部',
        id: 10,
      )
    },
    {
      'name': '待付款',
      'id': 20,
      'icon': 0xe60f,
      "widget": UnPaymentPage(
        name: '待付款',
        id: 20,
      )
    },
    {
      'name': '待发货',
      'id': 2,
      'icon': 0xe656,
      "widget": UnDeliveryPage(
        name: '待发货',
        id: 30,
      )
    },
    {
      'name': '待收货',
      'id': 40,
      'icon': 0xe624,
      "widget": UnGoodsPage(
        name: '待收货',
        id: 40,
      )
    },
    {
      'name': '待评价',
      'id': 50,
      'icon': 0xe606,
      "widget": UnEvaluatePage(
        name: '待评价',
        id: 50,
      )
    },
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: navigatorList.length, //配置顶部tab的数量
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          //配置顶部导航栏
          bottom: TabBar(
            labelColor: Colors.white,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(fontSize: 14),
            tabs: navigatorList
                .map(
                  (e) => Tab(
                    text: e['name'],
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          children: navigatorList
              .map((e) => SizedBox(
                    child: e['widget'],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
