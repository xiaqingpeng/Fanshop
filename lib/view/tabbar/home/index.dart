// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
import 'package:kuangxianjiaoapp/custom/custom_search.dart';
import 'package:kuangxianjiaoapp/utils/platform.dart';
import 'package:kuangxianjiaoapp/view/tabbar/home/navigation.dart';
import 'package:kuangxianjiaoapp/view/tabbar/home/recommend.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: implementation_imports

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String name;
  HomePage({Key? key, required this.name}) : super(key: key) {
    print('StatelessWidget 构造函数被调用了!');
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    if (!PlatformUtils.isWeb) {
      checkPermission();
    }

    // 注册观察者
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && _isGoSetting) {
      if (!PlatformUtils.isWeb) {
        checkPermission();
      }
    }
  }

  @override
  void dispose() {
    // 注销观察者
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        'home'.tr,
        Theme.of(context).primaryColor,
        content: CustomSearch(
          onClick: (v) {
            print(v.toString() + 'test');
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox.fromSize(
                  size: Size.fromHeight(ScreenAdapter.value(360.0)),
                  child: const TopNavigation(),
                ),
                const Recommend(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 检查权限
  void checkPermission() async {
    Permission permission = Permission.location;
    PermissionStatus status = await permission.status;
    // ignore: avoid_print
    print('检测权限$status');
    if (status.isGranted) {
      //权限通过
    } else if (status.isDenied) {
       // 用户第一次申请拒绝
      showPermissonAlert(_list[0], '同意', permission);
    } else if (status==PermissionStatus.permanentlyDenied) {

       // 第二次申请
      showPermissonAlert(_list[1], '重试', permission,);
    
    }  else if (status.isRestricted) {
      //活动限制（例如，设置了家长///控件，仅在iOS以上受支持。
      openAppSettings();
    } else {
      //第一次申请
      requestPermission(permission);
    }
  }

  // ignore: unused_field
  final List<String> _list = [
    "为您更好的体验应用，所以需要获取你的手机文件存储权限,以保存你的偏好设置",
    "你已拒绝权限，所以无法保存你的一些偏好设置",
    "您已经拒绝权限,请在设置中心同意App权限申请",
    "其他错误"
  ];
  // 是否去设置中心
  bool _isGoSetting = false;
  void showPermissonAlert(
      String message, String rightString, Permission permission,
      {bool isSetting = false}) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('温馨提示'),
            content: Container(
              // alignment: Alignment.center,
              child: Text(message),
              padding: const EdgeInsets.all(12),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('退出应用'),
                onPressed: () {
                  closeApp();
                },
              ),
              CupertinoDialogAction(
                child: Text(rightString),
                onPressed: () {
                  // 关闭弹窗
                  Navigator.of(context).pop();
                  if (isSetting) {
                    _isGoSetting = true;
                    // 去设置中心
                    openAppSettings();
                  } else {
                    // 申请权限
                    if (!PlatformUtils.isWeb) {
                      requestPermission(permission);
                    }
                  }
                },
              ),
            ],
          );
        });
  }

  // 申请权限
  void requestPermission(Permission permission) async {
    //发起权限申请
    PermissionStatus status = await permission.request();
    // 返回权限申请的状态 status
    // ignore: avoid_print
    print('权限状态$status');
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  // 申请多个权限
  void requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    // ignore: avoid_print
    print('位置权限：${statuses[Permission.location]}');
    // ignore: avoid_print
    print('存储权限：${statuses[Permission.storage]}');
  }

  // 关闭应用
  void closeApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
