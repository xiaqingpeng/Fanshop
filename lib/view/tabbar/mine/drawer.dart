import 'dart:io';

import 'package:Fanshop/api/user.dart';
import 'package:Fanshop/getx/messages_getx.dart';
import 'package:Fanshop/utils/platform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';
import 'package:Fanshop/common/sharedPreferences.dart';
import 'package:Fanshop/view/splash.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/weui.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<MyDrawer> {
  final picker = ImagePicker();
  final String platform = getPlatform();
  Future<void> clearSharedPreferences() async {
    await SharedPreferencesUserUtils.deleteUserInfo("userInfo");
    Navigator.of(context)
        .pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const SplashView(),
          ),
          // ignore: unnecessary_null_comparison
          (route) => route == null,
        )
        .then(
          (value) => {
            // ignore: avoid_print
            print(value)
          },
        );
    WeToast.success(context)(message: '清除成功');
  }

  @override
  void initState() {
    updataUserInfo();
    super.initState();
  }

  void updataUserInfo() async {
    Map<dynamic, dynamic> userInfo =
        await SharedPreferencesUserUtils.getUserInfo("userInfo");
    final UserInfoController userInfoController = Get.put(
      UserInfoController(),
    ); //获取state的值
    userInfoController.changeUserInfo(userInfo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserInfoController>(
        init: UserInfoController(),
        builder: (UserInfoController c) {
          Map<dynamic, dynamic> userInfo = c.userInfo ?? {};
          print(userInfo);
          return Drawer(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    accountName: Text(
                      c.userInfo['nickname'],
                    ),
                    accountEmail: Text(
                      c.userInfo['uid'] ?? '',
                    ),
                    currentAccountPicture: InkWell(
                      // ignore: unnecessary_null_comparison
                      child: renderWidget(userInfo['images']),
                      onTap: () async {
                        final String platform = getPlatform();
                        if (platform == 'android' || platform == 'ios') {
                          final pickedFile =
                              await picker.getImage(source: ImageSource.camera);
                          final UserInfoController userInfoController = Get.put(
                            UserInfoController(),
                          ); //获取state的值
                          final Map params = {
                            ...c.userInfo,
                            "images": pickedFile?.path
                          };
                          userInfoController.changeUserInfo(params);
                          UpdateUserInfo.updateUserInfo(
                            params,
                            params['_id'],
                          );
                        } else {
                          WeToast.fail(context)(message: '$platform平台不支持相册功能');
                        }
                      },
                    ),
                  ),
                  WeCell(
                    label: 'language'.tr,
                    content: '',
                    footer:
                        const Icon(IconData(0xe85f, fontFamily: 'iconfont2')),
                    onClick: () =>
                        Navigator.of(context).pushNamed('international'),
                  ),
                  WeCell(
                    label: 'theme'.tr,
                    content: '',
                    footer:
                        const Icon(IconData(0xe601, fontFamily: 'iconfont2')),
                    onClick: () => Navigator.of(context).pushNamed('theme'),
                  ),
                  WeCell(
                    label: 'cache'.tr,
                    content: '',
                    footer:
                        const Icon(IconData(0xe61f, fontFamily: 'iconfont2')),
                    onClick: clearSharedPreferences,
                  ),
                  WeCell(
                    label: 'logout'.tr,
                    content: '',
                    footer:
                        const Icon(IconData(0xe71e, fontFamily: 'iconfont2')),
                    onClick: () => WeDialog.confirm(context)(
                      '确定退出登录嘛',
                      onConfirm: () {
                        Navigator.of(context).popAndPushNamed('login');

                        SharedPreferencesUserUtils.setUserInfo("userInfo", {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  renderWidget(images) {
    if (images != null && platform == 'web') {
      return CircleAvatar(backgroundImage: NetworkImage(images));
    }
    if (images != null && images.substring(0, 4) == 'http') {
      return CircleAvatar(backgroundImage: NetworkImage(images));
    }
    if (images != null && images.length > 0) {
      return Image.file(
        File(images),
        fit: BoxFit.cover,
        width: 70,
        height: 70,
      );
    }

    return const Icon(
      IconData(0xe638, fontFamily: 'iconfont2'),
      color: Colors.white,
      size: 70,
    );
  }
}
