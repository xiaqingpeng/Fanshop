import 'dart:async';

import 'package:Fanshop/service/dio.dart';

// 登录接口
class Login {
  Future login(
    String telephone,
    String password,
  ) async {
    print(telephone);
    print(password);
    final data = await HttpController.post("api/login", {
      "telephone": telephone,
      "password": password,
    });
    return data;
  }
}

// 完善信息接口
class Complete {
  Future complete(
      String? loginId,
      String? telephone,
      String? verificationcode,
      String? password,
      String? fullname,
      int? gender,
      int? calendar,
      String? datetime) async {
    return await HttpController.post("api/completed", {
      "telephone": telephone,
      "verificationcode": verificationcode,
      "password": password,
      "fullname": fullname,
      "gender": gender,
      "calendar": calendar,
      "loginId": loginId,
      "datetime": datetime,
    });
  }
}

// 注册接口
class Register {
  Future register(
    String? telephone,
    String? password,
  ) async {
    print(telephone.toString() + 'telephone');
    print(password.toString() + 'telephone');
    return await HttpController.post("api/registered", {
      "telephone": telephone,
      "password": password,
    });
  }
}

// 获取验证码
class Verificationcode {
  Future verificationcode(
    String? telephone,
    String? verificationcode,
  ) async {
    return await HttpController.post("api/verificationcode", {
      "telephone": telephone,
      "verificationcode": verificationcode,
    });
  }
}

//修改密码接口
class ModifyPassword {
  Future modifypassword(String password, String checkpassword) async {
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
