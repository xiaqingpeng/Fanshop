import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/view/user/login_view.dart';
import 'package:kuangxianjiaoapp/view/user/register_view.dart';
import 'package:kuangxianjiaoapp/view/menu_view.dart';
import 'package:kuangxianjiaoapp/view/theme/settings_theme.dart';
import 'package:kuangxianjiaoapp/view/user/retrieve/retrieve_next_view.dart';
import 'package:kuangxianjiaoapp/view/user/retrieve/retrieve_finish_view.dart';

Map<String, WidgetBuilder> routes = {
  'login': (BuildContext context) => const LoginView(),
  'register': (BuildContext context) => const RegisterView(),
  'menu': (BuildContext context) => const MenuView(),
  'theme': (BuildContext context) => const SettingsTheme(),
  'retrieve_next': (BuildContext context) => const RetrieveNextView(),
  'retrieve_finish': (BuildContext context) =>  const RetrieveFinishView(),
};
