// ignore_for_file: unnecessary_string_interpolations

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

const String baseUrl = 'https://api.kids-creative.com.cn/';

class HttpController {
  static final headers = <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'POST,GET,DELETE,PUT,OPTIONS',
    'Accept': '*/*'
  };
  static void get(String api, Function callback,
      {required Map<String, String> params, Function? errorCallback}) async {
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
      http.Response res = await http.get(Uri.parse(url), headers:headers);
      callback(res.body);
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  static void post(String api, Function callback,
      {required Map<String, String> params, Function? errorCallback}) async {
    var url = baseUrl + api;
    try {
      http.Response res = await http.post(Uri.parse(url), body: params,
      headers:headers
      
      );

      callback(res.body);
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }
}
