import 'package:Fanshop/custom/custom_appbar.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:get/get.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    var _list = Get.arguments.data;
    return Scaffold(
      appBar: CustomAppbar("订单详情", Theme.of(context).primaryColor),
      body: ListView.builder(
          // 上拉加载控制器

          itemCount: _list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: ScreenAdapter.value(220),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenAdapter.value(160),
                      height: ScreenAdapter.value(160),
                      child: Image.network("${_list[index].productImage}",
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
                            Text("${_list[index].productName}", maxLines: 2),
                            Text(
                              "比市场价低${_list[index].marketPrice - _list[index].currentPrice}元",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "￥${_list[index].currentPrice}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
