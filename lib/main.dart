import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/routers/routers.dart';
// import 'package:kuangxianjiaoapp/view/jiguang_android_view.dart';
// import 'package:kuangxianjiaoapp/view/jiguang_ios_view.dart';
import 'package:kuangxianjiaoapp/view/login_view.dart';
import 'package:kuangxianjiaoapp/viewmodel/login_viewmodel.dart';
import 'package:kuangxianjiaoapp/viewmodel/theme_viewmodel.dart';
// import 'package:kuangxianjiaoapp/view/jiguang_web_view.dart';
// import 'package:kuangxianjiaoapp/utils/platform.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:kuangxianjiaoapp/global/global_theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  ThemeViewmodel themeViewmodel = ThemeViewmodel();
  themeViewmodel.setColor(sp.getInt('color')??0);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeViewmodel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MaterialColor color =
        themes[Provider.of<ThemeViewmodel>(context).getColor];
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        // primarySwatch: color,
        primaryColor: color,
        buttonTheme: ButtonThemeData(
            buttonColor: color, textTheme: ButtonTextTheme.normal),
        highlightColor: const Color.fromRGBO(255, 255, 255, 0),
        splashColor: Colors.white70,
        // ignore: deprecated_member_use
        accentColor: const Color.fromRGBO(3, 54, 255, 1.0),
      ),
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
