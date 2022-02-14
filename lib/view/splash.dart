import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_is_emulator/flutter_is_emulator.dart';
import 'package:kuangxianjiaoapp/common/sharedPreferences.dart';
import 'package:kuangxianjiaoapp/common/storage.dart';
import 'package:kuangxianjiaoapp/view/main_view.dart';
import 'package:kuangxianjiaoapp/view/user/login_view.dart';
import 'package:kuangxianjiaoapp/viewmodel/home/home.dart';
// ignore: implementation_imports, import_of_legacy_library_into_null_safe
import 'package:provider/src/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  _SplashView createState() => _SplashView();
}

// ignore: camel_case_types
class _SplashView extends State<SplashView> {
  int currentTime = 3;
  late Timer _timer;
  String _text = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
    context.read<HomeViewmodel>().getCategory();
    context.read<HomeViewmodel>().getProduct(0);
    // 计时器创建
    _timer = Timer.periodic(
      const Duration(seconds: 3),
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

  initPlatformState() async {
    String text;
    try {
      bool res = await FlutterIsEmulator.isDeviceAnEmulatorOrASimulator;
      text = res.toString();
      // ignore: nullable_type_in_catch_clause
    } on PlatformException {
      text = 'Error.';
    }

    if (!mounted) return;

    setState(() {
      _text = text;
    });
  }

  void next() async {
    await Storage.setString('device', _text);
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
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    SizedBox(
                      width: 250.0,
                      // ignore: deprecated_member_use
                      child: ScaleAnimatedTextKit(
                        onTap: () {
                          print("Tap Event");
                        },
                        text: const [
                          "刘玲同学",
                          "情人节快乐",
                        ],
                        textStyle: const TextStyle(
                          fontSize: 40.0,
                          fontFamily: "Bobbers",
                          color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                        
                        // alignment: AlignmentDirectional.topStart,
                      ),
                    )
                    // Text(
                    //   '纯沁乐购',
                    //   style: TextStyle(
                    //       fontSize: 40.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // ),
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
