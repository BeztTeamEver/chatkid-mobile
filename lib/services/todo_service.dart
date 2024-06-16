import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoService {
  final httpService = BaseHttp.instance;
  Future<PagingResponseModel<TaskModel>> getMemberTasks(String id) async {
    // Fetch member tasks from the server
    final response =
        await httpService.get(endpoint: Endpoint.taskMemberEndpoint + "/$id");

    if (response.statusCode == 200) {
      // final data = jsonDecode(response.body);
      // final List<TaskModel> tasks = data.map<TaskModel>((task) {
      //   return TaskModel.fromJson(task);
      // }).toList();
      // return tasks;
    }
    switch (response.statusCode) {
      case 401:
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      case 404:
        throw Exception('Không tìm thấy gói, vui lòng thử lại!');
      default:
        throw Exception('Không thể lấy thông tin gói, vui lòng thử lại!');
    }
  }
}

final todoServiceProvider = Provider<TodoService>((ref) {
  return TodoService();
});
