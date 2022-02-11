import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kuangxianjiaoapp/custom/custom_button.dart';

//搜索框
class CustomSearch extends StatelessWidget {
  
  // ignore: prefer_typing_uninitialized_variables
  final onChanged; //输入监听
  // ignore: prefer_typing_uninitialized_variables
  final onSubmitted; //键盘回车监听
  // ignore: prefer_typing_uninitialized_variables
  final hintText; //提示文本
  final TextInputType textInputType;
  
   final TextEditingController textController = TextEditingController();

  // ignore: use_key_in_widget_constructors
    CustomSearch(
      {
      this.onChanged,
      this.hintText = '请输入内容',
      this.textInputType = TextInputType.text,
      this.onClick,
      this.onSubmitted});
  // 点击回调
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.0), //灰色的一层边框
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(6.66),
              ),
            ),
            alignment: Alignment.center,
            height: 38,
            // margin: EdgeInsets.fromLTRB(24, 9, 9, 12),
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: TextField(
              controller: textController,
              maxLines: 1,
              focusNode: FocusNode(),
              autofocus: false,
              cursorColor: Theme.of(context).primaryColor,
              onChanged: onChanged ??
                  (value) {
                    // ignore: avoid_print
                    print("正在输入内容:$value");
                  },
              onSubmitted: onSubmitted ??
                  (text) {
                    // ignore: avoid_print
                    print('submit $text');
                  },
              keyboardType: textInputType,
              textAlignVertical: TextAlignVertical.center, //添加图标后会有一个小的向上偏移
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: -13), //内容内边距，影响高度
                hintText: hintText,
                border: InputBorder.none,
                isCollapsed: true, //相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                fillColor: Colors.white, //背景颜色，必须结合filled: true,才有效
                filled: true, //必须设置为true，fillColor才有效
                isDense: true,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Icon(
                    Icons.search,
                    size: 22,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    //addPostFrameCallback是 StatefulWidge 渲染结束的回调，只会被调用一次
                    SchedulerBinding.instance!.addPostFrameCallback(
                      (_) {
                        textController.text = "";
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Icon(
                      Icons.clear,
                      size: 23,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        CustomButton(
          width: 60,
          height: 38,
          title: '搜索',
          onPressed: ()=>onClick!(textController.text)
        )
      ],
    );
  }
}
