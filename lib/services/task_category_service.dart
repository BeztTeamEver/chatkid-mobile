import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class TaskCategoryService {
  final http = BaseHttp.instance;
  Future<List<TaskCategoryModel>> getTaskCategories(PagingModel params) async {
    final response = await BaseHttp.instance
        .get(endpoint: Endpoint.taskCategoryEndPoint, param: {
      'page-number': params.pageNumber,
      'page-size': params.pageSize,
      'search': params.search ?? "",
    });
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final result = jsonDecode(response.body);
      final listTaskCategory = result['items']
          .map<TaskCategoryModel>((item) => TaskCategoryModel.fromJson(item))
          .toList();
      return listTaskCategory;
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

  Future<List<TaskCategoryImage>> getTaskTypeImage() async {
    final response =
        await BaseHttp.instance.get(endpoint: Endpoint.taskTypeImageEndpoint);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final result = jsonDecode(response.body);
      final listTaskCategoryImage = result
          .map<TaskCategoryImage>((item) => TaskCategoryImage.fromJson(item))
          .toList();
      return listTaskCategoryImage;
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

final taskCategoryServiceProvider =
    Provider<TaskCategoryService>((ref) => TaskCategoryService());
