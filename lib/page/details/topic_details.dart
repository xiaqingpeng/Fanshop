import 'package:flutter/material.dart';

import 'package:LinJia/dao/topic_details_dao.dart';

import 'package:LinJia/models/topic_details_entity.dart';

import 'package:LinJia/page/load_state_layout.dart';
import 'package:LinJia/page/topic_deatails_goods.dart';
import 'package:LinJia/utils/app_size.dart';
import 'package:LinJia/view/app_topbar.dart';
import 'package:LinJia/view/customize_appbar.dart';
import 'package:LinJia/view/theme_ui.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';

///
/// 推荐详情页
///
class TopicDetails extends StatefulWidget {
  final String id;

  TopicDetails({required this.id});

  @override
  _TopicDetailsState createState() => _TopicDetailsState();
}

class _TopicDetailsState extends State<TopicDetails> {
  final String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  LoadState _loadStateDetails = LoadState.State_Loading;
  late TopicDetailsEntity? topicDetailsEntity = (() {
    TopicDetailsDao.fetch(widget.id.toString());
  })();

  @override
  void initState() {
    if (mounted) loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadData() async {
    TopicDetailsEntity? entity = await TopicDetailsDao.fetch(
      widget.id.toString(),
    );
    setState(
      () {
        topicDetailsEntity =
            entity == null ? TopicDetailsEntity.fromJson({}) : entity;
        _loadStateDetails =
            entity == null ? LoadState.State_Error : LoadState.State_Success;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Scaffold(
      appBar: MyAppBar(
          key: GlobalKey(),
          preferredSize: Size.fromHeight(AppSize.height(160)),
          child: CommonBackTopBar(
            title: topicDetailsEntity == null
                ? "详情"
                : topicDetailsEntity!.articleModel.title,
            onBack: () => Navigator.pop(context),
          ),),
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

  ///返回内容
  Widget _getContent() {
    // ignore: unnecessary_null_comparison
    if (topicDetailsEntity!.goodsList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: AppSize.height(94),
            child: Text(
              topicDetailsEntity!.articleModel.title,
              textAlign: TextAlign.center,
              style: ThemeTextStyle.personalShopNameStyle,
            ),
          ),
          Html(data: topicDetailsEntity!.articleModel.content),
          TopicDeatilsCardGoods(
              key: GlobalKey(), topicGoods: topicDetailsEntity!.goodsList)
        ],
      );
    }
  }
}
