import 'dart:async';

import 'package:LinJia/page/index_page.dart';
import 'package:LinJia/page/reg_and_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LinJia/common.dart';

import 'package:LinJia/dao/add_goods_cart_dao.dart';
import 'package:LinJia/dao/add_like_dao.dart';
import 'package:LinJia/dao/cart_query_dao.dart';
import 'package:LinJia/dao/details_dao.dart';
import 'package:LinJia/dao/is_like_dao.dart';
import 'package:LinJia/models/cart_entity.dart';
import 'package:LinJia/models/cart_goods_query_entity.dart';
import 'package:LinJia/models/details_entity.dart';
import 'package:LinJia/models/msg_entity.dart';
import 'package:LinJia/models/msg_like_entity.dart';
import 'package:LinJia/page/details_top_area.dart';
import 'package:LinJia/page/load_state_layout.dart';
import 'package:LinJia/page/specifica_button.dart';

import 'package:LinJia/receiver/event_bus.dart';
import 'package:LinJia/res/colours.dart';
import 'package:LinJia/utils/app_size.dart';
import 'package:LinJia/utils/dialog_utils.dart';
import 'package:LinJia/view/app_topbar.dart';
import 'package:LinJia/view/custom_view.dart';
import 'package:LinJia/view/customize_appbar.dart';
import 'package:LinJia/view/theme_ui.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

///
/// 商品详情页
///
class ProductDetails extends StatefulWidget {
  final String id;

  ProductDetails({required this.id});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int num = 0;
  final String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  LoadState _loadStateDetails = LoadState.State_Loading;

  late GoodsModelDetail? goodsModel = (() {
    LikeDao.fetch(AppConfig.token, widget.id);
  })();

  late SkuModel skuModel;
  listModel model =
      listModel(code: '', id: '', map: {}, price: 0, stock_num: 0);
  late StreamSubscription _spcSubscription;

