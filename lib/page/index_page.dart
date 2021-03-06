import 'dart:async';

import 'package:LinJia/page/reg_and_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:LinJia/common.dart';
import 'package:LinJia/dao/user_dao.dart';
import 'package:LinJia/models/user_entity.dart';

import 'package:LinJia/page/cart/cart_page.dart';
import 'package:LinJia/page/mine/member_page.dart';

import 'package:LinJia/page/find/search_page.dart';

import 'package:LinJia/receiver/event_bus.dart';
import 'package:LinJia/utils/app_size.dart';

import 'package:LinJia/utils/dialog_utils.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

import 'home/home_shop_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

final List<BottomNavigationBarItem> bottomBar = <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "小铺"),
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: "发现"),
  BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart), label: "购物车"),
  BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled), label: "我的")
];

final List<Widget> pages = <Widget>[
  HomePage(),
  SearchPage(),
  CartPage(),
  MemberPage()
];

class _IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin {
  late DateTime lastPopTime;
  late String token;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
//    print("--*-- _IndexPageState");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 初始化屏幕适配包
    AppSize.init(context);

    _listen();
    return WillPopScope(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: this.currentIndex,
              onTap: (index) async {
                // if (index == 3) {
                //   SharedPreferences prefs =
                //       await SharedPreferences.getInstance();
                //   if (null == prefs.getString("token") ||
                //       prefs.getString("token").isEmpty) {
                //     Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (BuildContext context) {
                //                   return RegPageAndLoginPage();
                //                 },
                //               ),
                //             );
                //     return;
                //   }
                //   AppConfig.token = prefs.getString("token");
                //   loadUserInfo();
                //   setState(() {
                //     this.currentIndex = index;
                //     pageController.jumpToPage(index);
                //   });
                // } else {
                //   setState(() {
                //     this.currentIndex = index;
                //     pageController.jumpToPage(index);
                //   });
                // }
                 setState(() {
                    this.currentIndex = index;
                    pageController.jumpToPage(index);
                  });
              },
              items: bottomBar),
          body: _getPageBody(context),
        ),
        onWillPop: () async {
          // 点击返回键的操作
          if (DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
            lastPopTime = DateTime.now();
            DialogUtil.buildToast('再按一次退出');
            return true;
          } else {
            lastPopTime = DateTime.now();
            // 退出app
            return await SystemChannels.platform
                .invokeMethod('SystemNavigator.pop');
          }
        });
  }

  final pageController = PageController();
  Widget _getPageBody(BuildContext context) {
    return PageView(
      controller: pageController,
      children: pages,
      physics: NeverScrollableScrollPhysics(), // 禁止滑动
    );
  }

  late StreamSubscription _indexSubscription;

  @override
  // ignore: todo
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  void _listen() {
    _indexSubscription = eventBus.on<IndexInEvent>().listen((event) {
      int index = int.parse(event.index);
      this.currentIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _indexSubscription.cancel();
  }

  loadUserInfo() async {
    UserEntity? entity = await UserDao.fetch(AppConfig.token);
    if (entity?.userInfoModel != null) {
      AppConfig.nickName = entity!.userInfoModel.nickName;
      AppConfig.mobile = entity.userInfoModel.mobile;
      AppConfig.avatar = entity.userInfoModel.avatar;
      AppConfig.gender = entity.userInfoModel.gender;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (null == prefs.getString("token") ||
          prefs.getString("token").isEmpty) {
        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RegPageAndLoginPage();
                                },
                              ),
                            );
        DialogUtil.buildToast("token失效~");
        return;
      }
    }
  }
}
