// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
import 'package:kuangxianjiaoapp/custom/custom_search.dart';
import 'package:kuangxianjiaoapp/view/tabbar/home/navigation.dart';
import 'package:kuangxianjiaoapp/view/tabbar/home/recommend.dart';
import 'package:kuangxianjiaoapp/viewmodel/home/home.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

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
    context.read<HomeViewmodel>().getCategory();
    context.read<HomeViewmodel>().getProduct(0);
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
              print(v.toString() + 'test');
            },
          ),
        ),
        // body: Center(
        //   child: Flex(direction: Axis.vertical, children: const [
        //     Expanded(child: TopNavigation()),
        //     Expanded(
        //       child: SizedBox(
        //         child: Recommend(),
        //       ),
        //       flex: 1,
        //     ),
        //   ]),
        // ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox.fromSize(
                    size: Size.fromHeight(ScreenAdapter.value(360.0)),
                    child: const TopNavigation(),
                  ),
                  const Recommend(),
                 
                ],
              ),
            ),
          ],
        ),);
  }
}
