import 'package:LinJia/page/details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:LinJia/models/topic_details_entity.dart';
import 'package:LinJia/res/colours.dart';
import 'package:LinJia/utils/app_size.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 主题详情推荐
 */
// ignore: must_be_immutable
class TopicDeatilsCardGoods extends StatelessWidget {
  final List<TopGoods> topicGoods;
  String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";

  TopicDeatilsCardGoods({required Key key, required this.topicGoods})
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

  Widget _buildWidget(BuildContext context) {
    List<Row> mTopCard = [];
    Widget content;
    List<TopGoods> sub = [];
    for (int i = 0; i < topicGoods.length; i++) {
      if ((i + 1) % 2 == 1) {
        sub.add(topicGoods[i]);
        if (i == topicGoods.length - 1) {
          mTopCard.add(
            _buildRow(context, sub),
          );
          sub.clear();
        }
      }
      if ((i + 1) % 2 == 0) {
        sub.add(topicGoods[i]);
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

  Row _buildRow(BuildContext context, List<TopGoods> sub) {
    List<Widget> mSubGoodsCard = [];
    final screenWidth = ScreenUtil.screenWidth;

    for (int i = 0; i < sub.length; i++) {
      String pic = sub[i].pic;
      String name = sub[i].name;
      String id = sub[i].id;
      mSubGoodsCard.add(
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductDetails(
                    id: id.toString(),
                  );
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                width: AppSize.width(screenWidth / 2 - 28),
                height: AppSize.height(360),
                margin: EdgeInsets.all(3.0),
                child: Image.network(
                  imgUrl + pic,
                  fit: BoxFit.fill,
                  errorBuilder: (ctx, err, stackTrace) => Image.asset(
                    'images/banner.jpg', //默认显示图片
                    width: AppSize.width(screenWidth / 2 - 28),
                    height: AppSize.height(360),
                  ),
                ),
              ),
              Container(
                width: AppSize.width(screenWidth / 2 - 28),
                height: AppSize.height(48),
                color: Colours.gray_99,
                child: Center(
                  child: Text(
                    name,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppSize.sp(42),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Row(
      children: mSubGoodsCard,
    );
  }
}
