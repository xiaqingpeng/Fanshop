import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/common/sharedPreferences.dart';
import 'package:kuangxianjiaoapp/view/main_view.dart';
import 'package:kuangxianjiaoapp/view/user/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  _SplashView createState() => _SplashView();
}

// ignore: camel_case_types
class _SplashView extends State<SplashView> {
  int currentTime = 5;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    // 计时器创建
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (currentTime == 0) {
          _timer.cancel();
          next();
          return;
        }

        setState(
          () {
            currentTime = currentTime - 1;
          },
        );
      },
    );
  }

  void next() async {
    final userInfo = await SharedPreferencesUserUtils.getUserInfo("userInfo");
    // print("获取到的用户信息为" + userInfo.toString());
    // 判断用户是否登录
    // userInfo['loginstatus'] == 1登录进入首页
    // userInfo['loginstatus'] == 0未登录进入登录注册
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) =>
            userInfo['loginstatus'] == 1 ? const MainView() : const LoginView(),
      ),
      // ignore: unnecessary_null_comparison
      (route) => route == null,
    );
  }

  // 计时器销毁
  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Center(
                // padding: const EdgeInsets.only(top: 250.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      '邝邝乐购',
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: GestureDetector(
                onTap: () => next(),
                child: Container(
                  // margin: EdgeInsets.only(left: 40, top: 40),
                  //设置 child 居中
                  alignment: Alignment.center,
                  height: 40,
                  width: 100,
                  //边框设置
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    //设置四周边框
                    // border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Text(
                    "$currentTime",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              top: 66,
              right: 20,
            )
          ],
        ),
      ),
    );
  }
}
