import 'package:Fanshop/view/tabbar/mine/order.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:Fanshop/api/logs.dart';
import 'package:Fanshop/custom/custom_appbar_actions.dart';
import 'package:Fanshop/view/tabbar/mine/drawer.dart';
import 'package:Fanshop/view/tabbar/mine/header.dart';
import 'package:Fanshop/view/tabbar/mine/tableList.dart';
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
      appBar: CustomAppbarActions(
        'mine'.tr,
        Theme.of(context).primaryColor,
        [
          IconButton(
            onPressed: _onPressed,
            icon: Badge(
              badgeColor: Theme.of(context).primaryColor,
              badgeContent: const Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: const Icon(
                IconData(0xe681, fontFamily: 'iconfont2'),
              ),
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                IconData(0xe70f, fontFamily: 'iconfont2'),
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      endDrawer: const MyDrawer(),
      body: ListView(
        children: <Widget>[
          const HeaderPage(),
          TabNavigator(),
          TabList(),
        ],
      ),
    );
  }

  _onPressed() {}
}
