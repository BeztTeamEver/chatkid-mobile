import 'dart:convert';

import 'package:chatkid_mobile/constants/date.dart';
import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class TodoService {
  final httpService = BaseHttp.instance;
  Future<PagingResponseModel<TaskModel>> getMemberTasks(
      String id, PagingModelWithFilter<TodoFilter> paging) async {
    // Fetch member tasks from the server
    final response = await httpService
        .get(endpoint: Endpoint.taskMemberEndpoint + "/$id", param: {
      'page-number': paging.pageNumber,
      'page-size': paging.pageSize,
      'search': paging.search ?? "",
      'status': paging.filter?.status ?? "",
      'date': paging.filter?.date.format(DateConstants.dateFormat) ?? "",
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<TaskModel> tasks = data["items"].map<TaskModel>((task) {
        return TaskModel.fromJson(task);
      }).toList();
      return PagingResponseModel(
        items: tasks,
        totalItem: data["totalItem"],
        pageSize: data["pageSize"],
        pageNumber: data["pageNumber"],
      );
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

  Future<TaskModel> getTaskDetail(String id) async {
    final response =
        await httpService.get(endpoint: Endpoint.taskEndPoint + "/$id");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return TaskModel.fromJson(data);
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

  Future<bool> pinTask(List<String> ids) async {
    final body = {
      'taskTypeIds': ids,
    };
    final response = await httpService.post(
      endpoint: Endpoint.favoriteTaskTypeEndPoint,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return true;
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

  Future<bool> unpinTask(String id) async {
    final response = await httpService.delete(
      endpoint: Endpoint.favoriteTaskTypeEndPoint + "/$id",
    );
    if (response.statusCode == 200) {
      return true;
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

  Future<bool> createTask(TodoCreateModel task) async {
    final response = await httpService.post(
      endpoint: Endpoint.taskEndPoint,
      body: task.toJson(),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
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

  Future<bool> deleteTask(String id) async {
    final response = await httpService.delete(
      endpoint: Endpoint.taskEndPoint + "/$id",
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
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
