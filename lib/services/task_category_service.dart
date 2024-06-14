import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';

class TaskCategoryService {
  final http = BaseHttp.instance;
  static Future<PagingResponseModel<TaskCategoryModel>>
      getTaskCategories() async {
    final response = await BaseHttp.instance
        .get(endpoint: Endpoint.taskCategoryEndPoint, param: {
      'page-name': 1,
      'limit': 10,
    });
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      return PagingResponseModel<TaskCategoryModel>.fromJson(
          jsonDecode(response.body));
    }
    switch (response.statusCode) {
      case 401:
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      default:
        throw Exception('Lỗi tạo gia đình, vui lòng thử lại sau!');
    }
  }
}
