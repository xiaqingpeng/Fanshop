import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';
import 'package:kuangxianjiaoapp/common/sharedPreferences.dart';
import 'package:kuangxianjiaoapp/view/splash.dart';
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
  late Map<dynamic, dynamic> userInfo = {};
  File? _image;
  final picker = ImagePicker();
  Future pickerCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    userInfo['userimages'] = pickedFile?.path;
    print(userInfo.toString() + 'test');
    await SharedPreferencesUserUtils.setUserInfo("userInfo", userInfo);
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
    getUserInfo();
    super.initState();
  }

  Future<void> getUserInfo() async {
    Map<dynamic, dynamic> _userInfo =
        await SharedPreferencesUserUtils.getUserInfo("userInfo");
    setState(
      () {
        userInfo = _userInfo;
        if (userInfo["userimages"] != null) {
          _image = File(userInfo["userimages"]);
        }
      },
    );
  }

  Future<void> clearSharedPreferences() async {
    await SharedPreferencesUserUtils.deleteUserInfo("userInfo");
    Navigator.of(context)
        .pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const SplashView()),
          // ignore: unnecessary_null_comparison
          (route) => route == null,
        )
        .then((value) => {
              // ignore: avoid_print
              print(value)
            });
    WeToast.success(context)(message: '清除成功');
  }

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
              accountName: Text(userInfo["fullname"] ?? ''),
              accountEmail: Text(userInfo["telephone"] ?? ''),
              currentAccountPicture: ClipOval(
                child: InkWell(
                  // ignore: unnecessary_null_comparison
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        )
                      : Image.asset(
                          "assets/launcher/launcher.png",
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        ),
                  onTap: pickerCamera,
                ),
              ),
            ),
            WeCell(
              label: 'language'.tr,
              content: '',
              footer: const Icon(IconData(0xe85f, fontFamily: 'iconfont2')),
              onClick: () => Navigator.of(context).pushNamed('international'),
            ),
            WeCell(
              label: 'theme'.tr,
              content: '',
              footer:  const Icon(IconData(0xe593, fontFamily: 'iconfont2')),
              onClick: () => Navigator.of(context).pushNamed('theme'),
            ),
            WeCell(
              label: 'cache'.tr,
              content: '',
              footer:  const Icon(IconData(0xe61f, fontFamily: 'iconfont2')),
              onClick: clearSharedPreferences,
            ),
            WeCell(
              label: 'logout'.tr,
              content: '',
              footer: const Icon(IconData(0xe71e, fontFamily: 'iconfont2')),
              onClick: () => WeDialog.confirm(context)(
                '确定退出登录嘛',
                onConfirm: () {
                  Navigator.of(context).popAndPushNamed('login');
                  userInfo["loginstatus"] = 0;
                  SharedPreferencesUserUtils.setUserInfo("userInfo", userInfo);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
