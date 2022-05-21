import 'package:Fanshop/service/dio.dart';

class UpdateUserInfo {
  static Future updateUserInfo(Map params, String id) async {
    await HttpController.post("api/update/$id", params);
  }
}
