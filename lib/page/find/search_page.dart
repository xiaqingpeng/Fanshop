import 'package:flutter/material.dart';
import 'package:LinJia/dao/hot_goods_dao.dart';
import 'package:LinJia/dao/search_dao.dart';
import 'package:LinJia/models/hot_entity.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:LinJia/view/customize_appbar.dart';
import '../../models/goods_entity.dart';
import '../../utils/app_size.dart';
import '../../view/app_topbar.dart';
import '../home/card_goods.dart';
import '../load_state_layout.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  LoadState _layoutState = LoadState.State_Loading;
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  List<GoodsModel> goodsList = <GoodsModel>[];
  String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppSize.init(context);

    return Scaffold(
        appBar: MyAppBar(
          key: GlobalKey(),
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: SearchBar(
              focusNode: _focusNode,
              controller: _controller,
              onChangedCallback: () async {
                var key = _controller.text;
                if (key.isEmpty) {
                  loadData();
                } else {
                  _doSearch(key.toString());
                }
              }),
        ),
        body: LoadStateLayout(
            key: GlobalKey(),
            state: _layoutState,
            errorRetry: () {
              setState(() {
                _layoutState = LoadState.State_Loading;
              });
              _isLoading = true;
              var key = _controller.text;
              if (key.isEmpty) {
                loadData();
              } else {
                _doSearch(key.toString());
              }
            }, //错误按钮点击过后进行重新加载
            successWidget: _getContent()));
  }

  GlobalKey _headerKey = GlobalKey();
  GlobalKey _footerKey = GlobalKey();

  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    loadData();
    super.initState();
  }

  void _doSearch(String key) async {
    _isLoading = true;
    HotEntity? entity = await SearchDao.fetch(key);
    if (entity?.goods != null) {
      setState(() {
        goodsList.clear();
        goodsList = entity!.goods;
        _isLoading = false;
        if (goodsList.length > 0) {
          _layoutState = LoadState.State_Success;
        } else {
          _layoutState = LoadState.State_Empty;
        }
      });
    } else {
      setState(() {
        _layoutState = LoadState.State_Error;
      });
    }
  }

  /**
   * 加载热门商品
   */

  void loadData() async {
    HotEntity? entity = await HotGoodsDao.fetch();
    if (entity?.goods != null) {
      setState(() {
        goodsList.clear();
        goodsList = entity!.goods;
        _isLoading = false;
        if (goodsList.length > 0) {
          _layoutState = LoadState.State_Success;
        } else {
          _layoutState = LoadState.State_Empty;
        }
      });
    } else {
      setState(() {
        _layoutState = LoadState.State_Error;
      });
    }
  }

  Widget _getContent() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(
            top: AppSize.width(30),
            left: AppSize.width(30),
            right: AppSize.width(30)),
        child: EasyRefresh(
            header: MaterialHeader(
              key: _headerKey,
            ),
            footer: MaterialFooter(
              key: _footerKey,
            ),
            child: SingleChildScrollView(
                child:
                    CardGoods(key: GlobalKey(), goodsModleDataList: goodsList)),
            onRefresh: () async {
              _isLoading = true;
              var name = _controller.text;
              if (name.isEmpty) {
                loadData();
              } else {
                _doSearch(name.toString());
              }
            },
            onLoad: () async {}),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
