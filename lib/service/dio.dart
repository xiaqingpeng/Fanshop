// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';

const String baseUrl = 'https://api.kids-creative.com.cn/';

class HttpController {
  static post(api, params) async {
    // ignore: avoid_print
    print("开始获取数据");
    Response response;
    Dio dio = Dio();

    try {
      // dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
      response = await dio.post(baseUrl + api, data: params);
     
      print("获取到的数据:" +(response.data).toString() );
    
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
    print("开始获取数据");
    Response response;
    Dio dio = new Dio();

    try {
      if (params != null && params.isNotEmpty) {
        response = await dio.get(baseUrl + api + params);
        // ignore: avoid_print
        print(response);

        if (response.statusCode == 200) {
          return response.data;
        } else {
          throw Exception('后端请求请求异常');
        }
      } else {
        response = await dio.get(baseUrl + api);
        // ignore: avoid_print
        print("$response  PPPPPPPPP");
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
