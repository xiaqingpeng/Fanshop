import 'package:Fanshop/getx/messages_getx.dart';
import 'package:flutter/material.dart';
import 'package:Fanshop/api/logs.dart';
// ignore: unused_import
import 'package:Fanshop/model/user_model.dart';
import 'package:Fanshop/common/regExp.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class RegisterViewmodel extends ChangeNotifier {
  bool _isLogin = false;
  bool get getIsLogin {
    return _isLogin;
  }

  void setIsLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  void register(
    BuildContext context,
    String telephone,
    String password,
  ) async {
    final Register _model = Register();
    setIsLogin(true);

    if (telephone.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '手机号码不能为空');
      return;
    }

    if (password.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '登录密码不能为空');
      return;
    }

    if (!isAllPhone(telephone)) {
      setIsLogin(false);
      WeToast.fail(context)(message: '请输入正确手机号码');

      return;
    }

    if (!isLoginPassword(password)) {
      setIsLogin(false);
      String message = r"请输入正确的密码 \n 格式为6~16位数字和字符组合";
      WeToast.fail(context)(message: message);
      return;
    }
    var result = await _model.register(
      telephone,
      password,
    );
    if (result != null && result['code'] == 200) {
      // 登录成功返回到首页
      WeToast.success(context)(message: '注册成功');
      // await SharedPreferencesUserUtils.setUserInfo("userInfo", result['data']);
      final UserInfoController userInfoController =
          Get.put(UserInfoController()); //获取state的值
      userInfoController.changeUserInfo(result['data']); // 修改state的值
      final AddLogs _model = AddLogs();
      _model.addLogs("flutter/register");
      Navigator.of(context).popAndPushNamed('menu');
    }
    if (result['code'] == 10001) {
      WeDialog.alert(context)(
        '该手机号码已注册',onConfirm: (){
           Navigator.of(context).pushNamed('login');
        }
        // theme: WeDialogTheme.android,
        // theme: WeDialogTheme.ios,
      );
    }
    setIsLogin(false);
    // ignore: avoid_print
    print(result);

    notifyListeners(); // 刷新ui
  }

  void verificationcode(
    BuildContext? context,
    String? telephone,
    String? verificationcode,
  ) async {
    final Verificationcode _model = Verificationcode();
    if (!isAllPhone(telephone!)) {
      WeToast.fail(context)(message: '请输入正确手机号码');
      return;
    }

    var result = await _model.verificationcode(
      telephone,
      verificationcode,
    );
    if (result != null) {
      WeToast.success(context)(message: '获取验证码成功');
    }

    notifyListeners(); // 刷新ui
  }
}
