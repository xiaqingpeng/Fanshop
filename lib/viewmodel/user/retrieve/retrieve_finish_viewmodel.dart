import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:kuangxianjiaoapp/model/user_model.dart';
import 'package:kuangxianjiaoapp/common/regExp.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class RetrieveFinishViewmodel extends ChangeNotifier {
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
  
    String password,
    String checkpassword,
    
  ) async {
    final ModifyPassword _model = ModifyPassword();
    setIsLogin(true);
    
    if (password.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '新密码不能为空');
      return;
    }
    if (checkpassword.isEmpty) {
      setIsLogin(false);
      WeToast.fail(context)(message: '确认新密码不能为空');
      return;
    }
   

    

    if (!isLoginPassword(password)) {
      setIsLogin(false);
      String message = r"请输入正确的新密码 \n 格式为6~16位数字和字符组合";
      WeToast.fail(context)(message: message);
      return;
    }
    if (!isLoginPassword(checkpassword)) {
      setIsLogin(false);
      String message = r"请输入正确的确认新密码 \n 格式为6~16位数字和字符组合";
      WeToast.fail(context)(message: message);
      return;
    }

    if (checkpassword!=password) {
      setIsLogin(false);
      String message = r"确认密码跟新密码不一致";
      WeToast.fail(context)(message: message);
      return;
    }

    

    var result = await _model.modifypassword(password, checkpassword);
    if (result != null) {
      // 登录成功返回到首页
      // WeToast.success(context)(message: '注册成功');
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
   
    notifyListeners(); // 刷新ui
  }
}
