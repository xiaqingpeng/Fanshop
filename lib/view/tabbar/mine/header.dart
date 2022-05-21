// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Fanshop/custom/custom_button.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<HeaderPage> {
  File? _imgPath;
  final picker = ImagePicker();
  /*拍照*/
  // ignore: unused_element
  _takePhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
     setState(
      () {
        if (pickedFile != null) {
          _imgPath = File(pickedFile.path);
        } else {
          // ignore: avoid_print
          print('No image selected.');
        }
      },
    );

   
  }

  /*相册*/
  _openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(
      () {
        if (pickedFile != null) {
          _imgPath = File(pickedFile.path);
        } else {
          // ignore: avoid_print
          print('No image selected.');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      alignment: Alignment.center,
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.bottomLeft,
      //     end: Alignment.topRight,
      //     colors: [
      //       Colors.cyanAccent,
      //       Colors.purple,
      //       Colors.cyanAccent,
      //     ],
      //   ),
      // ),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: ClipOval(
                child: InkWell(
                  child: _imgPath == null
                      ? Image.asset(
                          "assets/launcher/launcher.png",
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          _imgPath!,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                  onTap: () => {_openGallery()},
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
                            CustomButton(
                              content: const Text(
                                '取消',
                                style: TextStyle(color: Colors.white),
                              ),
                              borderRadius: 4.0,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              width: MediaQuery.of(context).size.width * 0.5,
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
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 40,
                            )
                          ]);
                    })
              },
              child: const Text(
                '夏庆鹏',
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
