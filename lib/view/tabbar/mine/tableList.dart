import 'package:flutter/material.dart';

import 'package:kuangxianjiaoapp/view/tabbar/mine/income_detail.dart';
import 'package:kuangxianjiaoapp/view/tabbar/mine/mineservice/mine_service.dart';
import 'package:kuangxianjiaoapp/view/tabbar/mine/qrcode_page.dart';

class TabList extends StatelessWidget {
  final List navigatorList = [
    {'name': '我的订单', 'id': 1, 'icon': 0xf0133},
    {'name': '我的优惠券', 'id': 2, 'icon': 0xe60f},
    {'name': '地址管理', 'id': 4, 'icon': 0xe665},
    {'name': '分享二维码', 'id': 6, 'icon': 0xe623},
    {'name': '活跃记录', 'id': 7, 'icon': 0xe617},
    {'name': '售后服务', 'id': 8, 'icon': 0xe610},
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
                  return MineServicePage(name: item['name'], id: item['id']);
                } else if (item['name'] == '我的订单') {
                  // return MineOrderPage(title: item['name'], id: item['id']);
                } else if (item['name'] == '分享二维码') {
                  return QrcodePage(name: item['name'], id: item['id']);
                } else if (item['name'] == '活跃记录') {
                  return IncomeDetailPage(name: item['name'], id: item['id']);
                } else if (item['name'] == '我的优惠券') {
                  // return MineTicketPage(name: item['name'], id: item['id']);
                } else if (item['name'] == '我的地址') {
                  // return MineAddressPage(name: item['name'], id: item['id']);
                } else {
                  return const Center(
                    child: Text('test')
                  );
                  // return MineDetailPage(name: item['name'], id: item['id']);
                }
                return const Center(
                    child: Text('test')
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
