import 'package:flutter/material.dart';

class LoginViewmodel extends ChangeNotifier {
  bool _isLogin = false;
  final TextEditingController _user=TextEditingController();
  final TextEditingController _password=TextEditingController();
  bool get getIsLogin {
    return _isLogin;
  }

  TextEditingController get getUser {
    return _user;
  }

  TextEditingController get getPassword {
    return _password;
  }

  void setIsLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }
}
