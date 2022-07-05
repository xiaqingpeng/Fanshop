import 'package:LinJia/page/details/topic_details.dart';
import 'package:flutter/material.dart';
import 'package:LinJia/models/topic_goods_query_entity.dart';

import 'package:LinJia/utils/app_size.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: must_be_immutable
class TopicCardGoods extends StatelessWidget {
  final List<TopicGoodsListModel> topicGoodsModleDataList;
  String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";

  TopicCardGoods({required Key key, required this.topicGoodsModleDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5.0),
      padding: EdgeInsets.all(3.0),
      child: _buildWidget(context),
    );
  }

  Row _buildRow(BuildContext context,
      List<TopicGoodsListModel> subTopicGoodsModleDataList) {
    List<Widget> mSubGoodsCard = [];
    final screenWidth = ScreenUtil.screenWidth;

    for (int i = 0; i < subTopicGoodsModleDataList.length; i++) {
      String id = subTopicGoodsModleDataList[i].id;
      if (i == 0) {
        mSubGoodsCard.add(
          InkWell(
            onTap: () {
              onItemClick(context, i, id);
            },
            child: Container(
              width: AppSize.width(screenWidth / 2 - 21),
              height: AppSize.height(230),
              child: Image.network(
                imgUrl + "${subTopicGoodsModleDataList[0].topicGoodsModel.img}",
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      } else {
        mSubGoodsCard.add(
          InkWell(
            onTap: () {
              onItemClick(context, i, id);
            },
            child: Container(
              width: AppSize.width(screenWidth / 4 - 30),
              height: AppSize.height(230),
              child: Image.network(
                imgUrl + "${subTopicGoodsModleDataList[i].topicGoodsModel.img}",
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      }
    }

    return Row(
      children: mSubGoodsCard,
    );
  }

  void onItemClick(BuildContext context, int i, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TopicDetails(id: id);
        },
      ),
    );
  }

  Widget _buildWidget(BuildContext context) {
    List<Row> mTopCard = [];
    Widget content;
    List<TopicGoodsListModel> sub = [];
    for (int i = 0; i < topicGoodsModleDataList.length; i++) {
      if ((i + 1) % 3 == 1) {
        sub.add(topicGoodsModleDataList[i]);
        if (i == topicGoodsModleDataList.length - 1) {
          mTopCard.add(
            _buildRow(context, sub),
          );
          sub.clear();
        }
      }
      if ((i + 1) % 3 == 2) {
        sub.add(topicGoodsModleDataList[i]);
        if (i == topicGoodsModleDataList.length - 1) {
          mTopCard.add(
            _buildRow(context, sub),
          );
          sub.clear();
        }
      }
      if ((i + 1) % 3 == 0) {
        sub.add(topicGoodsModleDataList[i]);
        mTopCard.add(
          _buildRow(context, sub),
        );
        sub.clear();
      }
    }

    content = Column(
      children: mTopCard,
    );
    return content;
  }
}
