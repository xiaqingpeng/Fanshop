// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MineServicePage extends StatelessWidget {
  int ?id;
  String ?name;
  // ignore: use_key_in_widget_constructors
  MineServicePage({this.name,this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 150.0,
            margin: const EdgeInsets.only(bottom: 20.0),
            // decoration: BoxDecoration(color:Colors.blueAccent),
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  InkWell(
                    onTap: () async {
                      print('联系客服');
                      const String url = 'https://www.baidu.com/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'url不能进行访问，异常。';
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.message,
                          size: 40.0,
                          color: Colors.pink,
                        ),
                        Text('联系客服')
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      print('售后电话');
                      const String url = 'tel:17304472875';
                      if (await canLaunch(url)) {
                         print('售后电话正常');
                        await launch(url);
                      } else {
                        throw 'url不能进行访问，异常。';
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.phone,
                          size: 40.0,
                          color: Colors.pink,
                        ),
                        Text('售后电话')
                      ],
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

