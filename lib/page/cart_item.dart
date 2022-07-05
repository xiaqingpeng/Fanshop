import 'package:LinJia/page/reg_and_login.dart';
import 'package:flutter/material.dart';
import 'package:LinJia/common.dart';
import 'package:LinJia/dao/clear_goods_dao.dart';
import 'package:LinJia/models/cart_goods_query_entity.dart';
import 'package:LinJia/models/msg_entity.dart';
import 'package:LinJia/page/count_item.dart';

import 'package:LinJia/receiver/event_bus.dart';
import 'package:LinJia/utils/app_size.dart';
import 'package:LinJia/utils/dialog_utils.dart';
import 'package:LinJia/view/theme_ui.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class CartItem extends StatelessWidget {
  final List<GoodsModel> goodsModels;
  CartItem(this.goodsModels);
  String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  @override
  Widget build(BuildContext context) {
//    print(item);
    return Container(
        margin: EdgeInsets.only(top: 5.0),
        padding: EdgeInsets.all(3.0),
        child: _buildWidget(context));
  }

  Widget _buildWidget(BuildContext context) {
    List<Widget> mGoodsCard = [];
    Widget content;
    for (int i = 0; i < goodsModels.length; i++) {
      mGoodsCard.add(Slidable(
        key: Key(i.toString()),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          height: AppSize.height(350),
          margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _cartCheckBt(context, goodsModels[i]),
              _cartImage(goodsModels[i]),
              _cartGoodsName(goodsModels[i], AppConfig.token),
            ],
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: '移除',
            color: Colors.red,
            icon: Icons.delete,
            closeOnTap: true,
            onTap: () {
              showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('提示？'),
                      content: Text('确定移除该商品吗？'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text('取消'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        ElevatedButton(
                          child: Text('确定'),
                          onPressed: () {
                            loadClearGoods(context, goodsModels[i].orderId,
                                AppConfig.token, i);
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ));
    }
    mGoodsCard.add(Container(
      height: AppSize.height(140),
    ));
    content = Column(
      children: mGoodsCard,
    );
    return content;
  }

  void loadClearGoods(
      BuildContext context, String orderId, String token, int index) async {
    MsgEntity? entity = await ClearDao.fetch(orderId, token);
    if (entity?.msgModel != null) {
      if (entity?.msgModel.code == 20000) {
        Navigator.of(context).pop(true);
        goodsModels.removeAt(index);
        eventBus.fire(new GoodsNumInEvent("clear"));
      }
      DialogUtil.buildToast(entity!.msgModel.msg);
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

  //多选按钮
  Widget _cartCheckBt(BuildContext context, GoodsModel item) {
    return Expanded(
      child: Container(
          width: AppSize.width(150),
          height: AppSize.height(232),
          child: Checkbox(
            value: item.isCheck,
            activeColor: Colors.pink,
            onChanged: (val) {
              item.isCheck = val!;
              eventBus.fire(new GoodsNumInEvent("state"));
            },
          )),
      flex: 1,
    );
  }

  //商品图片
  Widget _cartImage(GoodsModel item) {
    return Container(
      width: AppSize.height(232),
      height: AppSize.height(232),
      margin: EdgeInsets.only(left: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        child: Image.network(
          imgUrl + item.pic,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //商品名称
  Widget _cartGoodsName(GoodsModel item, String token) {
    return Expanded(
      child: Container(
        width: AppSize.width(350),
        margin: EdgeInsets.only(left: 10.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(item.name,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: ThemeTextStyle.cardTitleStyle),
            Text(item.descript,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: ThemeTextStyle.cardTitleStyle),
            Text('￥${(item.price / 100).toStringAsFixed(2)}',
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.left,
                style: ThemeTextStyle.cardPriceStyle),
            CartCount(item)
          ],
        ),
      ),
      flex: 3,
    );
  }
}
