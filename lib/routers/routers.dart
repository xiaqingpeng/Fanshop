import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/view/login_view.dart';
import 'package:kuangxianjiaoapp/view/register_view.dart';
import 'package:kuangxianjiaoapp/view/menu_view.dart';
import 'package:kuangxianjiaoapp/view/theme/settings_theme.dart';

Map<String, WidgetBuilder> routes = {
  'login': (BuildContext context) => const LoginView(),
  'register': (BuildContext context) => const RegisterView(),
  'menu': (BuildContext context) => const MenuView(),
  'theme': (BuildContext context) => const SettingsTheme(),
};
