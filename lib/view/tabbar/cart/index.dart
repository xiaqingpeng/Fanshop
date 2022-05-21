import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:Fanshop/api/logs.dart';
import 'package:Fanshop/common/SharedPreferences.dart';
// ignore: unused_import
import 'package:Fanshop/custom/custom_appbar_actions.dart';
import 'package:Fanshop/custom/custom_button.dart';
import 'package:Fanshop/view/tabbar/cart/cartItem.dart';
// ignore: unused_import
import 'package:Fanshop/view/checkout/checkout.dart';
import 'package:Fanshop/view/tabbar/cart/emptyItem.dart';
import 'package:Fanshop/viewmodel/cart/cart.dart';
import 'package:Fanshop/viewmodel/cart/check_out.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

// ignore: must_be_immutable
class CartPage extends StatefulWidget {
  String name;
  CartPage({Key? key, required this.name}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // ignore: unused_field
  late bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    final AddLogs _model = AddLogs();
    _model.addLogs("flutter/cart");
  }

  //去结算
  doCheckOut(checkOutData) async {}

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartViewmodel>(context);
    double accountCount = cartProvider.accountCount;
    bool isAllchecked = cartProvider.isCheckAll;
    bool isAnychecked =
        cartProvider.cartList.any((element) => element['checked']); //判断是否有选中商品
    double allPrice = cartProvider.allPrice;
    CheckOutViewmodel checkOutProvider =
        Provider.of<CheckOutViewmodel>(context);
    List checkoutData =
        cartProvider.cartList.where((element) => element['checked']).toList();
    String? buttonText = {true: "删除", false: '结算'}[_isEdit];
    return Scaffold(
      appBar: CustomAppbarActions(
        'cart'.tr,
        Theme.of(context).primaryColor,
        [
          cartProvider.cartList.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(
                      () {
                        _isEdit = !_isEdit;
                      },
                    );
                  },
                  icon: _isEdit
                      ? const Icon(Icons.delete)
                      : const Icon(Icons.launch),
                )
              : Row(),
        ],
      ),
      body: cartProvider.cartList.isNotEmpty
          ? Stack(
              children: [
                //列表
                ListView(
                  children: [
                    Column(
                      children: [
                        Column(
                          children: cartProvider.cartList.map(
                            (value) {
                              //返回生成每个Item
                              return CartItem(value);
                            },
                          ).toList(),
                        ),
                        SizedBox(
                          height: ScreenAdapter.value(100),
                        )
                      ],
                    )
                  ],
                ),
                //底部的全选和结算按钮
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
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              SizedBox(
                                width: ScreenAdapter.value(60),
                                child: Checkbox(
                                  value: isAllchecked,
                                  activeColor: Theme.of(context).primaryColor,
                                  onChanged: (val) {
                                    cartProvider.checkAll(val);
                                  },
                                ),
                              ),
                              const Text('全选'),
                            ],
                          ),
                        ),
                        if (!_isEdit)
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  '不含运费',
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                const Text('合计'),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '￥${allPrice.toInt().toString()}',
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
                              title: '$buttonText',
                              fontSize: 14,
                              content: Text(
                                buttonText.toString() +
                                    '(${accountCount.toInt().toString()})',
                                style: const TextStyle(color: Colors.white),
                              ),
                              disable: !isAnychecked,
                              onPressed: () {
                                if (_isEdit) {
                                  WeDialog.confirm(context)(
                                    '确定删除嘛',
                                    onConfirm: () {
                                      cartProvider.removeItem();
                                    },
                                  );
                                }
                                if (!_isEdit) {
                                  checkOutProvider.changeCheckOutListData(
                                      checkoutData, context); // 提交订单
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const EmptyItem(),
    );
  }
}
