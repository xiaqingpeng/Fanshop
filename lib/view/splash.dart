import 'dart:async';
import 'dart:math';
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
class _SplashView extends State<SplashView> with TickerProviderStateMixin {
  int currentTime = 3;
  late Timer _timer;
  String _text = 'Unknown';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initData();
    });
    //创建动画控制器 1秒
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000),
    );
    //执行刷新监听
    _animationController.addListener(() {
      setState(() {});
    });
    //开启气泡的运动
    _animationController.repeat();
    // 状态栏隐藏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
      _animationController.dispose();
    }
    super.dispose();
  }

  //创建一个集合用来保存气泡
  final List<BobbleBean> _list = [];

  //随机数
  final Random _random = Random(
    DateTime.now().microsecondsSinceEpoch,
  );

  //来个动画控制器
  late AnimationController _animationController;

  void initData() {
    for (int i = 0; i < 2000; i++) {
      BobbleBean bean = BobbleBean();
      //获取随机透明度白色
      bean.color = getRandomWhiteColor(_random);
      //设置位置 先来个默认的 绘制的时候再修改
      double x = _random.nextDouble() * MediaQuery.of(context).size.width;
      double y = _random.nextDouble() * MediaQuery.of(context).size.height;
      double z = _random.nextDouble() + 0.5;
      bean.speed = _random.nextDouble() + 0.01 / z;
      bean.postion = Offset(x, y);
      bean.origin = Offset(x, 0);
      //设置半径
      bean.radius = 3.0 / z;
      _list.add(bean);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      ///填充布局
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        //层叠布局
        child: Stack(
          children: [
            // //第一部分 背景
            Center(
              child: SizedBox(
                width: 250.0,
                // ignore: deprecated_member_use
                child: ScaleAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  text: const [
                    "邝邝小朋友",
                    "情人节快乐",
                  ],
                  textStyle: const TextStyle(
                      fontSize: 40.0,
                      fontFamily: "Bobbers",
                      color: Colors.white),
                  textAlign: TextAlign.center,

                  // alignment: AlignmentDirectional.topStart,
                ),
              ),
            ),
            //第二部分 雪花
            CustomPaint(
              size: MediaQuery.of(context).size,
              //画布
              painter: SnowCustomMyPainter(
                list: _list,
                random: _random,
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
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
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

//全局定义获取颜色的方法
Color getRandomWhiteColor(Random random) {
  //透明度 0 ~ 200  255是不透明
  int a = random.nextInt(200);
  return Color.fromARGB(a, 255, 255, 255);
}

///定义 雪花模型 用来保存雪花的基本属性信息
class BobbleBean {
  //位置
  late Offset postion;

  //初始位置
  late Offset origin;
  //颜色
  late Color color;
  //运动的速度
  late double speed;
  //半径
  late double radius;
}

///创建画布
class SnowCustomMyPainter extends CustomPainter {
  List<BobbleBean> list;
  Random random;
  SnowCustomMyPainter({required this.list, required this.random});
  //先来个画笔
  final Paint _paint = Paint()..isAntiAlias = true;
  //具体的绘制功能
  @override
  void paint(Canvas canvas, Size size) {
    // 在绘制前重新计算每个点的位置
    for (var element in list) {
      //左右微抖动
      double dx = random.nextDouble() * 2.0 - 1.0;
      //竖直方向位置偏移
      double dy = element.speed;
      //位置偏移量计算
      element.postion += Offset(dx, dy);
      //重置位置
      if (element.postion.dy > size.height) {
        element.postion = element.origin;
      }
    }
    //// //绘制
    for (var element in list) {
      //修改画笔的颜色
      _paint.color = element.color;
      //绘制圆
      canvas.drawCircle(element.postion, element.radius, _paint);
    }
  }

  //刷新 控制
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //返回false 不刷新
    return true;
  }
}
