import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuangxianjiaoapp/view/tabbar/car/index.dart';
import 'package:kuangxianjiaoapp/view/tabbar/category/index.dart';
import 'package:kuangxianjiaoapp/view/tabbar/home/index.dart';
import 'package:kuangxianjiaoapp/view/tabbar/mine/index.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<BottomNavigationBarItem> bottomTabs = [
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '首页'),
    const BottomNavigationBarItem(icon: Icon(Icons.category), label: '分类'),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), label: '购物车'),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person), label: '我的'),
  ];
  List<Widget> tabBodies = [
    HomePage(name: '首页'),
    CategoryPage(name: '分类'),
    CarPage(name: '购物车'),
    MinePage(name: '我的'),
  ];
  int currentIndex = 0;
  // ignore: prefer_typing_uninitialized_variables
  var currentpage;
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
