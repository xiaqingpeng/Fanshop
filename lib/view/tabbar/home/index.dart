// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
import 'package:kuangxianjiaoapp/custom/custom_search.dart';
import 'package:kuangxianjiaoapp/view/tabbar/home/red_packet.dart';
// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String name;
  HomePage({Key? key, required this.name}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
       'home'.tr,
        Theme.of(context).primaryColor,
        content: CustomSearch(
          onClick: (v) {
            print(v.toString()+'test');
          },
        ),
      ),
      body: ListView(
        children:   const [
          //  RedPacket(),
        ],
      ),
    );
  }
}
