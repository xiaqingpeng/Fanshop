// ignore_for_file: unnecessary_this

import 'package:Fanshop/api/logs.dart';
import 'package:Fanshop/global/global_theme.dart';
import 'package:Fanshop/utils/platform.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:bruno/bruno.dart';
import 'dart:math';

import 'package:Fanshop/custom/custom_appbar_actions.dart';

// ignore: must_be_immutable
class IncomeDetailPage extends StatefulWidget {
  String name;
  // ignore: use_key_in_widget_constructors
  IncomeDetailPage({required this.name});
  @override
  // ignore: no_logic_in_create_state
  _MyAppState createState() => _MyAppState(name: this.name);
}

class _MyAppState extends State<IncomeDetailPage> {
  String name;

  List barChat = [];
  List<Map<String,String>> popupMenuTimeList = [
    {'value': '0', 'text': '今天'},
    {'value': '7', 'text': '本周'},
    {'value': '31', 'text': '本月'},
  ];
  List<String> popupMenuPlatformList = ['android', 'ios', 'web', 'windows', 'macos'];
  // ignore: non_constant_identifier_names
  String menuItem = '0';

  String platform = getPlatform();
  String menuTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
  List<BrnDoughnutDataItem> dataList = [];
  BrnDoughnutDataItem? selectedItem;

  var now = DateTime.now();
  Random random = Random.secure();
  _MyAppState({required this.name});
  @override
  void initState() {
    getList();
    super.initState();
  }

  getList({
    menuTimeParams,
    platformParams,
  }) async {
    var data = await GetInfoLogs.getInfoLogs(
        menuTime: menuTimeParams ?? menuTime,
        platform: platformParams ?? platform);
    for (int i = 0; i < data.length; i++) {
      dataList.add(
        BrnDoughnutDataItem(
          title: data[i]['desc'],
          value: data[i]['count'].toDouble(),
          color: themes[random.nextInt(themes.length)],
        ),
      );
    }

    setState(() {
      barChat = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarActions(
        name,
        Theme.of(context).primaryColor,
        [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(platform),
                  PopupMenuButton(
                    icon: const Icon(Icons.expand_circle_down),
                    offset: const Offset(80, 80),
                    onSelected: (String value) async {
                      setState(
                        () => {
                          dataList = [],
                          platform = value,
                        },
                      );
                      await getList(
                          menuTimeParams: menuTime, platformParams: value);
                    },
                    itemBuilder: (BuildContext context) => popupMenuPlatformList
                        .map(
                          (e) => PopupMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                        .toList(),
                  ),
                  Text(menuItem == '0'
                      ? '今天'
                      : menuItem == '7'
                          ? '本周'
                          : menuItem == '31'
                              ? '本月'
                              : '今天'),
                  PopupMenuButton(
                    icon: const Icon(Icons.date_range),
                    offset: const Offset(80, 80),
                    itemBuilder: (BuildContext context) => popupMenuTimeList
                        .map(
                          (e) => PopupMenuItem(
                            value: e['value'],
                            child: Text(e['text'].toString()),
                          ),
                        )
                        .toList(),
                    onSelected: ( value) async {
                      var _menuItem = formatDate(
                          DateTime.fromMillisecondsSinceEpoch(
                              now.millisecondsSinceEpoch -
                                  int.parse(value.toString()) * 60 * 60 * 24 * 1000),
                          [yyyy, '-', mm, '-', dd]);

                      setState(
                            () => {
                          dataList = [],
                          menuTime = _menuItem,
                          menuItem = value.toString()
                        },
                      );
                      await getList(
                          menuTimeParams: _menuItem, platformParams: platform);
                    },
                  )
                ],
              ),
            ),
            BrnProgressBarChart(
              barChartStyle: BarChartStyle.vertical,
              xAxis: ChartAxis(
                axisItemList: barChat
                    .map((e) => AxisItem(showText: '${e['desc']}'))
                    .toList(),
              ),
              barBundleList: [
                BrnProgressBarBundle(
                  barList: barChat
                      .map(
                        (e) => BrnProgressBarItem(
                          text: '${e['desc']}页面访问${e['count']}次',
                          value: e['count'].toDouble(),
                        ),
                      )
                      .toList(),
                  colors: barChat
                      .map((e) => Theme.of(context).primaryColor)
                      .toList(),
                ),
              ],
              yAxis: ChartAxis(axisItemList: [
                AxisItem(showText: '10'),
                AxisItem(showText: '20'),
                AxisItem(showText: '30')
              ]),
              singleBarWidth: 30,
              barGroupSpace: 15,
              barMaxValue: 30,
              // onBarItemClickInterceptor:
              //     (barBundleIndex, barBundle, barGroupIndex, barItem) {
              //   return true;
              // },
            ),
            BrnDoughnutChart(
              padding: const EdgeInsets.all(50),
              width: 200,
              height: 200,
              data: this.dataList,
              selectedItem: selectedItem,
              showTitleWhenSelected: true,
              selectCallback: (BrnDoughnutDataItem? selectedItem) {
                setState(() {
                  this.selectedItem = selectedItem;
                });
              },
            ),
            DoughnutChartLegend(
                data: this.dataList,
                legendStyle: BrnDoughnutChartLegendStyle.wrap),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
