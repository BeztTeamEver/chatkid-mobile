import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TargetService {
  final baseHttp = BaseHttp.instance;

  Future<List<TargetModel>> getTargetByMember(
      TargetListRequestModel request) async {
    final response = await baseHttp.get(
        endpoint: Endpoint.memberTargetEndpoint + "/${request.memberId}",
        param: {
          'page-umber': 0,
          'page-size': 1000,
          'date': '${request.date.toIso8601String()}Z'
        });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final List<TargetModel> targets = data.map<TargetModel>((target) {
        return TargetModel.fromJson(target);
      }).toList();
      return targets;
    }
    if (response.statusCode == 401) {
      throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
    } else if (response.statusCode == 403) {
      throw Exception(
          'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
    } else if (response.statusCode == 404) {
      throw Exception('Không tìm thấy mục tiêu, vui lòng thử lại!');
    } else {
      throw Exception('Không thể lấy thông tin mục tiêu, vui lòng thử lại!');
    }
  }

  Future<List<TargetModel>> getTargetTemplate() async {
    final response =
        await baseHttp.get(endpoint: Endpoint.targetEndpoint, param: {
      'page-number': 0,
      'page-size': 1000,
      'is-template': true,
    });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final List<TargetModel> targets =
          data['items'].map<TargetModel>((target) {
        return TargetModel.fromJson(target);
      }).toList();
      return targets;
    }
    if (response.statusCode == 401) {
      throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
    } else if (response.statusCode == 403) {
      throw Exception(
          'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
    } else if (response.statusCode == 404) {
      throw Exception('Không tìm thấy mục tiêu, vui lòng thử lại!');
    } else {
      throw Exception('Không thể lấy thông tin mục tiêu, vui lòng thử lại!');
    }
  }

  Future<dynamic> createTarget(TargetRequestModal target) async {
    final response = await baseHttp.post(
        endpoint: Endpoint.targetEndpoint, body: target.toJson());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // final data = TargetModel.fromJson(jsonDecode(response.body));
      return true;
    }
    if (response.statusCode == 401) {
      throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
    } else if (response.statusCode == 403) {
      throw Exception(
          'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
    } else {
      throw Exception('Không thể tạo mục tiêu, vui lòng thử lại!');
    }
  }

  Future<TargetModel> updateTarget(String id, TargetRequestModal target) async {
    final response = await baseHttp.patch(
        endpoint: Endpoint.targetEndpoint + "/${id}", body: target.toJson());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final target = TargetModel.fromJson(data);
      return target;
    }
    if (response.statusCode == 401) {
      throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
    } else if (response.statusCode == 403) {
      throw Exception(
          'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
    } else {
      throw Exception('Không thể cập nhật mục tiêu, vui lòng thử lại!');
    }
  }

  Future<bool> deleteTarget(String id) async {
    final response = await baseHttp.delete(
      endpoint: Endpoint.targetEndpoint + "/$id",
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    }
    if (response.statusCode == 401) {
      throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
    } else if (response.statusCode == 403) {
      throw Exception(
          'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
    } else {
      throw Exception('Không thể xóa mục tiêu, vui lòng thử lại!');
    }
  }

  Future<TargetModel> getTargetDetail(String id) async {
    final response =
        await baseHttp.get(endpoint: Endpoint.targetEndpoint + "/$id");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final target = TargetModel.fromJson(data);
      return target;
    }
    if (response.statusCode == 401) {
      throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
    } else if (response.statusCode == 403) {
      throw Exception(
          'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
    } else if (response.statusCode == 404) {
      throw Exception('Không tìm thấy mục tiêu, vui lòng thử lại!');
    } else {
      throw Exception('Không thể lấy thông tin mục tiêu, vui lòng thử lại!');
    }
  }
}

final targetServiceProvider = Provider((ref) => TargetService());
