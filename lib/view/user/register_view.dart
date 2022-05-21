// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:Fanshop/common/regExp.dart';
import 'package:Fanshop/custom/custom_button.dart';

import 'package:Fanshop/custom/custom_navigationbar.dart';
import 'package:Fanshop/viewmodel/user/register_viewmodel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController telephone = TextEditingController(); // 手机号码

  TextEditingController password = TextEditingController(); // 登录密码

  late int count = 0;
  late bool disable = true;
  @override
  void initState() {
    super.initState();
    telephone.addListener(() {
      setState(() {
        disable = isAllPhone(telephone.text) == false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    telephone.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavigatorBar(
        title: '注册',
        bgColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: WeForm(
          children: [
            WeInput(
              label: '手机号码',
              hintText: '请输入手机号码',
              textInputAction: TextInputAction.next,
              onChange: (value) => telephone.text = value,
            ),
            WeInput(
              label: '密码',
              hintText: '请输入密码',
              clearable: true,
              obscureText: true,
              textInputAction: TextInputAction.next,
              onChange: (value) => password.text = value,
            ),
            CustomButton(
                horizontal: 10.0,
                vertical: 10.0,
                title: "注册",
                loading: Provider.of<RegisterViewmodel>(context).getIsLogin,
                onPressed: _register),
          ],
        ),
      ),
    );
  }

  // 注册
  void _register() {
    context
        .read<RegisterViewmodel>()
        .register(context, telephone.text, password.text);
  }
}
