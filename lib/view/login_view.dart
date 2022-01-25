import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom.dart';
import 'package:kuangxianjiaoapp/viewmodel/login_viewmodel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  void _login() {
    // ignore: avoid_print
    context.read<LoginViewmodel>().setIsLogin(true);
    final String user = context.read<LoginViewmodel>().getUser.text;//获取输入用户名
    final String password = context.read<LoginViewmodel>().getPassword.text;///获取输入密码
    // ignore: avoid_print
    print(user);
    // ignore: avoid_print
    print(password);
    Timer(const Duration(seconds: 3), () {
      context.read<LoginViewmodel>().setIsLogin(false);
      Navigator.of(context).pushNamed('menu');
    });
    // ignore: avoid_print
    print('登录');
  }

  void _register() {
    Navigator.of(context).pushNamed('register');
    // ignore: avoid_print
    print('注册');
  }

  @override
  void dispose() {
   
    super.dispose();
    context.read<LoginViewmodel>().getUser.dispose(); //用户名TextEditingController销毁
    context.read<LoginViewmodel>().getPassword.dispose();//密码TextEditingController销毁
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar('登录', Theme.of(context).primaryColor),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/login.jpeg',
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "用户名",
                  hintText: '请输入用户名',
                  prefixIcon: Icon(Icons.person),
                ),
                controller: Provider.of<LoginViewmodel>(context).getUser,
                autofocus: true,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "密码",
                  hintText: '请输入密码',
                  prefixIcon: Icon(Icons.lock),
                ),
                controller: Provider.of<LoginViewmodel>(context).getPassword,
                obscureText: true,
                textInputAction: TextInputAction.send,
                onSubmitted: (String text) {
                  // ignore: avoid_print
                  print('onSubmitted $text');
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              GestureDetector(
                onTap: () {
                  // ignore: avoid_print
                  print('找回密码');
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    '找回密码',
                    style: TextStyle(color: Colors.blue),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              WeButton('登录',
                  // theme: WeButtonType.primary,
                  loading: Provider.of<LoginViewmodel>(context).getIsLogin,
                  onClick: _login),
              const SizedBox(
                height: 16.0,
              ),
              WeButton('注册',
                  // theme: WeButtonType.primary,
                  onClick: _register),
            ],
          ),
        ),
      ),
    );
  }
}
