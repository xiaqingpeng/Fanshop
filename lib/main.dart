import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/routers/routers.dart';
// import 'package:kuangxianjiaoapp/view/jiguang_android_view.dart';
// import 'package:kuangxianjiaoapp/view/jiguang_ios_view.dart';
import 'package:kuangxianjiaoapp/view/login_view.dart';
// import 'package:kuangxianjiaoapp/view/jiguang_web_view.dart';
// import 'package:kuangxianjiaoapp/utils/platform.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      // initialRoute: '/login',
      routes: routes,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // if (PlatformUtils.isAndroid) {
    //   return const JiGuangAndroidView();
    // }
    // if (PlatformUtils.isIOS) {
    //   return const JiGuangIosView();
    // }
    return const LoginView();
  }
}
