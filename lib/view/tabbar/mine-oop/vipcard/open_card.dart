// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';


class OpenCard extends StatefulWidget{
  const OpenCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OpenCard();
  }
}
class _OpenCard extends State<OpenCard> {
  final registerFormKey = GlobalKey<FormState>();
  late String username,  telphone, idcard;
  bool check = false;

  void onFinish() {
    var checked = registerFormKey.currentState!.validate();
    if (checked) {
      registerFormKey.currentState!.save();

      debugPrint("$username");
      debugPrint("$telphone");
      debugPrint("$idcard");
     
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
    if (value.length!=18) {
      return '身份证位数为18位';
    }
    return null;
  }

  String? validatorTelphone(value) {
    if (value.isEmpty) {
      return '手机号码输入不为空';
    }
     if (value.length!=11) {
      return '手机号码位数为11位';
    }
    return null;
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('开通新会员卡'),
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
                           
                           
                            const SizedBox(
                              height: 32.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: () => {onFinish()},
                                color: Theme.of(context).accentColor,
                                elevation: 0.0,
                                child: const Text(
                                  '开通百姓量贩会员卡',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ))));
  }
}
