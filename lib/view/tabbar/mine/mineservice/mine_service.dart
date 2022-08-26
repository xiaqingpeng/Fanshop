// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:Fanshop/custom/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class MineServicePage extends StatelessWidget {
  int? id;
  String? name;
  // ignore: use_key_in_widget_constructors
  MineServicePage({this.name, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        name,
        Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 80.0,
            margin: const EdgeInsets.only(top: 20.0),
            // decoration: BoxDecoration(color:Colors.blueAccent),
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  InkWell(
                    onTap: () async {
                      print('联系客服');
                      const String url = 'http://43.138.203.36:8086/flutter/#/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'url不能进行访问，异常。';
                      }
                    },
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.message,
                          size: 40.0,
                          color: Theme.of(context).primaryColor
                        ),
                        const Text('联系客服')
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
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          size: 40.0,
                         color: Theme.of(context).primaryColor
                        ),
                         const Text('售后电话')
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
