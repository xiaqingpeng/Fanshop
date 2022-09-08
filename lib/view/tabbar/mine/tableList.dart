import 'package:Fanshop/view/tabbar/mine/historyrecord/index.dart';
import 'package:Fanshop/view/tabbar/mine/mine_address.dart';
import 'package:Fanshop/view/tabbar/mine/mine_order.dart';
import 'package:Fanshop/view/tabbar/mine/mineticket/mine_ticket.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

// import 'package:Fanshop/view/tabbar/mine/mineservice/mine_service.dart';
import 'package:Fanshop/view/tabbar/mine/qrcode_page.dart';
import 'package:Fanshop/view/tabbar/mine/feedback.dart';

class TabList extends StatelessWidget {
  TabList({Key? key}) : super(key: key);
  final List navigatorList = [
    {'name': '我的订单', 'id': 1, 'icon': 0xe600},
    {'name': '我的优惠券', 'id': 2, 'icon': 0xe60f},
    {'name': '地址管理', 'id': 4, 'icon': 0xe71f},
    {'name': '分享二维码', 'id': 6, 'icon': 0xe623},
    {'name': '活跃记录', 'id': 7, 'icon': 0xe617},
    // {'name': '售后服务', 'id': 8, 'icon': 0xe610},
    {'name': '问题反馈', 'id': 9, 'icon': 0xe606},
  ];
  Widget _listViewItemUi(BuildContext context, item) {
    return Column(children: <Widget>[
      ListTile(
        title: Text(item["name"],
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                if (item['name'] == '售后服务') {
                  // return MineServicePage(name: item['name'], id: item['id']);
                  BrnToast.show("url_launcher 组件web端不支持", context,duration: BrnDuration.short);
                } else if (item['name'] == '我的订单') {
                  return MineOrderPage(title: item['name'], id: item['id']);
                } else if (item['name'] == '分享二维码') {
                  return QrcodePage(name: item['name'], id: item['id']);
                } else if (item['name'] == '活跃记录') {
                  return  const HistoryRecord();
                } else if (item['name'] == '问题反馈') {
                  return FeedbackPage(name: item['name'], id: item['id']);
                } else if (item['name'] == '我的优惠券') {
                  return MineTicketPage(name: item['name'], id: item['id']);
                } else if (item['name'] == '地址管理') {
                  return MineAddressPage(name: item['name'], id: item['id']);
                } 
                return const Scaffold(
                  body: Center(
                    child: Icon(
                      IconData(0xe60e, fontFamily: 'iconfont2'),
                    ),
                  ),
                );
              },
            ),
          );
          // Navigator.of(context).pushNamed('/mine_detail',arguments: item);
        },
        leading: Icon(
          // item["icon"],
          IconData(item['icon'], fontFamily: 'iconfont2'),
          color: Colors.black54,
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
      const Divider(
        height: 1.0,
        indent: 16.0,
        endIndent: 16.0,
        color: Colors.grey,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: navigatorList.map((item) {
      return _listViewItemUi(context, item);
    }).toList());
  }
}
