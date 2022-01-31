import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';
import 'package:kuangxianjiaoapp/common/sharedPreferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';
import 'dart:io';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<MyDrawer> {
  File _image=File("https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3024387196,1621670548&fm=27&gp=0.jpg");

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          // ignore: avoid_print
          print('No image selected.');
        }
      },
    );
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  Future getSharedPreferences() async {}
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('邝献骄'),
              accountEmail: const Text('626143872@qq.com'),
              currentAccountPicture: ClipOval(
                child: InkWell(
                  // ignore: unnecessary_null_comparison
                  child: _image == null
                      ? Image.asset(
                          "assets/launcher/launcher.png",
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        )
                      : Image.file(
                          _image,
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        ),
                  onTap: getImage,
                ),
              ),
            ),
            WeCell(
              label: '支出上限',
              onClick: () {},
            ),
            WeCell(
              label: '注册日期',
              onClick: () {},
            ),
            WeCell(
              label: '设置主题',
              content: '',
              footer: const Icon(Icons.colorize),
              onClick: () => Navigator.of(context).pushNamed('theme'),
            ),
            WeCell(
              label: '退出登录',
              content: '',
              footer: const Icon(Icons.exit_to_app),
              onClick: () => WeDialog.confirm(context)(
                '确定退出登录嘛',
                onConfirm: () {
                  Navigator.of(context).popAndPushNamed('login');
                  SharedPreferencesUserUtils.setUserInfo(
                    "userInfo",
                    {
                      "loginstatus": 0,
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}
