import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Fanshop/common/SharedPreferences.dart';
import 'package:Fanshop/model/messages.dart';
import 'package:Fanshop/routers/routers.dart';
import 'package:Fanshop/view/splash.dart';
import 'package:Fanshop/viewmodel/cart/cart.dart';
import 'package:Fanshop/viewmodel/cart/check_out.dart';
import 'package:Fanshop/viewmodel/category/category.dart';
import 'package:Fanshop/viewmodel/home/home.dart';
// import 'package:Fanshop/view/jiguang_android_view.dart';
// import 'package:Fanshop/view/jiguang_ios_view.dart';
import 'package:Fanshop/viewmodel/user/retrieve/retrieve_finish_viewmodel.dart';
import 'package:Fanshop/viewmodel/user/retrieve/retrieve_next_viewmodel.dart';
import 'package:Fanshop/viewmodel/user/login_viewmodel.dart';
import 'package:Fanshop/viewmodel/user/register_viewmodel.dart';
import 'package:Fanshop/viewmodel/theme/theme_viewmodel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:Fanshop/global/global_theme.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screen_adapter/flutter_screen_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userInfo = await SharedPreferencesUserUtils.getUserInfo("userInfo");
  ThemeViewmodel themeViewmodel = ThemeViewmodel();
  themeViewmodel.setColor(userInfo['theme'] ?? 0);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: Messages(),
        locale: const Locale('zh', 'CN'),
        fallbackLocale: const Locale('zh', 'CN'),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => LoginViewmodel(),
            ),
            ChangeNotifierProvider(
              create: (_) => RegisterViewmodel(),
            ),
            ChangeNotifierProvider(
              create: (_) => CategoryViewmodel(),
            ),
            ChangeNotifierProvider(
              create: (_) => HomeViewmodel(),
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
            ChangeNotifierProvider(create: (_) => CheckOutViewmodel()),
            ChangeNotifierProvider(create: (_) => CartViewmodel()),
          ],
          child: const MyApp(),
        ),
      ),
    );
  });
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final int index = Provider.of<ThemeViewmodel>(context).getColor;
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Fanshop',
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

    /// 注意：
    /// 一定要在 `WidgetsApp` 或者 `MaterialApp widget` 中初始化
    /// 否则，会因为 `MediaQuery` 找不到报错

    ScreenAdapter.init(context);
    return const SplashView();
  }
}
