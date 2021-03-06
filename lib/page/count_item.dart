import 'package:LinJia/page/reg_and_login.dart';
import 'package:flutter/material.dart';
import 'package:LinJia/dao/add_goods_cart_dao.dart';
import 'package:LinJia/dao/del_goods_dao.dart';

import 'package:LinJia/models/cart_entity.dart';
import 'package:LinJia/models/cart_goods_query_entity.dart';
import 'package:LinJia/models/msg_entity.dart';

import 'package:LinJia/receiver/event_bus.dart';
import 'package:LinJia/utils/app_size.dart';
import 'package:LinJia/utils/dialog_utils.dart';
import '../common.dart';

// ignore: must_be_immutable
class CartCount extends StatelessWidget {
  GoodsModel item;

  CartCount(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.width(190.0),
      height: AppSize.width(65),
      margin: EdgeInsets.only(top: 5.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ],
      ),
    );
  }

  // 减少按钮
  Widget _reduceBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        loadReduce(context, item.orderId, item.countNum - 1, AppConfig.token);
      },
      child: Container(
        width: AppSize.width(55),
        height: AppSize.width(55),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.countNum > 1 ? Colors.white : Colors.black12,
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: item.countNum > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  void loadReduce(
      BuildContext context, String orderId, int count, String token) async {
    MsgEntity? entity = await DelDao.fetch(orderId, count, token);
    if (entity?.msgModel != null) {
      if (entity!.msgModel.code == 20000) {
        item.countNum--;
        eventBus.fire(new GoodsNumInEvent("sub"));
      }
      DialogUtil.buildToast(entity.msgModel.msg);
    } else {
      // Routes.instance.navigateTo(context, Routes.login_page);
      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RegPageAndLoginPage();
                                },
                              ),
                            );
      AppConfig.token = '';
      DialogUtil.buildToast("请求失败~");
    }
  }

  //添加按钮
  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        addCart(context, item.id, 1, item.idSku, AppConfig.token);
      },
      child: Container(
        width: AppSize.width(55),
        height: AppSize.width(55),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Text('+'),
      ),
    );
  }

  void addCart(BuildContext context, String idGoods, int count, String idSku,
      String token) async {
    CartEntity? entity = await AddDao.fetch(idGoods, count, idSku, token);
    if (entity?.cartModel != null) {
      if (entity!.cartModel.code == 20000) {
        item.countNum++;
        eventBus.fire(GoodsNumInEvent("add"));
      }
      DialogUtil.buildToast(entity.cartModel.msg);
    } else {
      // Routes.instance.navigateTo(context, Routes.login_page);
      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RegPageAndLoginPage();
                                },
                              ),
                            );
      AppConfig.token = '';
      DialogUtil.buildToast("请求失败~");
    }
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      width: AppSize.width(70),
      height: AppSize.width(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.countNum}'),
    );
  }
}
