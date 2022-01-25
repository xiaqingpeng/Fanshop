import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  void _register() {
    // ignore: avoid_print
    print('注册');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注册'),
      ),
      body: WeForm(
        children: [
          WeInput(
            label: '登录账号',
            hintText: '请输入登录账号',
            clearable: true,
            textInputAction: TextInputAction.next,
          ),
          WeInput(
            label: '手机号码',
            hintText: '请输入手机号码',
            clearable: true,
            type: TextInputType.phone,
            footer: WeButton(
              '获取验证码',
              // theme: WeButtonType.primary,
              size: WeButtonSize.mini,
            ),
            textInputAction: TextInputAction.send,
          ),
          WeInput(
            label: '验证码',
            hintText: '请输入验证码',
            clearable: true,
            type: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          WeInput(
            label: '登录密码',
            hintText: '请输入登录密码',
            clearable: true,
            obscureText: true,
            textInputAction: TextInputAction.next,
          ),
          WeInput(
            label: '中文姓名',
            hintText: '请输入中文姓名',
            textInputAction: TextInputAction.next,
            footer: Row(
              children: [
                WeSwitch(),
                const SizedBox(
                  width: 8,
                ),
                const Text('男')
              ],
            ),
          ),
          WeCell(
            label: '出生日期',
            content: "",
            footer: Row(
              children: [
                WeSwitch(),
                const SizedBox(
                  width: 8,
                ),
                const Text('阴历')
              ],
            ),
          ),
          Container(
            child: WeButton('注册',
                theme: WeButtonType.warn,
                onClick: _register),
            margin: const EdgeInsets.all(10),
          )
        ],
      ),
    );
  }
}
