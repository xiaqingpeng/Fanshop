import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';
import 'package:kuangxianjiaoapp/viewmodel/cart/cart.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
class CartNum extends StatefulWidget {
  final Map _itemData;
  const CartNum(this._itemData,{Key? key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  late Map _itemData;
  // ignore: prefer_typing_uninitialized_variables
  var cartProvider;

  @override
  Widget build(BuildContext context) {

    //注意
    _itemData=widget._itemData;

    cartProvider = Provider.of<CartViewmodel>(context);

    return Container(
      width: ScreenAdapter.value(168),
      decoration:
      BoxDecoration(border: Border.all(width: ScreenAdapter.value(2), color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn()
        ],
      ),
    );
  }

  //左侧按钮

  Widget _leftBtn() {
    return InkWell(
      onTap: () {
        if(_itemData["current_count"]>1){
          _itemData["current_count"]--;
          cartProvider.itemCountChange(_itemData);
          cartProvider.computeAllCount();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.value(45),
        height: ScreenAdapter.value(45),
        child: const Text("-"),
      ),
    );
  }

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: (){
        _itemData["current_count"]++;
        cartProvider.itemCountChange(_itemData);
        cartProvider.computeAllCount();
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.value(45),
        height: ScreenAdapter.value(45),
        child: const Text("+"),
      ),
    );
  }

//中间
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.value(70),
      decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: ScreenAdapter.value(2), color: Colors.black12),
            right: BorderSide(width: ScreenAdapter.value(2), color: Colors.black12),
          )),
      height: ScreenAdapter.value(45),
      child: Text("${_itemData["current_count"]}"),
    );
  }
}

