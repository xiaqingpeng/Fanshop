import 'package:Fanshop/view/tabbar/mine/mineorder/index.dart';
import 'package:flutter/material.dart';


class TabNavigator extends StatelessWidget {
  TabNavigator({Key? key}) : super(key: key);
  final List navigatorList = [
    {'name': '全部', 'id': 1, 'icon': 0xe651, 'status': ''},
    {'name': '待付款', 'id': 2, 'icon': 0xe60f, 'status': 'Paying'},
    {'name': '待发货', 'id': 3, 'icon': 0xe656, 'status': 'Pending'},
    {'name': '待收货', 'id': 4, 'icon': 0xe624, 'status': 'Delivered'},
    {'name': '待评价', 'id': 5, 'icon': 0xe606, 'status': 'Resolved'},
    {'name': '已取消', 'id': 6, 'icon': 0xe606, 'status': 'Cancel'},
  ];
  Widget _gridViewItemUi(BuildContext context, item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return IndexPage(
                name: item['name'],
                id: item['id'],
                status: item['status'],
              );
            },
          ),
        );
      },
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            IconData(item['icon'],
                fontFamily: item['id'] == 1 ? 'iconfont2' : "iconfont"),
            color: Colors.black54,
          ),
          const SizedBox(
            height: 10.0,
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
      height: 60.0,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20.0),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        children: navigatorList.map((item) {
          return _gridViewItemUi(context, item);
        }).toList(),
      ),
    );
  }
}
