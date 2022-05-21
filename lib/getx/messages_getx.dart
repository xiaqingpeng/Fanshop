import 'package:Fanshop/common/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  void changeLanguage(String languageCode, String countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
  }
}

class LanguageController extends GetxController {
  int _count = 0.obs();
  int get count => _count;
  void language(int index) {
    _count = index;
    update();
  }
}

class UserInfoController extends GetxController {
  Map _userInfo = {}.obs;
  get userInfo => _userInfo;
  void changeUserInfo(Map params) async {
    _userInfo = params;
    await SharedPreferencesUserUtils.setUserInfo("userInfo", _userInfo);
    update();
  }
}
