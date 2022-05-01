// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class IncomeDetailPage extends StatefulWidget {
  int id;
  String name;
  IncomeDetailPage({required Key key, required this.name, required this.id}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  _MyAppState createState() =>  _MyAppState(id: this.id, name: this.name, key: null);
}

class _MyAppState extends State<IncomeDetailPage> {
  int id;
  String name;
  String MenuItem = '今天';
  _MyAppState({required Key key, required this.name, required this.id});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: Text('$name'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(MenuItem),
              PopupMenuButton(
                  icon: Icon(Icons.date_range),
                  offset: Offset(80,80),
                  onSelected: (value) {
                    print(value);
                    setState(() => {
                      MenuItem = value
                    });
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
      body:  Column(
        children: <Widget>[
           Text('我的收入明细'),
          Container(
            child: Echarts(
              option: '''
    {
      xAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      },
      yAxis: {
        type: 'value'
      },
      series: [{
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line'
      }]
    }
  ''',
            ),
            width: 300,
            height: 250,
          )
        ],
      ),
    );
  }
}
