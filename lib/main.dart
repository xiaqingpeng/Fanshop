import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/common/SharedPreferences.dart';
import 'package:kuangxianjiaoapp/routers/routers.dart';
import 'package:kuangxianjiaoapp/view/splash.dart';
// import 'package:kuangxianjiaoapp/view/jiguang_android_view.dart';
// import 'package:kuangxianjiaoapp/view/jiguang_ios_view.dart';
import 'package:kuangxianjiaoapp/viewmodel/user/retrieve/retrieve_finish_viewmodel.dart';
import 'package:kuangxianjiaoapp/viewmodel/user/retrieve/retrieve_next_viewmodel.dart';
import 'package:kuangxianjiaoapp/viewmodel/user/login_viewmodel.dart';
import 'package:kuangxianjiaoapp/viewmodel/user/register_viewmodel.dart';
import 'package:kuangxianjiaoapp/viewmodel/theme/theme_viewmodel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:kuangxianjiaoapp/global/global_theme.dart';
import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final color = await SharedPreferencesThemeUtils.getThemeInfo("color") ?? 0;
  ThemeViewmodel themeViewmodel = ThemeViewmodel();
  themeViewmodel.setColor(color);
  runApp(
     GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (_) => RetrieveNextViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (_) => RetrieveFinishViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (_) => themeViewmodel,
        ),
      ], child:  const MyApp(),),
     
    ),
  );
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final int index=Provider.of<ThemeViewmodel>(context).getColor;
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: themes[index],
        buttonTheme: ButtonThemeData(
          buttonColor: themes[index],
          textTheme: ButtonTextTheme.normal,
        ),
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
    return const SplashView();
  }
}
