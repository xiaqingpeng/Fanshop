import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:kuangxianjiaoapp/view/tabbar/cart/index.dart';
import 'package:kuangxianjiaoapp/view/tabbar/category/index.dart';
import 'package:kuangxianjiaoapp/view/tabbar/home/index.dart';
import 'package:kuangxianjiaoapp/view/tabbar/message/index.dart';
import 'package:kuangxianjiaoapp/view/tabbar/mine/index.dart';
import 'package:kuangxianjiaoapp/viewmodel/cart/cart.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> tabBodies = [
    HomePage(name: 'home'.tr),
    CategoryPage(name: 'category'.tr),
    MessagePage(name: 'message'.tr),
    CartPage(name: 'cart'.tr),
    MinePage(name: 'mine'.tr),
  ];
  int lastTime = 0;
  int currentIndex = 0;
  // ignore: prefer_typing_uninitialized_variables
  var currentpage;
  // ignore: unused_field

  @override
  void initState() {
    currentpage = tabBodies[currentIndex];

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final PageController _pageController = PageController();
  // ignore: non_constant_identifier_names
  void onTap(value) {
    // if (value == 2) return;
    // if (value > 2) {
    //   value = value - 1;
    // }
    setState(
      () {
        currentIndex = value;
        // currentpage = tabBodies[currentIndex];
        // _pageController.jumpToPage(index);
        _pageController.animateToPage(currentIndex,
            duration: const Duration(microseconds: 200),
            curve: Curves.easeInOut);
      },
    );
  }

  Color getColor(int value) {
    return currentIndex == value
        ? Theme.of(context).primaryColor
        : const Color(0XFFBBBBBB);
  }

  Widget build(BuildContext context) {
    CartViewmodel cartProvider = Provider.of<CartViewmodel>(context);
    cartProvider.Cart(); //获取购物车缓存数据
    double count = cartProvider.allCount;
    List<BottomNavigationBarItem> bottomTabs = [
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.home),
        label: 'home'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.category),
        label: 'category'.tr,
      ),
      BottomNavigationBarItem(
        icon: count > 0
            ? Badge(
                badgeContent: Text(
                  count.toInt().toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.shopping_cart,
                ),
              )
            : const Icon(
                CupertinoIcons.shopping_cart,
              ),
        label: 'cart'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.message),
        label: 'message'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(CupertinoIcons.person),
        label: 'mine'.tr,
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        int newTime = DateTime.now().millisecondsSinceEpoch;
        int result = newTime - lastTime;
        lastTime = newTime;
        if (result > 2000) {
          // ignore: avoid_print
          print('退出应用');
        } else {
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   currentIndex: currentIndex,
        //   items: bottomTabs,
        //   selectedItemColor: Theme.of(context).primaryColor,
        //   unselectedItemColor: Colors.grey,
        //   onTap: onTap
        // ),
        bottomNavigationBar: BottomAppBar(
          // ignore: deprecated_member_use
          // color: Theme.of(context).primaryColor,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  onTap(0);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.home,
                      color: getColor(0),
                    ),
                    Text(
                      'home'.tr,
                      style: TextStyle(
                        color: getColor(0),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  onTap(1);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.category,
                      color: getColor(1),
                    ),
                    Text(
                      'category'.tr,
                      style: TextStyle(
                        color: getColor(1),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  onTap(2);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(
                      Icons.message,
                      color: Colors.transparent,
                    ),
                    // Text('message'.tr)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  onTap(3);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    count > 0
                        ? Badge(
                            badgeColor: Theme.of(context).primaryColor,
                            badgeContent: Text(
                              count.toInt().toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            child: Icon(
                              CupertinoIcons.shopping_cart,
                              color: getColor(3),
                            ),
                          )
                        : Icon(
                            CupertinoIcons.shopping_cart,
                            color: getColor(3),
                          ),
                    Text(
                      'cart'.tr,
                      style: TextStyle(
                        color: getColor(3),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  onTap(4);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.person,
                      color: getColor(4),
                    ),
                    Text(
                      'mine'.tr,
                      style: TextStyle(
                        color: getColor(4),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            onTap(2);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: PageView.builder(
            itemBuilder: (BuildContext context, int index) => tabBodies[index],
            controller: _pageController,
            itemCount: tabBodies.length,
            onPageChanged: (int value) {
              // if (value >= 2) {
              //   value = value + 1;
              // }
              setState(
                () {
                  currentIndex = value;
                },
              );
            },
          ),
          // child: PageView(
          //   controller: _pageController,
          //   physics: NeverScrollableScrollPhysics(),
          //   children: tabBodies,
          // ),
        ),
      ),
    );
  }
}
