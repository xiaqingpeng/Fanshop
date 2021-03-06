import 'package:flutter/material.dart';
import 'package:LinJia/res/colours.dart';

import 'package:LinJia/utils/app_size.dart';
import 'package:LinJia/view/theme_ui.dart';


typedef ImgBtnFunc = void Function(String);

// ignore: must_be_immutable
class ImageButton extends StatelessWidget {
 late  double width;
 late  double height;
 late  double iconSize;
 late  Color iconColor;

 late  String assetPath;
 late  String text;

 late  TextStyle textStyle;
 late  ImgBtnFunc func;

  ImageButton(this.assetPath,
      {required this.width,
      required this.height,
      required this.iconSize,
      required this.text,
      required this.textStyle,
      required this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func(text),
      child: SizedBox(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(assetPath),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(text, style: textStyle),
              )
            ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class IconBtn extends StatelessWidget {
  late double iconSize;
late Color iconColor;

 late final IconData icon;
 late String text;

  late TextStyle textStyle;
  late ImgBtnFunc func;

  IconBtn(this.icon, {required this.iconColor, required this.text, required this.textStyle, required this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func(text),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: iconColor),
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(text, style: textStyle),
            )
          ]),
    );
  }
}

/**
 * ????????????
 */

class ThemeCard extends StatelessWidget {
 late final String title;
 late final String price;
 late final String number;
 late final String imgUrl;
 late final String descript;
  ThemeCard({required this.title, required this.price, required this.number, required this.imgUrl, required this.descript});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: AppSize.height(268),
        decoration: ThemeDecoration.card2,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: AppSize.height(600),
                    height: AppSize.height(232),
                    margin: EdgeInsets.only(left: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: ThemeTextStyle.cardTitleStyle,
                          ),
                          Text(
                            descript,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: ThemeTextStyle.cardNumStyle,
                          ),
                          Text(
                            price,
                            textAlign: TextAlign.left,
                            style: ThemeTextStyle.cardPriceStyle,
                          ),
                        ]),
                  ),
                  flex: 3,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: AppSize.height(232),
                    child: Text(
                      number,
                      textAlign: TextAlign.center,
                      style: ThemeTextStyle.cardTitleStyle,
                    ),
                  ),
                  flex: 1,
                )
              ],
            ),
            Container(
              width: double.infinity,
              height: AppSize.height(2),
              color: Colours.gray_f5,
            )
          ],
        ));
  }
}

class ThemeBtnCard extends StatelessWidget {
 late final String title;
 late final String price;
 late final String imgUrl;

  ThemeBtnCard({required this.title, required this.price, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: AppSize.height(20)),
      decoration: ThemeDecoration.card2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              child: Text(
                title,
                style: ThemeTextStyle.cardTitleStyle,
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
              padding: EdgeInsets.all(AppSize.width(30))),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child: Text(price, style: ThemeTextStyle.cardPriceStyle)),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child: Image.asset("images/exchange_btn.png", fit: BoxFit.cover))
        ],
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final String text;

  Badge(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
      decoration: BoxDecoration(
          border: Border.all(color: ThemeColor.subTextColor),
          borderRadius: BorderRadius.circular(2)),
      child: Text(
        text,
        style: TextStyle(
            fontSize: AppSize.sp(24), color: ThemeColor.hintTextColor),
      ),
    );
  }
}

class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: new SizedBox(
          width: 120.0,
          height: 120.0,
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
