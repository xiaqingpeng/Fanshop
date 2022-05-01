import 'dart:io';
import 'package:flutter/foundation.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_is_emulator/flutter_is_emulator.dart';

class PlatformUtils {
  static bool _isWeb() {
    return kIsWeb == true;
  }

  static bool _isAndroid() {
    return _isWeb() ? false : Platform.isAndroid;
  }

  static bool _isIOS() {
    return _isWeb() ? false : Platform.isIOS;
  }

  static bool _isMacOS() {
    return _isWeb() ? false : Platform.isMacOS;
  }

  static bool _isWindows() {
    return _isWeb() ? false : Platform.isWindows;
  }

  static bool _isFuchsia() {
    return _isWeb() ? false : Platform.isFuchsia;
  }

  static bool _isLinux() {
    return _isWeb() ? false : Platform.isLinux;
  }

  // 判断是否是模拟器
  // ignore: unused_element
  // static Future<bool> _isAnEmulator() async {
  //   bool isAnEmulator = await FlutterIsEmulator.isDeviceAnEmulatorOrASimulator;
  //   return isAnEmulator;
  // }

  // 判断是否是生产环境
  // ignore: unused_element
  static bool _isProd() {
    const isProd = bool.fromEnvironment('dart.vm.product');
    return isProd;
  }

  static bool get isWeb => _isWeb();

  static bool get isAndroid => _isAndroid();

  static bool get isIOS => _isIOS();

  static bool get isMacOS => _isMacOS();

  static bool get isWindows => _isWindows();

  static bool get isFuchsia => _isFuchsia();

  static bool get isLinux => _isLinux();
  static bool get isProd => _isProd(); // 判断是否是生产环境

  // static Future<bool> get isAnEmulator => _isAnEmulator(); // 判断是否是模拟器
}
