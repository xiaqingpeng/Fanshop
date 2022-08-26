// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:Fanshop/api/user.dart';
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
  Widget build(BuildContext context) {
    return GetBuilder<UserInfoController>(
      init: UserInfoController(),
      builder: (UserInfoController c) {
        return Container(
          height: 200.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.redAccent,
                Colors.yellowAccent,
                Colors.blueAccent,
              ],
            ),
          ),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipOval(
                    child: InkWell(
                      child: renderWidget(c.userInfo['images']),
                      onTap: () => {_openGallery(c)},
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: 40,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: 40,
                                    )
                                  ],
                                )
                              ]);
                        })
                  },
                  child: Text(
                    c.userInfo['fullname'] ?? '',
                    style: const TextStyle(
                        // color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  renderWidget(images) {
    if (images != null&& platform == 'web' ) {
      return Image.network(
        //如成功显示用户头像
        images, //头像地址,
        width: 80,
        height: 80,
      );
    }
    if (images != null) {
      return Image.file(
        File(images),
        fit: BoxFit.cover,
        width: 80,
        height: 80,
      );
    }
    return const Icon(
      IconData(0xe67c, fontFamily: 'iconfont2'),
      size: 80,
    );
  }
}
