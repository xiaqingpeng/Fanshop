import 'dart:async';
// 登录接口
class Login {
  Future login(String mobile, String password) async {
    Map result() {
      return {
        "toekn": '123***456789',
        "password": password,
        "mobile": mobile,
        "loginstatus": 1,
        "registerstatus": 1,
        "userimages": '',
      };
    }
    final com = Completer();
    final future = com.future;
    Timer(
      const Duration(seconds: 1),
      () {
        com.complete(result());
      },
    );

    return future;
  }
}

// 注册接口
class Register {
  Future register(
    String loginId,
    String telephone,
    String verificationcode,
    String password,
    String fullname,
    int gender,
    int calendar,
    String datetime,
  ) async {
    Map result() {
      return {
        "toekn": '123***456789',
        "loginId": loginId,
        "password": password,
        "telephone": telephone,
        "verificationcode": verificationcode,
        "fullname": fullname,
        "gender": gender,
        "calendar": calendar,
        "datetime": datetime,
        "loginstatus": 0,
        "registerstatus": 1,
      };
    }
    final com = Completer();
    final future = com.future;
    Timer(
      const Duration(seconds: 1),
      () {
        com.complete(result());
      },
    );
    return future;
  }
}

// 获取验证码
class Verificationcode {
  Future verificationcode(
    String telephone,
    String verificationcode,
    int status,
  ) async {
    Map result() {
      return {
        "toekn": '123***456789',
        "telephone": telephone,
        "verificationcode": verificationcode,
        "loginstatus": 1,
        "status": 1,
      };
    }
    final com = Completer();
    final future = com.future;
    Timer(
      const Duration(seconds: 1),
      () {
        com.complete(result());
      },
    );
    return future;
  }
}

//修改密码接口 
class ModifyPassword {
  Future modifypassword(
   
    String password,
    String checkpassword
   
  ) async {
    bool result() {
      return true;
    }
    final com = Completer();
    final future = com.future;
    Timer(
      const Duration(seconds: 1),
      () {
        com.complete(result());
      },
    );
    return future;
  }
}
