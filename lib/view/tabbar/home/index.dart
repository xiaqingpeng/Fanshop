// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:Fanshop/custom/custom_ripple.dart';
import 'package:Fanshop/utils/platform.dart';
import 'package:Fanshop/view/tabbar/home/navigation.dart';
import 'package:Fanshop/view/tabbar/home/recommend.dart';
import 'package:Fanshop/view/tabbar/home/search_page.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:Fanshop/api/logs.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String name;
  HomePage({Key? key, required this.name}) : super(key: key) {
    // print('StatelessWidget 构造函数被调用了!');
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    final AddLogs _model = AddLogs();
    _model.addLogs("flutter/home", {});

    if (!PlatformUtils.isWeb) {
      checkPermission();
    }
    tabController = TabController(length: 3, vsync: this);
    // 注册观察者
    WidgetsBinding.instance.addObserver(this);
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,

                    ///导航栏
                    child: TabBar(
                      isScrollable: true,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Colors.black,
                      controller: tabController,
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      unselectedLabelStyle:
                          const TextStyle(color: Colors.black),

                      // 标签指示器的颜色
                      indicatorColor: Theme.of(context).primaryColor,
                      // 标签的颜色

                      // 指示器的大小
                      indicatorSize: TabBarIndicatorSize.tab,
                      // 指示器的权重，即线条高度
                      indicatorWeight: 2.0,
                      tabs: [
                        Tab(
                          // text: StringStyles.tabHome.tr,
                          text: 'home'.tr,
                        ),
                        Tab(
                          text: 'square'.tr,
                        ),
                        Tab(
                          // text: StringStyles.tabAsk.tr,
                          text: 'question'.tr,
                        )
                      ],
                    ),
                  ),

                  ///间隔
                  Expanded(child: const SizedBox()),

                  ///搜索框
                  CustomRipple(
                    circular: 20,
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const SearchPage();
                          },
                        ),
                      )
                      // Get.toNamed(Routes.searchPage)
                    },
                    //   child: const Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Icon(
                    //     IconData(0xe681, fontFamily: 'iconfont2'),
                    //   ),
                    // ),
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
              Expanded(
                  child: TabBarView(
                controller: tabController,
                children: [
                  CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      CupertinoSliverRefreshControl(),
                      TopNavigation(),
                      Recommend(),
                    ],
                  ),
                  Text('广场'),
                  Text('问答'),
                ],
              )),
            ],
          ),
        ));
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
    } else if (status == PermissionStatus.permanentlyDenied) {
      // 第二次申请
      showPermissonAlert(
        _list[1],
        '重试',
        permission,
      );
    } else if (status.isRestricted) {
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
