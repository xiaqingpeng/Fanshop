import 'dart:async';

import 'package:LinJia/page/goodsmanger/shipping_edit_address.dart';
import 'package:LinJia/page/goodsmanger/shipping_save_address.dart';
import 'package:LinJia/page/reg_and_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LinJia/common.dart';
import 'package:LinJia/dao/shipping_address_dao.dart';
import 'package:LinJia/models/shipping_entity.dart';
import 'package:LinJia/page/load_state_layout.dart';

import 'package:LinJia/receiver/event_bus.dart';
// import 'package:LinJia/routes/routes.dart';
import 'package:LinJia/utils/app_size.dart';
import 'package:LinJia/utils/dialog_utils.dart';
import 'package:LinJia/view/app_topbar.dart';
import 'package:LinJia/view/customize_appbar.dart';
import 'package:LinJia/view/theme_ui.dart';

class ShippingAddressPage extends StatefulWidget {
  @override
  _ShippingAddressPageState createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  LoadState _layoutState = LoadState.State_Loading;
  List<ShippingAddressModel> shippingAddress = [];
  bool _isLoading = false;
  int _radioGroupAddress = 0;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Future.microtask(() => loadData());
  }

  void loadData() async {
    ShippingAddresEntry? entity =
        await ShippingAddressDao.fetch(AppConfig.token);

    if (entity?.shippingAddressModels != null) {
      if (entity!.shippingAddressModels.length > 0) {
        List<ShippingAddressModel> shippingAddressTemp = [];
        for (int i = 0; i < entity.shippingAddressModels.length; i++) {
          if (entity.shippingAddressModels[i].isDefault) {
            _radioGroupAddress = i;
          }
          shippingAddressTemp.add(entity.shippingAddressModels[i]);
        }

        if (mounted) {
          setState(() {
            _isLoading = false;
            _layoutState = LoadState.State_Success;
            shippingAddress.clear();
            shippingAddress.addAll(shippingAddressTemp);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _layoutState = LoadState.State_Empty;
          });
        }
      }
    } else {
      if (mounted) {
        AppConfig.token = '';
        DialogUtil.buildToast('token失败');
        // Routes.instance.navigateTo(context, Routes.login_page);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return RegPageAndLoginPage();
            },
          ),
        );

        setState(() {
          _layoutState = LoadState.State_Error;
        });
      }
    }
  }

  void _handleRadioValueChanged(int value) {
    setState(() {
      _radioGroupAddress = value;
    });
  }

  Widget _btnBottom() {
    return InkWell(
      onTap: () {
        if (AppConfig.token.isNotEmpty) {
          // Routes.instance.navigateTo(context, Routes.new_address_page);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ShippingSaveAddressPage();
              },
            ),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: AppSize.width(1080),
        height: AppSize.height(160),
        color: Colors.red,
        child: Text(
          '新增地址',
          style: TextStyle(color: Colors.white, fontSize: AppSize.sp(54)),
        ),
      ),
    );
  }

  Widget _getContent() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Stack(
        children: <Widget>[
          ListView.builder(
              itemCount: shippingAddress.length,
              itemBuilder: (context, index) {
                return _buildItemAdress(index);
              }),
          Positioned(bottom: 0, left: 0, child: _btnBottom())
        ],
      );
    }
  }

  Widget _buildItemAdress(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: AppSize.height(140.0),
      color: Colors.white,
      width: AppSize.width(1080),
      child: Row(
        children: <Widget>[
          Checkbox(
              value: _radioGroupAddress == index,
              activeColor: Colors.pink,
              onChanged: (val) {
                _handleRadioValueChanged(index);
              }),
          Text(shippingAddress[index].name + '   ' + shippingAddress[index].tel,
              style: ThemeTextStyle.personalShopNameStyle),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                    width: AppSize.width(128),
                    child: IconButton(
                      icon: Icon(CupertinoIcons.create, size: 30),
                      onPressed: () {
                        String id = shippingAddress[index].id;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ShippingEditAddressPage(
                                id: id,
                              );
                            },
                          ),
                        );
                      },
                      color: Colors.blueAccent,
                      highlightColor: Colors.red,
                    ),
                  )),
              flex: 1)
        ],
      ),
    );
  }

  late StreamSubscription _saveSubscription;

  ///监听Bus events
  void _listen() {
    _saveSubscription = eventBus.on<OrderInEvent>().listen((event) {
      if ("succuss" == event.text) {
        loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppSize.init(context);
    _listen();
    return Scaffold(
        appBar: MyAppBar(
          key: GlobalKey(),
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: CommonBackTopBar(
              title: "收货地址", onBack: () => Navigator.pop(context)),
        ),
        body: LoadStateLayout(
            key: GlobalKey(),
            state: _layoutState,
            errorRetry: () {
              setState(() {
                _layoutState = LoadState.State_Loading;
              });
              _isLoading = true;
              loadData();
            },
            successWidget: _getContent()));
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();

    _saveSubscription.cancel();
  }
}