  @override
  void initState() {
    isLike = false;
    if (mounted) {
      loadData();
      loadLike();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _spcSubscription.cancel();
  }

  void loadLike() async {
    if (AppConfig.token.isNotEmpty) {
      MsgLikeEntity? entityLike =
          await LikeDao.fetch(AppConfig.token, widget.id);
      if (entityLike != null) {
        setState(() {
          isLike = entityLike.msgModel.data;
        });
      } else {
        DialogUtil.buildToast("失败");
      }
    }
  }

  ///监听Bus events
  void _listen() {
    _spcSubscription = eventBus.on<SpecEvent>().listen((event) {
      if (mounted) {
        skuModel.listModels.forEach((e) {
          if (e.code == event.code) {
            model = e;
          }
          setState(() {});
        });
      }
    });
  }

  late bool isLike;

  void loadData() async {
    if (mounted) {
      DetailsEntity? entity = await DetailsDao.fetch(widget.id.toString());
      if (entity?.goods != null) {
        goodsModel = entity!.goods.goodsModelDetail;
        urls.clear();
        if (goodsModel!.gallery.contains(",")) {
          urls = goodsModel!.gallery.split(",");
          setState(() {
            _loadStateDetails = LoadState.State_Success;
          });
        }
        skuModel = entity.goods.skuModel;
        if (skuModel.listModels.length > 0) {
          model = skuModel.listModels[0];
        }
      } else {
        setState(() {
          _loadStateDetails = LoadState.State_Error;
        });
      }
    }
  }

  List<String> urls = [];

  @override
  Widget build(BuildContext context) {
    _listen();
    AppSize.init(context);
    return Scaffold(
      appBar: MyAppBar(
        key: GlobalKey(),
        preferredSize: Size.fromHeight(AppSize.height(160)),
        child: _getHeader(),
      ),
      body: LoadStateLayout(
        key: GlobalKey(),
        state: _loadStateDetails,
        errorRetry: () {
          setState(() {
            _loadStateDetails = LoadState.State_Loading;
          });
          loadData();
        },
        successWidget: _getContent(),
      ),
    );
  }

  ///返回不同头部
  Widget _getHeader() {
    if (null == goodsModel) {
      return CommonBackTopBar(
          title: "详情", onBack: () => Navigator.pop(context));
    } else {
      return CommonBackTopBar(
          title: goodsModel!.name, onBack: () => Navigator.pop(context));
    }
  }

  Widget _getBody() {
    return goodsModel!.isOnSale
        ? Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  DetailsTopArea(
                      gallery: urls,
                      descript: goodsModel!.descript,
                      name: goodsModel!.name,
                      num: goodsModel!.num,
                      price: goodsModel!.price),
                  Html(data: goodsModel!.detail)
                ],
              ),
              Positioned(bottom: 0, left: 0, child: detailBottom())
            ],
          )
        : Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'images/ic_empty_shop.png',
                  height: 256,
                  width: 256,
                ),
                Text("该商品已下架"),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                      child: Material(
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25.0),
                            onTap: () {
                              // Routes.instance.navigateTo(context, Routes.ROOT);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return IndexPage();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: 300.0,
                              height: 50.0,
                              //设置child 居中
                              alignment: Alignment(0, 0),
                              child: Text(
                                "去看看其他商品",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          );
  }

  ///返回内容
  Widget _getContent() {
    if (null == goodsModel) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return _getBody();
    }
  }

  void addLike(String idGoods, String token) async {
    MsgEntity? entity = await AddLikeDao.fetch(token, idGoods);
    if (entity?.msgModel != null) {
      if (entity!.msgModel.code == 20000) {
        DialogUtil.buildToast("收藏成功");
        setState(() {
          isLike = true;
        });
      }
    } else {
      DialogUtil.buildToast("收藏失败");
    }
  }

  /**
   * 底部详情
   */
  Widget detailBottom() {
    return Container(
      width: AppSize.width(1500),
      color: Colors.white,
      height: AppSize.width(160),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (AppConfig.token.isEmpty) {
                    // Routes.instance.navigateTo(context, Routes.login_page);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return RegPageAndLoginPage();
                        },
                      ),
                    );
                    return;
                  }
                  eventBus.fire(IndexInEvent("2"));
                  Navigator.pop(context);
                },
                child: Container(
                  width: AppSize.width(300),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.red,
                  ),
                ),
              ),
              num == 0
                  ? Container()
                  : Positioned(
                      top: 0,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          num.toString(),
                          style: TextStyle(
                              color: Colors.white, fontSize: AppSize.sp(22)),
                        ),
                      ),
                    )
            ],
          ),
          Container(
            width: AppSize.width(1),
            height: AppSize.height(160),
            color: ThemeColor.subTextColor,
          ),
          InkWell(
            onTap: () {
              if (!isLike) {
                if (AppConfig.token.isEmpty) {
                  // Routes.instance.navigateTo(context, Routes.login_page);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return RegPageAndLoginPage();
                      },
                    ),
                  );
                  return;
                }
                addLike(widget.id, AppConfig.token);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppSize.width(30)),
              child: IconBtn(
                Icons.star_border,
                text: '收藏',
                textStyle: isLike
                    ? ThemeTextStyle.priceStyle
                    : ThemeTextStyle.orderContentStyle,
                iconColor:
                    isLike ? Colours.lable_clour : ThemeColor.subTextColor,
                func: (String) {},
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (AppConfig.token.isEmpty) {
                // Routes.instance.navigateTo(context, Routes.login_page);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return RegPageAndLoginPage();
                    },
                  ),
                );
                return;
              }
              showBottomMenu();
            },
            child: Container(
              alignment: Alignment.center,
              width: AppSize.width(350),
              height: AppSize.height(160),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white, fontSize: AppSize.sp(54)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (AppConfig.token.isEmpty) {
                // Routes.instance.navigateTo(context, Routes.login_page);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return RegPageAndLoginPage();
                    },
                  ),
                );
                return;
              }
              eventBus.fire(IndexInEvent("2"));
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              width: AppSize.width(350),
              height: AppSize.height(160),
              color: Colors.red,
              child: Text(
                '马上购买',
                style: TextStyle(color: Colors.white, fontSize: AppSize.sp(54)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addCart(String idGoods, int count, String idSku, String token) async {
    CartEntity? entity = await AddDao.fetch(idGoods, count, idSku, token);
    if (entity?.cartModel != null) {
      if (entity!.cartModel.code == 20000) {
        setState(() {
          num++;
        });
      }
      Navigator.pop(context);
      DialogUtil.buildToast(entity.cartModel.msg);
    } else {
      DialogUtil.buildToast("添加购物车失败");
    }
  }

  var descTextStyle1 =
      TextStyle(fontSize: AppSize.sp(35), color: ThemeColor.subTextColor);

  void showBottomMenu() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: skuModel.listModels.length == 0 ? 170.0 : 600.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.width(30),
                        vertical: AppSize.height(30)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: AppSize.width(30)),
                          child: Image.network(imgUrl + "${urls[0]}",
                              width: AppSize.width(220),
                              height: AppSize.width(220)),
                        ),
                        Expanded(child: buildInfo()),
                      ],
                    ),
                  ),
                  skuModel.listModels.length == 0
                      ? Container()
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: AppSize.width(30)),
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                  child: SpecificaButton(
                                      treeModel: skuModel.treeModel)),
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4, horizontal: AppSize.width(60)),
                          child: FloatingActionButton(
                            // highlightColor: ThemeColor.appBarBottomBg,
                            onPressed: () {
                              if (skuModel.listModels.length == 0) {
                                addCart(widget.id, 1, "", AppConfig.token);
                              } else {
                                addCart(
                                    widget.id, 1, model.id, AppConfig.token);
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            // textColor: Colors.white,
                            // color: ThemeColor.appBarTopBg,
                            child: Text('确定'),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    CupertinoIcons.clear_thick_circled,
                    size: 30,
                  ),
                ),
              ))
        ]);
      },
    );
  }

  Widget buildInfo() {
    return skuModel.listModels.length == 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(goodsModel!.name,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: ThemeTextStyle.primaryStyle),
              Text.rich(TextSpan(
                  text: "¥" + (goodsModel!.price / 100).toStringAsFixed(2),
                  style: ThemeTextStyle.cardPriceStyle,
                  children: [
                    TextSpan(text: '+', style: descTextStyle1),
                    TextSpan(text: '60'),
                    TextSpan(text: '积分', style: descTextStyle1)
                  ])),
              Text('库存:' + goodsModel!.num.toString(), style: descTextStyle1)
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(goodsModel!.name,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: ThemeTextStyle.primaryStyle),
              Text.rich(TextSpan(
                  text: "¥" + (model.price / 100).toStringAsFixed(2),
                  style: ThemeTextStyle.cardPriceStyle,
                  children: [
                    TextSpan(text: '+', style: descTextStyle1),
                    TextSpan(text: '60'),
                    TextSpan(text: '积分', style: descTextStyle1)
                  ])),
              Text('库存:' + model.stock_num.toString(), style: descTextStyle1)
            ],
          );
  }

  void loadCartData(String token) async {
    CartGoodsQueryEntity? entity = await CartQueryDao.fetch(token);
    if (entity?.goods != null) {
      int numTmp = 0;
      if (entity!.goods.length > 0) {
        entity.goods.forEach((el) {
          numTmp = numTmp + el.count;
        });

        ///更新总数
        setState(() {
          num = numTmp;
        });
      }
    } else {
      DialogUtil.buildToast("服务器错误1~");
    }
  }

  void clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
