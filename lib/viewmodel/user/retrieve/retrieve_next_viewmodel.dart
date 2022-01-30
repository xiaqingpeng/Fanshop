import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:kuangxianjiaoapp/model/user_model.dart';
import 'package:kuangxianjiaoapp/common/regExp.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class RetrieveNextViewmodel extends ChangeNotifier {
  bool _isLogin = false;
  bool get getIsLogin {
    return _isLogin;
  }

  void setIsLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  void retrieve(
    BuildContext context,
    String telephone,
    String verificationcode,
  ) async {
    final Verificationcode _model = Verificationcode();
    setIsLogin(true);

    if (telephone.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '手机号码不能为空');
      return;
    }
    if (verificationcode.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '验证码不能为空');
      return;
    }

    if (!isAllPhone(telephone)) {
      setIsLogin(false);
      WeToast.fail(context)(message: '请输入正确手机号码');

      return;
    }

    if (!isValidateCaptcha(verificationcode)) {
      setIsLogin(false);
      String message = r"请输入正确的6位数字验证码";
      WeToast.fail(context)(message: message);
      return;
    }

    var result = await _model.verificationcode(
      telephone,
      verificationcode,
      0
    );
    if (result != null) {
      // 登录成功返回到首页
      // WeToast.success(context)(message: '注册成功');
      Navigator.of(context).pushNamed('retrieve_finish');
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

    notifyListeners(); // 刷新ui
  }
}
