// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:bruno/bruno.dart';
import 'dart:math';

import 'package:Fanshop/custom/custom_appbar_actions.dart';

// ignore: must_be_immutable
class IncomeDetailPage extends StatefulWidget {
  int id;
  String name;
  // ignore: use_key_in_widget_constructors
  IncomeDetailPage({required this.name, required this.id});
  @override
  // ignore: no_logic_in_create_state
  _MyAppState createState() => _MyAppState(id: this.id, name: this.name);
}

class _MyAppState extends State<IncomeDetailPage> {
  int id;
  String name;
  int count = 5;
  // ignore: non_constant_identifier_names
  String MenuItem = '今天';
  List<BrnDoughnutDataItem> dataList = [];
  BrnDoughnutDataItem? selectedItem;
  List<Color> preinstallColors = [
    const Color(0xffFF862D),
    const Color(0xff26BB7D),
    const Color(0xffFFDD00),
    const Color(0xff6AA6FB),
    const Color(0xff0984F9),
  ];
  _MyAppState({required this.name, required this.id});
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < count; i++) {
      dataList.add(BrnDoughnutDataItem(
          title: '示例',
          value: random(1, 5).toDouble(),
          color: getColorWithIndex(i)));
    }
  }

  int random(int min, int max) {
    final _random = Random();
    return min + _random.nextInt(max - min + 1);
  }

  Color getColorWithIndex(int index) {
    return this.preinstallColors[index % this.preinstallColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarActions(
        name,
        Theme.of(context).primaryColor,
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(MenuItem),
              PopupMenuButton(
                  icon: const Icon(Icons.date_range),
                  offset: const Offset(80, 80),
                  onSelected: (String value) {
                    // ignore: avoid_print
                    print(value);
                    setState(() => {MenuItem = value});
                  },
                  itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(value: '今天', child: Text('今天')),
                        const PopupMenuItem(value: '本周', child: Text('本周')),
                        const PopupMenuItem(value: '本月', child: Text('本月'))
                      ])
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            BrnProgressBarChart(
              barChartStyle: BarChartStyle.vertical,
              xAxis: ChartAxis(axisItemList: [
                AxisItem(showText: '示例1'),
                AxisItem(showText: '示例2'),
                AxisItem(showText: '示例3'),
                AxisItem(showText: '示例4'),
              ]),
              barBundleList: [
                BrnProgressBarBundle(barList: [
                  BrnProgressBarItem(text: '示例1', value: 25),
                  BrnProgressBarItem(text: '示例2', value: 21),
                  BrnProgressBarItem(text: '示例3', value: 28),
                  BrnProgressBarItem(text: '示例4', value: 28),
                ], colors: [
                  const Color(0xff1545FD),
                  const Color(0xff0984F9)
                ]),
                BrnProgressBarBundle(barList: [
                  BrnProgressBarItem(text: '示例11', value: 25),
                  BrnProgressBarItem(text: '示例21', value: 21),
                  BrnProgressBarItem(text: '示例31', value: 28),
                  BrnProgressBarItem(text: '示例41', value: 28),
                ], colors: [
                  const Color(0xff01D57D),
                  const Color(0xff01D57D)
                ]),
              ],
              yAxis: ChartAxis(axisItemList: [
                AxisItem(showText: '10'),
                AxisItem(showText: '20'),
                AxisItem(showText: '30')
              ]),
              singleBarWidth: 30,
              barGroupSpace: 30,
              barMaxValue: 60,
              // onBarItemClickInterceptor:
              //     (barBundleIndex, barBundle, barGroupIndex, barItem) {
              //   return true;
              // },
            ),
            BrnDoughnutChart(
              padding: const EdgeInsets.all(50),
              width: 200,
              height: 200,
              data: dataList,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('数据个数'),
                ),
                Expanded(
                  child: Slider(
                      value: count.toDouble(),
                      divisions: 10,
                      onChanged: (data) {
                        setState(() {
                          this.count = data.toInt();
                          dataList.clear();
                          for (int i = 0; i < count; i++) {
                            dataList.add(BrnDoughnutDataItem(
                                title: '示例',
                                value: random(1, 5).toDouble(),
                                color: getColorWithIndex(i)));
                          }
                        });
                      },
                      onChangeStart: (data) {},
                      onChangeEnd: (data) {},
                      min: 1,
                      max: 10,
                      label: '$count',
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      semanticFormatterCallback: (double newValue) {
                        return '${newValue.round()}}';
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
