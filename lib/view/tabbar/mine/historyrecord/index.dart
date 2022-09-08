import 'package:Fanshop/view/tabbar/mine/historyrecord/history_list.dart';
import 'package:Fanshop/view/tabbar/mine/historyrecord/income_detail.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HistoryRecord extends StatefulWidget {
  const HistoryRecord({
    Key? key,
  }) : super(key: key);

  @override
  _HistoryRecordState createState() =>
      _HistoryRecordState();
}

class _HistoryRecordState extends State<HistoryRecord> {
  int _currentIndex = 0;
  List<Widget> list = [
    HistoryList(
      name: '浏览明细',
    ),
    IncomeDetailPage(
      name: '浏览统计',
    )
  ];

  void handleTapHandler(int index) {
    // ignore: avoid_print
    print(index);
    // ignore: avoid_print
    print('index');
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: list[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: handleTapHandler,
          type: BottomNavigationBarType.fixed, // 当tabBar个数大于等于四个
          fixedColor: Theme.of(context).primaryColor, // 激活背景颜色
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: '浏览明细'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.history), label: '浏览统计'),
          ],
        ));
  }
}
