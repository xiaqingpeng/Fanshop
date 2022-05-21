// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:Fanshop/custom/custom_appbar.dart';

// ignore: must_be_immutable
class FeedbackPage extends StatefulWidget {
  int id;
  String name;
  // ignore: use_key_in_widget_constructors
  FeedbackPage({required this.name, required this.id});

  @override
  // ignore: no_logic_in_create_state
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(widget.name, Theme.of(context).primaryColor),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///标题栏

              ///问题反馈标题
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Container(
                    child: const Text('问题反馈'),
                    margin: const EdgeInsets.only(top: 25, left: 25),
                  ),

                  ///问题反馈输入框
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.left,
                      autofocus: false,
                      onChanged: (text) {},
                      maxLines: 6,
                      maxLength: 200,
                      // style: Styles.style_1A2F51_14,
                      decoration: InputDecoration(
                        // hintText: StringStyles.FeedbackPageHint.tr,
                        // hintStyle: Styles.style_B8C0D4_13,
                        border: _getEditBorder(context),
                        focusedBorder: _getEditBorder(context),
                        disabledBorder: _getEditBorder(context),
                        enabledBorder: _getEditBorder(context),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 14),
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 15, left: 25, right: 25),
                  ),

                  ///上传截图(选题)
                  Container(
                    child: Row(
                      children: const [
                        Text('上传截图'),
                        Text('(选填)'),
                      ],
                    ),
                    margin: const EdgeInsets.only(top: 20, left: 25),
                  ),

                  ///图片选择框
                  Container(
                    child: FeedbackPhotoSelectWidget(),
                    margin: const EdgeInsets.only(top: 15, right: 18, left: 18),
                  ),

                  ///联系方式
                  Container(
                    child: Row(
                      children: const [
                        Text('联系方式'),
                        Text('(选填)'),
                      ],
                    ),
                    margin: const EdgeInsets.only(top: 30, left: 25),
                  ),

                  ///联系方式输入框
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      autofocus: false,
                      maxLines: 1,
                      // style: Styles.style_1A2F51_14,
                      onChanged: (text) {
                        // controller
                        //   ..contact = text
                        //   ..update();
                      },
                      decoration: InputDecoration(
                        // hintText: StringStyles.FeedbackPageConnectHint.tr,
                        // hintStyle: Styles.style_B8C0D4_13,
                        border: _getEditBorder(context),
                        focusedBorder: _getEditBorder(context),
                        disabledBorder: _getEditBorder(context),
                        enabledBorder: _getEditBorder(context),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 11),
                      ),
                    ),
                    margin: const EdgeInsets.only(top: 15, left: 25, right: 25),
                  ),

                  ///联系QQ群
                  Container(
                    child: const Text(
                      '联系QQ:626143872',
                      // style: Styles.style_1A2F51_14,
                    ),
                    margin: const EdgeInsets.only(top: 30, left: 25),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  GestureDetector(
                      onTap: () => {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.0),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: const Text(
                            // StringStyles.FeedbackPageSubmit.tr,
                            "提交"
                            // style: Styles.style_1A2F51_14,
                            ),
                        margin: const EdgeInsets.only(left: 90, right: 110),
                      ))
                ],
              )
            ],
          ),
        ));
  }

  ///获取输入框的Border属性，可公用
  OutlineInputBorder _getEditBorder(context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 1.0,
      ),
    );
  }
}

// ignore: must_be_immutable
class FeedbackPhotoSelectWidget extends StatelessWidget {
  FeedbackPhotoSelectWidget({Key? key}) : super(key: key);
  List photoEntity = [];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: photoEntity.length + 1, //后台数据
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, childAspectRatio: 1),
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          alignment: AlignmentDirectional.topEnd,
          fit: StackFit.loose,
          textDirection: TextDirection.ltr,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => {},
              child: Material(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: _getSelectWidget(index, context),
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Offstage(
              offstage: index == photoEntity.length, //后台数据
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => {},
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.close,
                      size: 10,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // child:
            ),
          ],
        );
      },
    );
  }

  ///最后一张图片显示为+号，其他图片显示为本地图片，并进行裁剪
  ///[pos] 当前位置
  ///此处直接创建对象是因为在增加item时UI必须要重新绘制
  ///Element虚拟树层级一定会改变，所以此处直接返回一个新的Widget
  Widget _getSelectWidget(int pos, context) {
    if (pos == photoEntity.length) {
      ///最后一张一定为加号
      return Container(
        width: 80,
        height: 80,
        color: Colors.white,
        alignment: Alignment.center,
        child: Icon(
          Icons.add,
          size: 60,
          color: Theme.of(context).primaryColor,
        ),
      );
    } else {
      ///本地图片显示并裁剪
      return ClipRRect(
        child: Image.file(
          photoEntity[pos],
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(3),
      );
    }
  }
}
