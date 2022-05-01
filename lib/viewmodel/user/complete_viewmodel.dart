import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/common/SharedPreferences.dart';
// ignore: unused_import
import 'package:kuangxianjiaoapp/model/user_model.dart';
import 'package:kuangxianjiaoapp/common/regExp.dart';
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

  late DateTime _dateTime = DateTime.now(); //出生日期
  String get getDatetime {
    // ignore: unnecessary_null_comparison
    if (_dateTime == null) return '';

    return _dateTime.year.toString() +
        "-" +
        _dateTime.month.toString() +
        "-" +
        _dateTime.day.toString();
  }

  void setDatetime(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  int _gender = 1; // 性别
  int get getGender {
    return _gender;
  }

  void setGender(int gender) {
    _gender = gender;
    notifyListeners();
  }

  int _calendar = 1; // 日历
  int get getCalendar {
    return _calendar;
  }

  void setCalendar(int calendar) {
    _calendar = calendar;
    notifyListeners();
  }

  void register(
    BuildContext context,
    String loginId,
    String telephone,
    String verificationcode,
    String password,
    String fullname,
  ) async {
    final Register _model = Register();
    setIsLogin(true);
    if (loginId.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '登录账号不能为空');
      return;
    }
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
    if (password.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '登录密码不能为空');
      return;
    }
    if (fullname.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '中文姓名不能为空');
      return;
    }

    if (!isNickname(loginId)) {
      setIsLogin(false);
      String message = r"登录账号限16个字符，支持中英文、数字、减号或下划线";
      WeToast.fail(context)(message: message);
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

    if (!isLoginPassword(password)) {
      setIsLogin(false);
      String message = r"请输入正确的密码 \n 格式为6~16位数字和字符组合";
      WeToast.fail(context)(message: message);
      return;
    }

    if (!isFullname(fullname) || fullname.length < 2 || fullname.length > 4) {
      setIsLogin(false);
      String message = r"请输入正确的中文姓名";
      WeToast.fail(context)(message: message);
      return;
    }

    var result = await _model.register(
      loginId,
      telephone,
      verificationcode,
      password,
      fullname,
      getGender,
      getCalendar,
      getDatetime,
    );
    if (result != null) {
      // 登录成功返回到首页
      WeToast.success(context)(message: '注册成功');
      Navigator.of(context).pushNamed('login');
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
    print(result.toString() + 'result');

    // if (result == null) {
    //   WeDialog.alert(context)(
    //     '手机号有误，请重新正确输入。',
    //   );
    // }
    notifyListeners(); // 刷新ui
  }
}
