import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/login.jpeg',
              width: double.infinity,
              height: 260,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 16.0,
            ),
            WeForm(
              children: [
                WeInput(
                  label: '用户名',
                  hintText: '请输入用户名',
                  clearable: true,
                  textInputAction: TextInputAction.next,
                ),
                WeInput(
                  label: '密码',
                  hintText: '请输入密码',
                  clearable: true,
                  obscureText: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
