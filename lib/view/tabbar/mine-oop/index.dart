// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';


import './mine_detail.dart';
import 'mineservice/mine_service.dart';
import 'mineorder/mine_order.dart';
import 'mineticket/mine_ticket.dart';
import './income_detail.dart';
import '../mine/qrcode_page.dart';
import './about_mall.dart';

import './vipcard/bind_card.dart';
import './vipcard/open_card.dart';
import 'mineorder/unpayment.dart';
import 'mineorder/undelivery.dart';
import 'mineorder/ungoods.dart';
import 'mineorder/unevaluate.dart';

class MinePage extends StatelessWidget {
  final routes = {
    '/mine_detail': (BuildContext context) => MineDetailPage(),
    '/mine_service': (BuildContext context) => MineServicePage(),
    '/mine_order': (_) => MineOrderPage(),
    
    // '/mine_ticket': (_) => MineTicketPage(),
    // '/income_detail': (_) => IncomeDetailPage(),
    // '/qrcode_page': (_) => QrcodePage(),
    // '/about_mall': (_) => AboutMallPage(),
    '/bind_card': (_) => BindCard(),
    '/open_card': (_) => OpenCard(),
    // '/evaluate_page': (BuildContext context) => UnEvaluatePage(),
    // '/goods_page': (BuildContext context) => UnGoodsPage(),
    // '/payment_page': (BuildContext context) => UnPaymentPage(),
    // '/delivery_page': (BuildContext context) => UnDeliveryPage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 去除debugger
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('我的'),
            centerTitle: false,
            actions: const <Widget>[],
          ),
          body: ListView(
            children: <Widget>[
             
              ButtonPage(),
              TabNavigator(),
              TabList()
            ],
          )),
      routes: routes,
    );
  }
}


class ButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return BindCard();
                  }))
                },
                child: const Text('绑定已有会员卡'),
                color: Colors.pink,
                textColor: Colors.white,
              ),
              RaisedButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return OpenCard();
                  }))
                },
                child: const Text('开通新的会员卡'),
                color: Colors.orange,
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  final List navigatorList = [
    {'name': '待付款', 'id': 1, 'icon': 0xe60f},
    {'name': '待发货', 'id': 2, 'icon': 0xe656},
    {'name': '待收货', 'id': 3, 'icon': 0xe624},
    {'name': '待评价', 'id': 4, 'icon': 0xe606},
  ];

  Widget _gridViewItemUi(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print(item);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              // if (item['name'] == '待付款') {
              //   return UnPaymentPage(
              //       name: item['name'], id: item['id'], mark: 'order');
              // } else if (item['name'] == '待发货') {
              //   return UnDeliveryPage(
              //       name: item['name'], id: item['id'], mark: 'order');
              // } else if (item['name'] == '待收货') {
              //   return UnGoodsPage(
              //       name: item['name'], id: item['id'], mark: 'order');
              // } else if (item['name'] == '待评价') {
              //   return UnEvaluatePage(
              //       name: item['name'], id: item['id'], mark: 'order');
              // } else {
              //   print('888');
              // }
              return Row();
            },
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            IconData(item['icon'], fontFamily: 'iconfont'),
            color: Colors.black54,
          ),
          Text(
            item['name'],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      // margin: const EdgeInsets.only(bottom: 20.0),
      child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          children: navigatorList.map((item) {
            return _gridViewItemUi(context, item);
          }).toList()),
    );
  }
}


