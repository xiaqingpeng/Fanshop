// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: prefer_collection_literals, unnecessary_new

import 'package:Fanshop/utils/platform.dart';
import 'package:dio/dio.dart';
import 'package:Fanshop/common/SharedPreferences.dart';

String baseUrl = PlatformUtils.isProd == true
    ? 'http://43.138.203.36:7001/'
    // : 'http://10.0.2.2:7001/';
   // : 'http://127.0.0.1:7001/';
: 'http://43.138.203.36:7001/';

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

  static post(String api, params) async {
    print(PlatformUtils.isProd);
    // ignore: avoid_print
    print("开始获取数据");
    Response response;
    Dio dio = Dio();
    // dio.options.headers= headers;//设置当前的refreshToken
    try {
      // dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
      response = await dio.post(baseUrl + api, data: params);

      // print("获取到的数据:" + (response.data).toString());

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('后端请求请求异常');
      }
      // ignore: empty_catches
    } catch (e) {
      print(e.toString());
    }
  }

  static get(api, params) async {
    // print(params.toString() + "开始获取数据");
    Response response;
    Dio dio = new Dio();

    try {
      if (params.isNotEmpty) {
        response = await dio.get(baseUrl + api, queryParameters: params);
        // ignore: avoid_print
        // print(response);

        if (response.statusCode == 200) {
          return response.data;
        } else {
          throw Exception('后端请求请求异常');
        }
      } else {
        response = await dio.get(baseUrl + api, queryParameters: params);
        // // ignore: avoid_print
        // print("$response  PPPPPPPPP");
        if (response.statusCode == 200) {
          return response.data;
        } else {
          throw Exception('后端请求请求异常');
        }
      }
    } catch (e) {
      throw Exception('后台数据请求失败：$e');
    }
  }
}
