import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/statistic_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:logger/logger.dart';

class StatisticService {
  Future<StatisticTaskModel> getStatisticTask(String memberId, String startDate, String endDate) async {
    final response = await BaseHttp.instance.get(
      endpoint: "${Endpoint.statisticTaskEndPoint}/$memberId?startDate=$startDate&endDate=$endDate",
    );
    Logger().d(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      return StatisticTaskModel.fromJson(jsonDecode(response.body));
    }
    switch (response.statusCode) {
      case 401:
        LocalStorage.instance.clear();
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        LocalStorage.instance.clear();
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      case 404:
        LocalStorage.instance.clear();
        throw Exception('Không tìm thấy thông tin thống kê, vui lòng thử lại!');
      default:
        throw Exception(
            'Không thể lấy thông tin thống kê, vui lòng thử lại!');
    }
  }

  Future<List<StatisticEmotionModel>> getStatisticEmotion(String memberId, String startDate, String endDate) async {
    final response = await BaseHttp.instance.get(
      endpoint: "${Endpoint.statisticEmotionEndPoint}/$memberId?startDate=$startDate&endDate=$endDate",
    );
    Logger().d(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      List data = jsonDecode(response.body);
      return data.map((res) => StatisticEmotionModel.fromJson(res)).toList();
    }
    switch (response.statusCode) {
      case 401:
        LocalStorage.instance.clear();
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        LocalStorage.instance.clear();
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      case 404:
        LocalStorage.instance.clear();
        throw Exception('Không tìm thấy thông tin thống kê, vui lòng thử lại!');
      default:
        throw Exception(
            'Không thể lấy thông tin thống kê, vui lòng thử lại!');
    }
  }
}
