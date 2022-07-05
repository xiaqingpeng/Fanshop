import 'package:flutter/material.dart';
import 'package:LinJia/common.dart';
import 'package:LinJia/dao/hot_goods_dao.dart';
import 'package:LinJia/dao/new_goods_dao.dart';
import 'package:LinJia/dao/shop_home_category.dart';
import 'package:LinJia/dao/topic_query_dao.dart';
import 'package:LinJia/models/category_entity.dart';
import 'package:LinJia/models/hot_entity.dart';
import 'package:LinJia/models/topic_goods_query_entity.dart';
import 'package:LinJia/page/load_state_layout.dart';
import 'package:LinJia/page/swiper_diy.dart';
import 'package:LinJia/page/home/topic_card_goods.dart';
import 'package:LinJia/res/colours.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:LinJia/dao/findings_dao.dart';
import 'package:LinJia/models/goods_entity.dart';
import 'package:LinJia/utils/app_size.dart';
import 'package:LinJia/view/app_topbar.dart';
import 'package:LinJia/view/customize_appbar.dart';
import 'package:LinJia/view/theme_ui.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'card_goods.dart';

/**
 * app 首页
 */

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<Tab> myTabs = <Tab>[];
  List<FindingTabView> bodys = [];
  late TabController? mController = TabController(length: 4, vsync: this);
  HomeData topicData = HomeData.topic;
  HomeData cateGoryData = HomeData.cateGory;
  LoadState _layoutState = LoadState.State_Loading;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppSize.init(context);
    final screenWidth = ScreenUtil.screenWidth;
    if (myTabs.length > 0) {
      width = (screenWidth / (myTabs.length * 2)) - 45;
    }
    return Scaffold(
      appBar: MyAppBar(
        key: GlobalKey(),
        preferredSize: Size.fromHeight(
          AppSize.height(160),
        ),
        child: CommonTopBar(title: "邻家小铺"),
      ),
      body: LoadStateLayout(
        key: GlobalKey(),
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          loadCateGoryData();
        },
        successWidget: Container(
          color: ThemeColor.appBg,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: AppSize.height(120),
                child: Row(children: <Widget>[
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
                      controller: mController,
                      labelColor: Colours.lable_clour,
                      indicatorColor: Colours.lable_clour,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 1.0,
                      unselectedLabelColor: Color(0xff333333),
                      labelStyle: TextStyle(
                        fontSize: AppSize.sp(44),
                      ),
                      indicatorPadding: EdgeInsets.only(
                          left: AppSize.width(width),
                          right: AppSize.width(width)),
                      labelPadding: EdgeInsets.only(
                        left: AppSize.width(width),
                        right: AppSize.width(width),
                      ),
                      tabs: myTabs,
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: TabBarView(
                  controller: mController,
                  children: bodys,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadCateGoryData();
  }

  /**
   * 加载大类列表和标签
   */
  void loadCateGoryData() async {
    CategoryEntity? entity = await ShopHomeCategoryDao.fetch();
    if (entity?.category != null) {
      List<Tab> myTabsTmp = <Tab>[];
      myTabsTmp.add(Tab(text: '推荐'));
      List<FindingTabView> bodysTmp = [];
      bodysTmp.add(
        FindingTabView(
          topic: topicData,
          categoryInfoModels: [],
          currentPage: 0,
          id: '',
        ),
      );

      for (int i = 0; i < entity!.category.length; i++) {
        CategoryModel model = entity.category[i];
        myTabsTmp.add(
          Tab(text: model.name),
        );
        bodysTmp.add(
          FindingTabView(
            currentPage: i,
            id: model.id,
            categoryInfoModels: model.categoryInfoModels,
            topic: cateGoryData,
          ),
        );
      }
      setState(
        () {
          myTabs.addAll(myTabsTmp);
          bodys.addAll(bodysTmp);
          mController = TabController(
            length: myTabs.length,
            vsync: this,
          );
          _layoutState = LoadState.State_Success;
        },
      );
    } else {
      setState(
        () {
          _layoutState = LoadState.State_Error;
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (null != mController) {
      mController!.dispose();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

/**
 * 类别子页面
 */
class FindingTabView extends StatefulWidget {
  final int currentPage;
  final String id;
  final List<CategoryInfoModel> categoryInfoModels;

  /**
   * 0,表示推荐
   * 1，表示分类
   */
  final HomeData topic;

  FindingTabView(
      {required this.currentPage,
      required this.id,
      required this.categoryInfoModels,
      required this.topic});

  @override
  _FindingTabViewState createState() => _FindingTabViewState();
}

class _FindingTabViewState extends State<FindingTabView>
    with AutomaticKeepAliveClientMixin {
  GlobalKey _headerKey = GlobalKey();
  GlobalKey _footerKey = GlobalKey();
  LoadState _layoutState = LoadState.State_Loading;
  List<GoodsModel> goodsList = <GoodsModel>[];
  List<TopicGoodsListModel> topGoodsList = <TopicGoodsListModel>[];

  ///新品推荐
  List<GoodsModel> newGoodsList = <GoodsModel>[];

  ///热门推荐
  List<GoodsModel> hotGoodsList = <GoodsModel>[];
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    if (widget.topic == HomeData.topic) {
      loadTopicData();
    }
    if (widget.topic == HomeData.cateGory) {
      loadData(widget.id);
    }
    super.initState();
  }

  /**
   * 加载推荐数据
   */
  void loadTopicData() async {
    TopicGoodsQueryEntity? entity = await TopicQueryDao.fetch();
    if (entity?.topicGoods != null) {
      if (mounted) {
        setState(() {
          topGoodsList.clear();
          topGoodsList = entity!.topicGoods;
          _isLoading = false;
          if (topGoodsList.length > 0) {
            _layoutState = LoadState.State_Success;
          }
          loadHotData();
        });
      }
    } else {
      setState(() {
        _layoutState = LoadState.State_Error;
      });
    }
  }

  void loadHotData() async {
    HotEntity? entity = await HotGoodsDao.fetch();
    if (entity?.goods != null) {
      setState(() {
        hotGoodsList.clear();
        hotGoodsList = entity!.goods;
        _isLoading = false;
        if (hotGoodsList.length > 0) {
          _layoutState = LoadState.State_Success;
        }
        loadNewData();
      });
    } else {
      setState(() {
        _layoutState = LoadState.State_Error;
      });
    }
  }

  void loadNewData() async {
    HotEntity? entity = await NewGoodsDao.fetch();
    if (entity?.goods != null) {
      setState(() {
        newGoodsList.clear();
        newGoodsList = entity!.goods;
        _isLoading = false;
        if (newGoodsList.length > 0) {
          _layoutState = LoadState.State_Success;
        }
      });
    } else {
      setState(() {
        _layoutState = LoadState.State_Error;
      });
    }
  }

  /**
   * 加载分类数据
   */
  void loadData(String id) async {
    GoodsEntity? entity = await FindingsDao.fetch(id);
    if (entity?.goods != null) {
      if (mounted) {
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
      }
    } else {
      setState(() {
        _layoutState = LoadState.State_Error;
      });
    }
  }

  Widget _getHotData() {
    return hotGoodsList.length > 0
        ? Container(
            child: Column(
              children: <Widget>[
                Container(
                    color: Colours.white,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    height: AppSize.height(94),
                    padding: EdgeInsets.only(left: 10, top: 7),
                    child: Text(
                      '热门推荐',
                      style: ThemeTextStyle.orderFormTitleStyle,
                    )),
                ThemeView.divider(),
                CardGoods(key: GlobalKey(), goodsModleDataList: hotGoodsList)
              ],
            ),
          )
        : Container();
  }

  Widget _getNewData() {
    return newGoodsList.length > 0
        ? Container(
            child: Column(
              children: <Widget>[
                Container(
                    color: Colours.white,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    height: AppSize.height(94),
                    padding: EdgeInsets.only(left: 10, top: 7),
                    child: Text(
                      '新品推荐',
                      style: ThemeTextStyle.orderFormTitleStyle,
                    )),
                ThemeView.divider(),
                CardGoods(key: GlobalKey(), goodsModleDataList: newGoodsList)
              ],
            ),
          )
        : Container();
  }

  Widget _getHomeDataType() {
    ///返回推荐数据
    if (widget.topic == HomeData.topic) {
      return ListView(
        children: <Widget>[
          topGoodsList.length > 0
              ? TopicCardGoods(
                  key: GlobalKey(), topicGoodsModleDataList: topGoodsList)
              : Container(),
          _getHotData(), //热门推荐
          _getNewData() // 新品推荐
        ],
      );
    }

    ///返回项目数据
    if (widget.topic == HomeData.cateGory) {
      return ListView(
        children: <Widget>[
          SwiperDiy(
            key: GlobalKey(),
            swiperDataList: widget.categoryInfoModels,
            width: double.infinity,
            height: AppSize.height(430),
          ),
          CardGoods(key: GlobalKey(), goodsModleDataList: goodsList)
        ],
      );
    }
    return Row();
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
          right: AppSize.width(30),
        ),
        child: EasyRefresh(
          header: MaterialHeader(
            key: _headerKey,
          ),
          footer: MaterialFooter(
            key: _footerKey,
          ),
          child: _getHomeDataType(),
          onRefresh: () async {
            _isLoading = true;
            if (widget.topic == HomeData.topic) {
              loadTopicData();
            }
            if (widget.topic == HomeData.cateGory) {
              loadData(widget.id);
            }
          },
          onLoad: () async {},
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadStateLayout(
      key: GlobalKey(),
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        if (widget.topic == HomeData.topic) {
          loadTopicData();
        }
        if (widget.topic == HomeData.cateGory) {
          loadData(widget.id);
        }
      }, //错误按钮点击过后进行重新加载
      successWidget: _getContent(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
