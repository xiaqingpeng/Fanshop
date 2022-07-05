import 'package:dio/dio.dart';
import 'package:LinJia/models/entity_factory.dart';
import 'package:LinJia/models/topic_details_entity.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'config.dart';

const TOPIC_DETAIL_URL = '$SERVER_HOST/topic/';

class TopicDetailsDao {
  static Future<TopicDetailsEntity?> fetch(String id) async {
    try {
      Response response = await Dio().get(TOPIC_DETAIL_URL + id);
      if (response.statusCode == 200) {
        print(response.data.toString()+ 'response.data');
        return EntityFactory.generateOBJ<TopicDetailsEntity>(response.data);
      } else {
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
