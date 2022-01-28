import 'package:flutter/material.dart';
import 'package:kuangxianjiaoapp/custom/custom.dart';
import 'package:kuangxianjiaoapp/viewmodel/user/retrieve/retrieve_finish_viewmodel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';


class RetrieveFinishView extends StatefulWidget {
  const RetrieveFinishView({Key? key}) : super(key: key);
  @override
  _RetrieveFinishViewState createState() => _RetrieveFinishViewState();
}

class _RetrieveFinishViewState extends State<RetrieveFinishView> {
 
  TextEditingController password = TextEditingController(); // 登录密码
  TextEditingController checkpassword = TextEditingController(); // 确认登录密码
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    password.dispose();
    checkpassword.dispose();
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar('找回密码', Theme.of(context).primaryColor),
      body: WeForm(
        children: [
         
         
          WeInput(
            label: '新密码',
            hintText: '请输入新密码',
            clearable: true,
            obscureText: true,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.next,
            onChange: (value)=>password.text = value,
          ),
          WeInput(
            label: '确认新密码',
            hintText: '请输入确认新密码',
            labelWidth: 100,
            textAlign: TextAlign.center,
            clearable: true,
            obscureText: true,
            textInputAction: TextInputAction.next,
            onChange: (value)=>checkpassword.text = value,
          ),
            CustomButton(
                horizontal: 10.0,
                vertical: 10.0,
                title: "完成",
                onPressed: _finish,
                loading: Provider.of<RetrieveFinishViewmodel>(context).getIsLogin,
          ), 
        ],
      ),
    );
  }
  // 下一步
  void _finish() {
    context.read<RetrieveFinishViewmodel>().register(context,  password.text, checkpassword.text);
  }
  
}
