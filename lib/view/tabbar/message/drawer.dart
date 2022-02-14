import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<MyDrawer> {
 

  @override
  void initState() {
    super.initState();
  }

  

  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text( 'accountName'),
              accountEmail: Text( 'accountEmail'),
            
            ),
            WeCell(
              label: 'language'.tr,
              content: '',
              footer: const Icon(Icons.language),
              // onClick: () => Navigator.of(context).pushNamed('international'),
            ),
            WeCell(
              label: 'theme'.tr,
              content: '',
              footer: const Icon(Icons.colorize),
              // onClick: () => Navigator.of(context).pushNamed('theme'),
            ),
            WeCell(
              label: 'cache'.tr,
              content: '',
              footer: const Icon(Icons.cleaning_services_sharp),
              // onClick: clearSharedPreferences,
            ),
            WeCell(
              label: 'logout'.tr,
              content: '',
              footer: const Icon(Icons.exit_to_app),
              // onClick: () => WeDialog.confirm(context)(
              //   '确定退出登录嘛',
              //   onConfirm: () {
              //     Navigator.of(context).popAndPushNamed('login');
              //     userInfo["loginstatus"] = 0;
              //     SharedPreferencesUserUtils.setUserInfo("userInfo", userInfo);
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
