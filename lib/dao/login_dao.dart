// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:LinJia/models/entity_factory.dart';
import 'package:LinJia/models/login_entity.dart';
import 'dart:async';
import 'config.dart';

const LOGIN_URL = '$SERVER_HOST/loginByPass';

class LoginDao {
  static Future<LoginEntity?> fetch(String userName, String password) async {
    try {
      Map<String, dynamic> map = {"mobile": userName, "password": password};
      Response response = await Dio().post(LOGIN_URL, queryParameters: map);
      if (response.statusCode == 200) {
        return EntityFactory.generateOBJ<LoginEntity>(response.data);
      } else {
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
