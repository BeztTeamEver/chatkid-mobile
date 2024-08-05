import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/quiz_model.dart';
import 'package:chatkid_mobile/models/topic_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:logger/logger.dart';

class QuizService {
  Future<List<TopicModel>> getTopics() async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.listTopicEndPoint,
    );
    Logger().d(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      List data = jsonDecode(response.body);
      final res = data.map((res) => TopicModel.fromJson(res)).toList();
      return res;
    }
    switch (response.statusCode) {
      case 401:
        LocalStorage.instance.clear();
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      default:
        throw Exception('Không thể lấy thông tin các chủ đề!');
    }
  }

  Future<TopicDetailModel> getTopicById(String id) async {
    final response = await BaseHttp.instance
        .get(endpoint: Endpoint.detailTopicEndPoint.replaceFirst("{id}", id));
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      return TopicDetailModel.fromJson(data);
    }
    switch (response.statusCode) {
      case 401:
        LocalStorage.instance.clear();
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      default:
        throw Exception('Không thể lấy thông tin chủ đề!');
    }
  }

  Future<QuizModel> getQuizById(String id) async {
    final response = await BaseHttp.instance
        .get(endpoint: Endpoint.quizByIdEndPoint.replaceFirst("{id}", id));
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      return QuizModel.fromJson(data);
    }
    switch (response.statusCode) {
      case 401:
        LocalStorage.instance.clear();
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      default:
        throw Exception('Không thể lấy thông tin chủ đề!');
    }
  }
}
