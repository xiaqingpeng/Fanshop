import 'dart:async';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:kuangxianjiaoapp/common/sharedPreferences.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
import 'package:kuangxianjiaoapp/custom/custom_button.dart';
import 'package:kuangxianjiaoapp/view/main_view.dart';
import 'package:kuangxianjiaoapp/viewmodel/cart/cart.dart';
import 'package:kuangxianjiaoapp/viewmodel/cart/check_out.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);
  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  late Map<dynamic, dynamic> userInfo = {};
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CheckOutViewmodel checkOuProvider = Provider.of<CheckOutViewmodel>(context);
    CartViewmodel cartProvider = Provider.of<CartViewmodel>(context);
    List checkOutListData = checkOuProvider.checkOutListData;
    double allPrice = checkOuProvider.allPrice;

    return Scaffold(
      appBar: CustomAppbar('确认订单', Theme.of(context).primaryColor),
      body: Container(
        constraints: const BoxConstraints(minHeight: 200),
        child: Stack(
          children: [
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: ScreenAdapter.value(160),
                        height: ScreenAdapter.value(160),
                        child: Image.network(
                            "${checkOutListData[index]["product_image"]}",
                            fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${checkOutListData[index]["product_name"]}",
                                  maxLines: 2),
                              Text(
                                "￥${checkOutListData[index]["current_price"]}",
                                style: TextStyle(color:  Theme.of(context).primaryColor),
                              ),
                              Text(
                                "x${checkOutListData[index]["current_count"]}",
                                style: TextStyle(color:  Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10.0),
                );
              },
              itemCount: checkOutListData.length,
            ),
            Positioned(
              bottom: 0,
              width: ScreenAdapter.value(750),
              height: ScreenAdapter.value(100),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: Colors.black12),
                    ),
                    color: Colors.white),
                width: ScreenAdapter.value(750),
                height: ScreenAdapter.value(78),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '不含运费',
                            style:
                                TextStyle(color: Colors.black38, fontSize: 12),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text('合计'),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '￥${allPrice.toString()}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: CustomButton(
                          width: 75,
                          height: 30,
                          borderRadius: 5,
                          title: '提交订单',
                          fontSize: 14,
                          onPressed: () async {
                            double data = await showBottomSheet(allPrice);

                            WeToast.success(context)(
                              message: '支付成功',
                              onClose: () {
                                cartProvider.removeItem();
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const MainView()
                                  ),
                                  // ignore: unnecessary_null_comparison
                                  (route) => route == null,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<double> showBottomSheet(double allPrice) async {
    final double res = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: ScreenAdapter.value(600),
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '￥${allPrice.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenAdapter.value(60.0),
                ),
              ),
            ),
            ListTile(
              title: const Text('支付宝账号'),
              trailing: Text(userInfo["telephone"] ?? ''),
            ),
            Divider(
              color: Colors.grey[200],
              height: 1,
              thickness: 1,
              indent: 15.0,
              endIndent: 15.0,
            ),
            const ListTile(
              trailing: Icon(Icons.arrow_right),
              title: Text('招商银行储蓄卡(6732)'),
              leading: Icon(Icons.food_bank),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(
                title: '确认支付',
                onPressed: () {
                  Navigator.pop(context, allPrice);
                },
              ),
            )
          ]),
        );
      },
    );
    // ignore: avoid_print
    return res;
  }

  Future<void> getUserInfo() async {
    Map<dynamic, dynamic> _userInfo =
        await SharedPreferencesUserUtils.getUserInfo("userInfo");
    setState(
      () {
        userInfo = _userInfo;
      },
    );
  }
}
