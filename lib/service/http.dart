// ignore_for_file: unnecessary_string_interpolations

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Fanshop/common/sharedPreferences.dart';

const String baseUrl = 'http://127.0.0.1:7001/';

class HttpController {
  static getAuthorization() async {
    final userInfo = await SharedPreferencesUserUtils.getUserInfo("userInfo");
    if (userInfo != null) {
      return userInfo['token'];
    }
    return userInfo;
  }

  static final headers = <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'POST,GET,DELETE,PUT,OPTIONS',
    'Accept': '*/*',
    "authorization": getAuthorization()
  };
  static Future<dynamic> get(String api,
      {required Map<String, dynamic> params, Function? errorCallback}) async {
    var url = baseUrl + api;
    if (params.isNotEmpty) {
      StringBuffer sb = StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" "=" "$value" "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      http.Response res = await http.get(Uri.parse(url), headers: headers);
      print(res.body.toString() + 'test');
      return res.body;
    } catch (exception) {
      print(exception.toString() + 'exception');
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  static Future<String> post(String api,
      {required Map<String, dynamic> params, Function? errorCallback}) async {
    var url = baseUrl + api;
    try {
      http.Response res =
          await http.post(Uri.parse(url), body: params, headers: headers);
      // ignore: avoid_print
      print(res.body.toString() + 'test');
      return json.decode(res.body);
    } catch (e) {
      print(e.toString() + 'e');
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }
}
