import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/common/sharedPreferences.dart';
import 'package:kuangxianjiaoapp/custom/custom.dart';
import 'package:kuangxianjiaoapp/view/tabbar/mine/drawer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

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
        widget.name,
        Theme.of(context).primaryColor,
        [ IconButton(onPressed: _onPressed, icon: const Icon(Icons.message)),
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
            Text(widget.name),
          ],
        ),
      ),
    );
  }
  _onPressed(){
    
  }
}
