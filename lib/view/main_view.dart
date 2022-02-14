import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
    CartPage(name: 'cart'.tr),
    MessagePage(name: 'message'.tr),
    MinePage(name: 'mine'.tr),
  ];
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
  @override
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
    return Scaffold(
      backgroundColor: Colors.redAccent,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(
            () {
              currentIndex = index;
              // currentpage = tabBodies[currentIndex];
              // _pageController.jumpToPage(index);
              _pageController.animateToPage(currentIndex,
                  duration: const Duration(microseconds: 200),
                  curve: Curves.easeInOut);
            },
          );
        },
      ),
      // body: currentpage,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: PageView.builder(
          itemBuilder: (BuildContext context, int index) => tabBodies[index],
          controller: _pageController,
          itemCount: tabBodies.length,
          onPageChanged: (int index) {
            setState(
              () {
                currentIndex = index;
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
    );
  }
}
