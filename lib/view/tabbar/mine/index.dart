import 'package:Fanshop/view/tabbar/mine/order.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:Fanshop/api/logs.dart';
import 'package:Fanshop/view/tabbar/mine/drawer.dart';
import 'package:Fanshop/view/tabbar/mine/header.dart';
import 'package:Fanshop/view/tabbar/mine/tableList.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe

// ignore: must_be_immutable
class MinePage extends StatefulWidget {
  String name;
  MinePage({Key? key, required this.name}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  

  @override
  void initState() {
    super.initState();
    final AddLogs _model = AddLogs();
    _model.addLogs("flutter/mine",'我的');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppbarActions(
      //   'mine'.tr,
      //   Theme.of(context).primaryColor,
      //   [
          
      //   ],
      // ),
     
      endDrawer: const MyDrawer(),
      body: ListView(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
              onPressed: _onPressed,
              icon: Badge(
                badgeColor: Colors.white,
                badgeContent:  Text(
                  '3',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: const Icon(
                  IconData(0xe681, fontFamily: 'iconfont2'),
                   color: Colors.white,
                ),
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  IconData(0xe70f, fontFamily: 'iconfont2'),
                  color: Colors.white,
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
              ],
            ),
          ),
          const HeaderPage(),
          TabNavigator(),
          TabList(),
        ],
      ),
    );
  }

  _onPressed() {}
}
