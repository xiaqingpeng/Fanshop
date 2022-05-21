// ignore_for_file: unnecessary_null_comparison

import 'package:Fanshop/getx/messages_getx.dart';
import 'package:flutter/material.dart';
import 'package:Fanshop/api/logs.dart';
import 'package:Fanshop/common/SharedPreferences.dart';
// ignore: unused_import
import 'package:Fanshop/model/user_model.dart';
import 'package:Fanshop/common/regExp.dart';
import 'package:get/get.dart';
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

  void loginByPassword(
      BuildContext context, String moible, String password) async {
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

    if (result['data'] != null) {
      // 登录成功返回到首页
      WeToast.success(context)(message: '登录成功');
      print(result.toString() + 'resul872030683');
      // await SharedPreferencesUserUtils.setUserInfo("userInfo", result['data']);
      // ignore: non_constant_identifier_names
      final UserInfoController userInfoController =
          Get.put(UserInfoController()); //获取state的值
      userInfoController.changeUserInfo(result['data']); // 修改state的值
      final AddLogs _model = AddLogs();
      _model.addLogs("flutter/login");
      Navigator.of(context).popAndPushNamed('menu');
    }
    if (result['data'] == null) {
      WeDialog.alert(context)(
        result['message'],
        // theme: WeDialogTheme.android,
        // theme: WeDialogTheme.ios,
      );
    }
    setIsLogin(false);

    notifyListeners(); // 刷新ui
  }

  void loginByVerificationcode(
      // ignore: duplicate_ignore
      BuildContext context,
      String moible,
      // ignore: duplicate_ignore
      String verificationcode) async {
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

    Map<dynamic, dynamic> result =
        await _model.verificationcode(moible, verificationcode);
    print(result.toString() + 'resul872030683');
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

    notifyListeners(); // 刷新ui
  }
}
