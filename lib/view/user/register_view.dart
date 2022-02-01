import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/common/regExp.dart';
import 'package:kuangxianjiaoapp/custom/custom_appbar.dart';
import 'package:kuangxianjiaoapp/custom/custom_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:kuangxianjiaoapp/viewmodel/user/register_viewmodel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';
import 'package:kuangxianjiaoapp/common/random.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController loginId = TextEditingController(); //登录账号
  TextEditingController telephone = TextEditingController(); // 手机号码
  TextEditingController verificationcode = TextEditingController(); // 手机验证码
  TextEditingController password = TextEditingController(); // 登录密码
  TextEditingController fullname = TextEditingController(); // 中文姓名
  late int count = 0;
  late bool disable = true;
  @override
  void initState() {
    super.initState();
     telephone.addListener(() {
      setState(() {
        disable = isAllPhone(telephone.text)==false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginId.dispose();
    telephone.dispose();
    verificationcode.dispose();
    password.dispose();
    fullname.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Provider.of<RegisterViewmodel>(context).getDatetime; // 出生日期
    final gender = Provider.of<RegisterViewmodel>(context).getGender; // 男女
    final calendar = Provider.of<RegisterViewmodel>(context).getCalendar; // 日历
    return Scaffold(
      appBar: CustomAppbar('注册', Theme.of(context).primaryColor),
      body: WeForm(
        children: [
          WeInput(
            label: '登录账号',
            hintText: '请输入登录账号',
            clearable: true,
            textInputAction: TextInputAction.next,
            onChange: (value) => loginId.text = value,
          ),
          WeInput(
            label: '手机号码',
            hintText: '请输入手机号码',
            textInputAction: TextInputAction.next,
            onChange: (value) => telephone.text = value,
            footer: CustomButton(
                width: 100,
                height: 30,
                borderRadius: 4,
                fontSize: 14.0,
                title: count > 0 ? '$count秒后重发' : '获取验证码',
                disable:(count > 0 || disable) ? true : false ,
                onPressed: _getVertifyCode),
          ),
          WeInput(
              label: '验证码',
              hintText: '请输入验证码',
              clearable: true,
              type: TextInputType.number,
              textInputAction: TextInputAction.next,
              onChange: (value) => verificationcode.text = value),
          WeInput(
            label: '登录密码',
            hintText: '请输入登录密码',
            clearable: true,
            obscureText: true,
            textInputAction: TextInputAction.next,
            onChange: (value) => password.text = value,
          ),
          WeInput(
            label: '中文姓名',
            hintText: '请输入中文姓名',
            textInputAction: TextInputAction.next,
            onChange: (value) => fullname.text = value,
            footer: Row(
              children: [
                WeSwitch(
                  size: 20,
                  checked: gender == 1 ? true : false,
                  onChange: (value) => context
                      .read<RegisterViewmodel>()
                      .setGender(value ? 1 : 0),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(gender == 1 ? '男' : '女')
              ],
            ),
          ),
          WeCell(
            label: '出生日期',
            align: Alignment.center,
            content: content,
            onClick: _showDatePicker,
            footer: Row(
              children: [
                WeSwitch(
                    size: 20,
                    checked: calendar == 1 ? true : false,
                    onChange: (value) => context
                        .read<RegisterViewmodel>()
                        .setCalendar(value ? 1 : 0)),
                const SizedBox(
                  width: 4,
                ),
                Text(calendar == 1 ? '阳历' : '阴历')
              ],
            ),
          ),
           CustomButton(
                horizontal: 10.0,
                vertical: 10.0,
                title: "注册",
                loading: Provider.of<RegisterViewmodel>(context).getIsLogin,
                onPressed: _register
          ),
         
        ],
      ),
    );
  }

  void _getVertifyCode() {
    WeDialog.alert(context)('验证码${getRandom(6)},有效期10分钟'); // 获取验证码
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

  // 注册
  void _register() {
    context.read<RegisterViewmodel>().register(context, loginId.text,
        telephone.text, verificationcode.text, password.text, fullname.text);
  }

  // 调用日期控件
  _showDatePicker() async {
    await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2010, 1, 1),
        maxTime: DateTime(2050, 1, 1), onChanged: (date) {
      // ignore: avoid_print
      print('change $date');
    }, onConfirm: (date) {
      // ignore: avoid_print
      print('数据类型 ${date.runtimeType}' 'confirm ${date.year.toString()}');
      context.read<RegisterViewmodel>().setDatetime(date);
    }, currentTime: DateTime.now(), locale: LocaleType.zh);
  }
}
