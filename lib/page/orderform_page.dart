import 'dart:async';
import 'package:LinJia/page/reg_and_login.dart';
import 'package:flutter/material.dart';
import 'package:LinJia/common.dart';
import 'package:LinJia/dao/get_order_dao.dart';

import 'package:LinJia/models/order_entity.dart';
import 'package:LinJia/page/card_order.dart';

import 'package:LinJia/receiver/event_bus.dart';
import 'package:LinJia/utils/dialog_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:LinJia/utils/app_size.dart';
import 'package:LinJia/view/app_topbar.dart';
import 'package:LinJia/view/customize_appbar.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'load_state_layout.dart';

///
/// app 订单页
///
class OrderFormPage extends StatefulWidget {
  @override
  _OrderFormPageState createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  double width = 0;
  final List<Tab> myTabs = <Tab>[
    Tab(text: '待付款'),
    Tab(text: '待发货'),
    Tab(text: '已发货'),
    Tab(text: '已完成'),
  ];

  // final ValueNotifier<OrderFormEntity> orderFormData =
  //     ValueNotifier<OrderFormEntity>();

  late List<Widget> bodys;

  void _initTabView() {
    bodys = List<Widget>.generate(myTabs.length, (i) {
      return OrderFormTabView(i);
    });
  }

  late TabController mController;

  @override
  void initState() {
    _initTabView();
    mController = TabController(
      length: myTabs.length,
      vsync: this,
      initialIndex: AppConfig.orderIndex,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppSize.init(context);
    final screenWidth = ScreenUtil.screenWidth;
    if (myTabs.length > 0) {
      width = (screenWidth / (myTabs.length * 2)) - 65;
    }
    return Scaffold(
      appBar: MyAppBar(
        key: GlobalKey(),
        preferredSize: Size.fromHeight(AppSize.height(160)),
        child:
            CommonBackTopBar(title: "订单", onBack: () => Navigator.pop(context)),
      ),
      body: Container(
        color: Color(0xfff5f6f7),
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
                    labelColor: Color(0xFFFF7095),
                    indicatorColor: Color(0xFFFF7095),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 1.0,
                    unselectedLabelColor: Color(0xff333333),
                    labelStyle: TextStyle(fontSize: AppSize.sp(44)),
                    indicatorPadding: EdgeInsets.only(
                        left: AppSize.width(width),
                        right: AppSize.width(width)),
                    labelPadding: EdgeInsets.only(
                        left: AppSize.width(width),
                        right: AppSize.width(width)),
                    tabs: myTabs,
                  ),
                )
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
    );
  }

  @override
  // ignore: todo
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class OrderFormTabView extends StatefulWidget {
  final int currentIndex;

  OrderFormTabView(this.currentIndex);

  @override
  _OrderFormTabViewState createState() => _OrderFormTabViewState();
}

class _OrderFormTabViewState extends State<OrderFormTabView> {
  GlobalKey _headerKey = GlobalKey();
  GlobalKey _footerKey = GlobalKey();
  LoadState _layoutState = LoadState.State_Loading;
  List<OrderModel> listData = [];
  int page = 1;
  late StreamSubscription _failSubscription;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getOrder());
  }

  void getOrder() {
    switch (widget.currentIndex) {
      case 0:
        loadData(1, page, AppConfig.token);
        break;
      case 1:
        loadData(2, page, AppConfig.token);
        break;
      case 2:
        loadData(3, page, AppConfig.token);
        break;
      case 3:
        loadData(4, page, AppConfig.token);
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _failSubscription.cancel();
  }

  void loadData(int status, int page, String token) async {
    OrderEntity? entity = await OrderQueryDao.fetch(status, page, token);

    if (entity?.orderModel != null) {
      if (entity!.orderModel.length > 0) {
        List<OrderModel> orderModelTmp = [];
        entity.orderModel.forEach((el) {
          orderModelTmp.add(el);
        });
        if (mounted) {
          setState(() {
            _layoutState = LoadState.State_Success;
            listData.clear();
            listData.addAll(orderModelTmp);
          });
        }
      } else {
        if (mounted) {
          if (page == 1) {
            setState(() {
              _layoutState = LoadState.State_Empty;
            });
          } else {
            DialogUtil.buildToast('没有更多数据');
          }
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _layoutState = LoadState.State_Error;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return LoadStateLayout(
        key: GlobalKey(),
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          getOrder();
        }, //错误按钮点击过后进行重新加载
        successWidget: _getContent());
  }

  Widget _getContent() {
    return Container(
      margin: EdgeInsets.only(top: AppSize.height(30)),
      child: EasyRefresh(
          header: MaterialHeader(
            key: _headerKey,
          ),
          footer: MaterialFooter(
            key: _footerKey,
          ),
          onRefresh: () async {
            page = 1;
            getOrder();
          },
          onLoad: () async {
            page++;
            getOrder();
          },
          child: SingleChildScrollView(
            child: OrderCard(key: GlobalKey(), orderModleDataList: listData),
          )),
    );
  }

  void _listen() {
    _failSubscription = eventBus.on<UserLoggedInEvent>().listen((event) {
      if ("fail" == event.text && !AppConfig.isUser) {
        AppConfig.isUser = true;
        DialogUtil.buildToast("请求失败~");
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RegPageAndLoginPage();
                                },
                              ),
                            );
        // Routes.instance.navigateTo(context, Routes.login_page);
        AppConfig.token = '';
        setState(() {
          _layoutState = LoadState.State_Error;
        });
      }
    });
  }
}
