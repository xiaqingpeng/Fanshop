// import 'package:Fanshop/common/storage.dart';
import 'package:Fanshop/common/SharedPreferences.dart';
import 'package:Fanshop/service/dio.dart';
// ignore: unused_import
import 'package:Fanshop/utils/platform.dart';

// 获取平台
String getPlatform() {
  if (PlatformUtils.isAndroid == true) return 'android';
  if (PlatformUtils.isWindows == true) return 'windows';
  if (PlatformUtils.isWeb == true) return 'web';
  if (PlatformUtils.isIOS == true) return 'ios';
  if (PlatformUtils.isMacOS == true) return 'macos';
  if (PlatformUtils.isLinux == true) return 'macos';
  if (PlatformUtils.isFuchsia == true) return 'fuchsia';
  return '平台待定';
}

// 获取商品分类
class AddLogs {
  Future addLogs(String? desc, Map<dynamic, dynamic>? data) async {
    Map<dynamic, dynamic> userInfo =
        await SharedPreferencesUserUtils.getUserInfo("userInfo");
    await HttpController.post("api/add_logs", {
      "handler": userInfo['telephone'].toString(),
      "desc": desc,
      "data": data,
      "platform": getPlatform(),
    });
  }
}
