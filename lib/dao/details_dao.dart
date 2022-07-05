import 'package:dio/dio.dart';
import 'package:LinJia/models/details_entity.dart';
import 'package:LinJia/models/entity_factory.dart';
import 'dart:async';
import 'config.dart';

const FINDING_URL = '$SERVER_HOST/goods/';

class DetailsDao {
  static Future<DetailsEntity?> fetch(String id) async {
    try {
      Response response = await Dio().get(FINDING_URL + id);
      if (response.statusCode == 200) {
        return EntityFactory.generateOBJ<DetailsEntity>(response.data);
      } else {
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
