import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/common/SharedPreferences.dart';
// ignore: unused_import
import 'package:kuangxianjiaoapp/model/user_model.dart';
import 'package:kuangxianjiaoapp/common/regExp.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class LoginViewmodel extends ChangeNotifier {
  bool _isLogin = false;
  
  bool get getIsLogin {
    return _isLogin;
  }
  void setIsLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  void loginByPassword(BuildContext context,String moible,String password) async {
    final Login _model = Login();
    setIsLogin(true);

    if (moible.isEmpty) {
      WeToast.fail(context)(message: '手机号码不能为空');
      setIsLogin(false);
      return;
    }
    if (!isAllPhone(moible)) {
      WeToast.fail(context)(message: '请输入正确手机号码');
      setIsLogin(false);
      return;
    }
    if (password.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '密码不能为空');
      return;
    }

    if (!isLoginPassword(password)) {
      String message = r"请输入正确的密码 \n 格式为6~16位数字和字符组合";
      WeToast.fail(context)(message: message);
      setIsLogin(false);
      return;
    }

    var result = await _model.login(moible, password);
    if (result != null) {
      // 登录成功返回到首页
      WeToast.success(context)(message: '登录成功');
      Navigator.of(context).popAndPushNamed('menu');
    }
    if (result == null) {
      WeDialog.alert(context)(
        '手机号或密码有误，请重新正确输入。',
        // theme: WeDialogTheme.android,
        // theme: WeDialogTheme.ios,
      );
    }
    setIsLogin(false);
    // ignore: avoid_print
    print(result);
    SharedPreferencesUserUtils.setUserInfo("userInfo", result);
    notifyListeners(); // 刷新ui
  }
  void loginByVerificationcode(BuildContext context,String moible,String verificationcode) async {
    final Verificationcode _model = Verificationcode();
    setIsLogin(true);

    if (moible.isEmpty) {
      WeToast.fail(context)(message: '手机号码不能为空');
      setIsLogin(false);
      return;
    }
    if (!isAllPhone(moible)) {
      WeToast.fail(context)(message: '请输入正确手机号码');
      setIsLogin(false);
      return;
    }
   if (verificationcode.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '验证码不能为空');
      return;
    }
    if (!isValidateCaptcha(verificationcode)) {
      setIsLogin(false);
      String message = r"请输入正确的6位数字验证码";
      WeToast.fail(context)(message: message);
      return;
    }
   

    var result = await _model.verificationcode(moible, verificationcode,1);
    if (result != null) {
      // 登录成功返回到首页
      WeToast.success(context)(message: '登录成功');
      Navigator.of(context).popAndPushNamed('menu');
    }
    if (result == null) {
      WeDialog.alert(context)(
        '手机号码或验证码有误，请重新正确输入。',
        // theme: WeDialogTheme.android,
        // theme: WeDialogTheme.ios,
      );
    }
    setIsLogin(false);
    // ignore: avoid_print
    print(result);
    SharedPreferencesUserUtils.setUserInfo("userInfo", result);
    notifyListeners(); // 刷新ui
  }
}