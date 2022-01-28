import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/common/SharedPreferences.dart';
import 'package:kuangxianjiaoapp/custom/custom.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarActions(
        '菜单',
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
    );
  }
}
