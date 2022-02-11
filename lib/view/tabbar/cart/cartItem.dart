import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:kuangxianjiaoapp/view/tabbar/cart/cartNum.dart';
import 'package:kuangxianjiaoapp/viewmodel/cart/cart.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartItem extends StatefulWidget {
  final Map _itemData;
  const CartItem(this._itemData, {Key? key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  //从本地存储的数据里面读取的
  late Map _itemData;

  @override
  Widget build(BuildContext context) {
    //注意：给属性赋值
    _itemData = widget._itemData;
    //通过Provider实现了页面和组件间的数据共享
    var cartProvider = Provider.of<CartViewmodel>(context);
    return Container(
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
            width: ScreenAdapter.value(60),
            child: Checkbox(
              value: _itemData["checked"],
              onChanged: (val) {
                // print(val.toString() + 'val');
                _itemData["checked"] = !_itemData["checked"];
                //更新数据
                cartProvider.itemChage(_itemData);
              },
              activeColor: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            width: ScreenAdapter.value(160),
            height: ScreenAdapter.value(160),
            child: Image.network("${_itemData["product_image"]}",
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
                  Text("${_itemData["product_name"]}", maxLines: 2),
                  Text(
                    "比市场价低${_itemData["market_price"] - _itemData["current_price"]}元",
                    style: const TextStyle(color: Colors.red),
                  ),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "￥${_itemData["current_price"]}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        //实现增加/减少物品件数
                        child: CartNum(_itemData),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
