import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/view/checkout/checkout.dart';
import 'package:kuangxianjiaoapp/view/user/login_view.dart';
import 'package:kuangxianjiaoapp/view/user/register_view.dart';
import 'package:kuangxianjiaoapp/view/main_view.dart';
import 'package:kuangxianjiaoapp/view/splash.dart';
import 'package:kuangxianjiaoapp/view/theme/settings_theme.dart';
import 'package:kuangxianjiaoapp/view/international/settings_international.dart';
import 'package:kuangxianjiaoapp/view/user/retrieve/retrieve_next_view.dart';
import 'package:kuangxianjiaoapp/view/user/retrieve/retrieve_finish_view.dart';

Map<String, WidgetBuilder> routes = {
  'login': (BuildContext context) => const LoginView(),
  'register': (BuildContext context) => const RegisterView(),
  'menu': (BuildContext context) => const MainView(),
  'theme': (BuildContext context) => const SettingsTheme(),
  'retrieve_next': (BuildContext context) => const RetrieveNextView(),
  'retrieve_finish': (BuildContext context) => const RetrieveFinishView(),
  'splash': (BuildContext context) => const SplashView(),
  'international': (BuildContext context) => const SettingsInternational(),
  'checkOut': (BuildContext context) => const CheckOut(),
};
