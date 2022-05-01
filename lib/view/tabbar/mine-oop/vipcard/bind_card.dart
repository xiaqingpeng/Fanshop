// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class BindCard extends StatefulWidget {
  const BindCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BindCard();
  }
}

class _BindCard extends State<BindCard> {
  final registerFormKey = GlobalKey<FormState>();
  late String username, password, telphone, idcard;
  bool check = false;

  void onFinish() {
    // var checked = registerFormKey.currentState?.validate();
   
      registerFormKey.currentState?.save();

      debugPrint(username);
      debugPrint(password);
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(
        const SnackBar(content: Text('绑定成功...'),
          backgroundColor: Colors.pink,
        )
      );
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }

  String? validatorUsername(value) {
    if (value.isEmpty) {
      return '姓名输入不为空';
    }
    return null;
  }

  String? validatorIDcard(value) {
    if (value.isEmpty) {
      return '身份证输入不为空';
    }
    return null;
  }

  String? validatorTelphone(value) {
    if (value.isEmpty) {
      return '手机号码输入不为空';
    }
    return null;
  }

  String? validatorPassword(value) {
    if (value.isEmpty) {
      return '密码输入不为空';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var registerFormKey;
    String username;
    String telphone;
    String idcard;
    String password;
    var check;
    return Scaffold(
        appBar: AppBar(
          title: Text('绑定已有会员卡'),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                        key: registerFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "姓名",
                                prefixIcon: Icon(Icons.people),
                                hintText: "请输入姓名",
                              ),
                              validator: validatorUsername,
                              onSaved: (value) => {username = value!},
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "身份证",
                                prefixIcon: Icon(Icons.card_giftcard),
                                hintText: "请输入身份证",
                              ),
                              validator: validatorIDcard,
                              onSaved: (value) => {idcard = value!},
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "手机号",
                                prefixIcon: Icon(Icons.phone),
                                hintText: "请输入手机号",
                              ),
                              validator: validatorTelphone,
                              onSaved: (value) => {telphone = value!},
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "验证码",
                                prefixIcon: Icon(Icons.lock),
                                hintText: "请输入验证码",
                              ),
                              validator: validatorPassword,
                              onSaved: (value) => {password = value!},
                            ),
                            CheckboxListTile(
                              value: check,
                              title: const Text('开通并遵守百姓量贩会员协议'),
                              activeColor: Colors.pink,
                              onChanged: (val) {
                                // val 是布尔值
                                setState(() {
                                  check = val!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: () => {onFinish()},
                                color: Theme.of(context).colorScheme.secondary,
                                elevation: 0.0,
                                child: const Text(
                                  '绑定百姓量贩会员卡',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ))));
  }

void setState(Null Function() param0) {
}

onFinish() {
}

