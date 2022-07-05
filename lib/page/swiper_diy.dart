import 'package:LinJia/page/details/product_details.dart';
import 'package:LinJia/page/web_page.dart';
import 'package:flutter/material.dart';
import 'package:LinJia/models/category_entity.dart';
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';

/**
 * 轮播组件
 */
class SwiperDiy extends StatelessWidget {
  final List<CategoryInfoModel> swiperDataList;
  final double height;
  final double width;

  String imgUrl =
      "http://linjiashop-mobile-api.microapp.store/file/getImgStream?idFile=";
  SwiperDiy({required Key key, required this.swiperDataList, required this.height, required this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: InkWell(
                onTap: () {
                  if (swiperDataList[index].page.isNotEmpty) {
                    if (swiperDataList[index].page.startsWith("http") ||
                        swiperDataList[index].page.startsWith("https")) {
                      _goWeb(context, swiperDataList[index].page);
                    } else if ("goods" == swiperDataList[index].page) {
                      Map<String, dynamic> result =
                          jsonDecode(swiperDataList[index].param);
                      if (result.containsKey("id")) {
                        _goDetail(context, result['id'].toString());
                      }
                    }
                  }
                },
                child: Image.network(
                  imgUrl + "${swiperDataList[index].idFile}",
                  fit: BoxFit.cover,
                ),
              ));
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(margin: EdgeInsets.all(1.0)),
        autoplay: true,
      ),
    );
  }

  void _goWeb(BuildContext context, String url) {
    Map<String, String> p = {"url": url};
    // Routes.instance.navigateToParams(context, Routes.web_page, params: p);
    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return WebViewPage(url: p['url'].toString(),);
                                },
                              ),
                            );
  }

  void _goDetail(BuildContext context, String id) {
    Map<String, String> p = {"id": id};
    // Routes.instance
    //     .navigateToParams(context, Routes.PRODUCT_DETAILS, params: p);
        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return ProductDetails(id:p['id'].toString());
                                },
                              ),
                            );
  }
}
