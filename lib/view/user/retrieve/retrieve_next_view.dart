import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom.dart';
import 'package:kuangxianjiaoapp/viewmodel/user/retrieve/retrieve_next_viewmodel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';
import 'package:kuangxianjiaoapp/common/random.dart';
import 'package:kuangxianjiaoapp/common/regExp.dart';

class RetrieveNextView extends StatefulWidget {
  const RetrieveNextView({Key? key}) : super(key: key);
  @override
  _RetrieveNextViewState createState() => _RetrieveNextViewState();
}

class _RetrieveNextViewState extends State<RetrieveNextView> {
  TextEditingController telephone = TextEditingController(); // 手机号码
  TextEditingController verificationcode = TextEditingController(); // 手机验证码
 
  late int count = 0;
  late bool disable = true;
  @override
  void initState() {
      telephone.addListener(() {
      setState(() {
        disable = isAllPhone(telephone.text)==false;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    telephone.dispose();
    verificationcode.dispose();
   
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar('找回密码', Theme.of(context).primaryColor),
      body: WeForm(
        children: [
         
          WeInput(
            label: '手机号码',
            hintText: '请输入手机号码',
            textInputAction: TextInputAction.next,
            onChange: (value) => telephone.text = value,
            footer: WeButton(count > 0 ? '$count秒后重发' : '获取验证码',
                disabled: (count > 0 || disable) ? true : false,
                theme: WeButtonType.primary,
                size: WeButtonSize.mini,
                onClick: _getVertifyCode),
          ),
          WeInput(
              label: '验证码',
              hintText: '请输入验证码',
              clearable: true,
              type: TextInputType.number,
              textInputAction: TextInputAction.next,
              onChange: (value) => verificationcode.text = value),
          Container(
            child: WeButton(
              '下一步',
              loading: Provider.of<RetrieveNextViewmodel>(context).getIsLogin,
              theme: WeButtonType.warn,
              onClick: _next,
            ),
            margin: const EdgeInsets.all(10),
          ),
          
        ],
      ),
    );
  }
  void _getVertifyCode() {
    WeDialog.alert(context)('验证码${getRandom(6)},有效期10分钟');// 获取验证码
    setState(
      () {
        count = 60;
      },
    );
    _task();
  }
  // 定时任务
  void _task() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(
          () {
            count--;
            if (count > 0) {
              _task();
            }
          },
        );
      },
    );
  }
  // 下一步
  void _next() {
    context.read<RetrieveNextViewmodel>().register(context,  telephone.text, verificationcode.text);
  }
  
}