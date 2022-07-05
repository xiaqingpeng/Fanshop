import 'package:flutter/material.dart';
import 'package:LinJia/utils/app_size.dart';
import 'package:LinJia/view/customize_appbar.dart';
import '../view/app_topbar.dart';
import 'package:LinJia/utils/dialog_utils.dart';

class LikePage extends StatefulWidget {
  @override
  _LikePageState createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Scaffold(
        appBar: MyAppBar(  key: GlobalKey(),
            preferredSize: Size.fromHeight(AppSize.height(160)),
            child: CustomRightBar(
                title: "喜欢的商品",
                onBack: () => Navigator.pop(context),
                onMenu: () {
                  DialogUtil.buildToast("编辑商品");
                },
                menu: "编辑")),
        body: Center(
          child: Text(
            '商品列表',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            ),
          ),
        ));
  }
}
