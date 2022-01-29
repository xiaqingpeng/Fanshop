import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/common/sharedPreferences.dart';
import 'package:kuangxianjiaoapp/custom/custom.dart';
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
        [
          IconButton(
            onPressed: ()=>Navigator.of(context).pushNamed('theme'),
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () => WeDialog.confirm(context)(
              '确定退出登录嘛',
              onConfirm: () {
                Navigator.of(context).popAndPushNamed('login');
                SharedPreferencesUserUtils.setUserInfo("userInfo",{
                  "loginstatus": 0,
                });
              },
            ),
            icon: const Icon(Icons.exit_to_app_sharp),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Text(widget.name),
          ],
        ),
      ),
    );
  }
}