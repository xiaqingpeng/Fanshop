import 'package:flutter/material.dart';
import 'package:Fanshop/common/regExp.dart';
import 'package:Fanshop/custom/custom_button.dart';
import 'package:Fanshop/viewmodel/user/login_viewmodel.dart';
import 'package:Fanshop/viewmodel/user/register_viewmodel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:Fanshop/common/random.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _verificationcode =
      TextEditingController(); // 手机号码
  late TabController tabController;
  late int count = 0;
  late bool disable = true;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // 监听输入框正则校验
    _mobile.addListener(() {
      setState(() {
        disable = isAllPhone(_mobile.text) == false;
      });
    });
    tabController.addListener(
      () {
        // ignore: avoid_print
        print(tabController.index);
      },
    );
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _mobile.dispose(); //用户名TextEditingController销毁
    _password.dispose(); //密码TextEditingController销毁
    _verificationcode.dispose(); //密码TextEditingController销毁
    tabController.dispose(); // tabController销毁
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTabController(
                  // 标签数量
                  length: 2,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 60,
                          child: TabBar(
                            // 多个标签时滚动加载
                            isScrollable: true,
                            // 标签指示器的颜色
                            indicatorColor: primaryColor,
                            // 标签的颜色
                            labelColor: Colors.blue,
                            // 未选中标签的颜色
                            unselectedLabelColor: Colors.black,
                            // 指示器的大小
                            indicatorSize: TabBarIndicatorSize.label,
                            // 指示器的权重，即线条高度
                            indicatorWeight: 2.0,
                            controller: tabController,
                            tabs: <Widget>[
                              Text(
                                '账号密码登录',
                                style: TextStyle(
                                    color: primaryColor, fontSize: 16),
                              ),
                              Text(
                                '验证码登录',
                                style: TextStyle(
                                    color: primaryColor, fontSize: 16),
                              ),
                            ],
                          )),

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
                      SizedBox(
                        height: 70,
                        child: TabBarView(
                          controller: tabController,
                          children: <Widget>[
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
                            WeForm(
                              spacing: 0.0,
                              boxBorder: false,
                              children: [
                                WeCell(
                                  footer: CustomButton(
                                    width: 100,
                                    height: 30,
                                    borderRadius: 4,
                                    fontSize: 14.0,
                                    title: count > 0 ? '$count秒后重发' : '获取验证码',
                                    disable:
                                        (count > 0 || disable) ? true : false,
                                    onPressed: _getVertifyCode,
                                  ),
                                  content: TextField(
                                    cursorColor: primaryColor,
                                    style: TextStyle(color: primaryColor),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: primaryColor,
                                      ),
                                      labelText: "验证码",
                                      hintText: '请输入验证码',
                                      hintStyle: TextStyle(
                                        color: primaryColor,
                                      ),
                                      labelStyle:
                                          TextStyle(color: primaryColor),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primaryColor),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primaryColor),
                                      ),
                                    ),
                                    controller: _verificationcode,
                                    obscureText: true,
                                    textInputAction: TextInputAction.send,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                  onPressed: tabController.index == 0
                      ? _loginByPassword
                      : _loginByVerificationcode,
                ),
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
    // ignore: avoid_print
    // context.read<LoginViewmodel>().setIsLogin(true);
    // final String user = context.read<LoginViewmodel>().getMobile.text;//获取输入用户名
    // final String password = context.read<LoginViewmodel>().getPassword.text;///获取输入密码
    // // ignore: avoid_print
    // print(user);
    // // ignore: avoid_print
    // print(password);
    // Timer(const Duration(seconds: 3), () {
    //   context.read<LoginViewmodel>().setIsLogin(false);
    //   Navigator.of(context).pushNamed('menu');
    // });
    context
        .read<LoginViewmodel>()
        .loginByPassword(context, _mobile.text, _password.text);
  }

  // 验证码登录
  void _loginByVerificationcode() {
    context
        .read<LoginViewmodel>()
        .loginByVerificationcode(context, _mobile.text, _verificationcode.text);
  }

  void _register() {
    Navigator.of(context).pushNamed('register');
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
}
