// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:Fanshop/api/user.dart';
import 'package:Fanshop/common/SharedPreferences.dart';
import 'package:Fanshop/getx/messages_getx.dart';
import 'package:Fanshop/utils/platform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Fanshop/custom/custom_button.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:weui/toast/index.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<HeaderPage> {
  final picker = ImagePicker();
  final String platform = getPlatform();
  /*拍照*/
  // ignore: unused_element
  _takePhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(
      () {
        if (pickedFile != null) {
        } else {
          // ignore: avoid_print
          print('No image selected.');
        }
      },
    );
  }

  /*相册*/
  _openGallery(c) async {
    if (platform == 'android' || platform == 'ios') {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      final UserInfoController userInfoController = Get.put(
        UserInfoController(),
      ); //获取state的值
      final Map params = {...c.userInfo, "images": pickedFile?.path};
      userInfoController.changeUserInfo(params);
      UpdateUserInfo.updateUserInfo(
        params,
        params['_id'],
      );
    } else {
      WeToast.fail(context)(message: '$platform平台不支持相册功能');
    }
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
        final List navigatorList = [
          {
            'name': '积分',
            'id': userInfo['score'],
          },
          {
            'name': '反馈',
            'id': userInfo['feedback'],
          },
          {
            'name': '收藏',
            'id': userInfo['favorite'],
          },
          {
            'name': '浏览',
            'id': userInfo['record'],
          },
        ];

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.bottomLeft,
              //   end: Alignment.topRight,
              //   colors: [
              //     Colors.redAccent,
              //     Colors.yellowAccent,
              //     Colors.blueAccent,
              //   ],
              // ),
              color: Theme.of(context).primaryColor),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipOval(
                      child: InkWell(
                        child: renderWidget(userInfo['images']),
                        onTap: () => {_openGallery(c)},
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () => {
                      showDialog(
                          // 传入 context
                          context: context,
                          barrierDismissible: false,
                          // 构建 Dialog 的视图
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: const Text('我的登录'),
                                content: const Text('你确定登录吗？'),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomButton(
                                        content: const Text(
                                          '取消',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        borderRadius: 4.0,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      CustomButton(
                                        content: const Text(
                                          '确定',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        borderRadius: 4.0,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height: 30,
                                      )
                                    ],
                                  )
                                ]);
                          })
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (userInfo['nickname'] ?? ''),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          userInfo['uid'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 60.0,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: navigatorList.map((item) {
                    return Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          item['id'].toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          item['name'],
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  renderWidget(images) {
    if (images != null && platform == 'web') {
      return Image.network(
        //如成功显示用户头像
        images, //头像地址,
        width: 70,
        height: 70,
      );
    }
    if (images != null && images.substring(0, 4) == 'http') {
      return Image.network(
        images,
        fit: BoxFit.cover,
        width: 70,
        height: 70,
      );
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
      IconData(0xe67c, fontFamily: 'iconfont2'),
      size: 70,
    );
  }
}
