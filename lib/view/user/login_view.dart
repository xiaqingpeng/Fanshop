import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/common/regExp.dart';
import 'package:kuangxianjiaoapp/custom/custom_button.dart';
import 'package:kuangxianjiaoapp/viewmodel/user/login_viewmodel.dart';
import 'package:kuangxianjiaoapp/viewmodel/user/register_viewmodel.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _password = TextEditingController();

  late int count = 0;
  late bool disable = true;
  @override
  void initState() {
    super.initState();
    // 监听输入框正则校验
    _mobile.addListener(() {
      setState(() {
        disable = isAllPhone(_mobile.text) == false;
      });
    });
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _mobile.dispose(); //用户名TextEditingController销毁
    _password.dispose(); //密码TextEditingController销毁

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    // ignore: dead_code
    return Material(
      // appBar: CustomAppbar('登录', primaryColor),
      // resizeToAvoidBottomInset: false,

      child: Container(
        color: Colors.white,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/login.jpeg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  cursorColor: primaryColor,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone_android,
                      color: primaryColor,
                    ),
                    labelText: "手机号码",
                    hintText: '请输入手机号码',
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),
                    labelStyle: TextStyle(color: primaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  controller: _mobile,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                ),
                // 标签页所对应的页面
                TextField(
                  cursorColor: primaryColor,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: primaryColor,
                    ),
                    labelText: "密码",
                    hintText: '请输入密码',
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),
                    labelStyle: TextStyle(color: primaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  controller: _password,
                  obscureText: true,
                  textInputAction: TextInputAction.send,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    // ignore: avoid_print
                    print('找回密码');
                    Navigator.of(context).pushNamed('retrieve_next');
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      '找回密码',
                      style: TextStyle(color: primaryColor),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomButton(
                    title: "登录",
                    loading: Provider.of<LoginViewmodel>(context).getIsLogin,
                    onPressed: _loginByPassword),
                const SizedBox(
                  height: 16.0,
                ),
                CustomButton(
                    title: "注册",
                    loading: Provider.of<RegisterViewmodel>(context).getIsLogin,
                    onPressed: _register),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 密码登录
  void _loginByPassword() {
    context
        .read<LoginViewmodel>()
        .loginByPassword(context, _mobile.text, _password.text);
  }

  void _register() {
    Navigator.of(context).pushNamed('register');
  }
}
