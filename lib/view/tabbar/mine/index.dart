import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar_actions.dart';
import 'package:kuangxianjiaoapp/view/tabbar/mine/drawer.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarActions(
        'mine'.tr,
        Theme.of(context).primaryColor,
        [
          IconButton(
            onPressed: _onPressed,
            icon: Badge(
              badgeContent: const Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: const Icon(Icons.message),
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      endDrawer: const MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('mine'.tr),
          ],
        ),
      ),
    );
  }

  _onPressed() {}
}
