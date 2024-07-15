import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TargetService {
  final baseHttp = BaseHttp.instance;

  Future<List<TargetModel>> getTargetByMember(String memberId) async {
    final response = await baseHttp.get(
        endpoint: Endpoint.memberTargetEndpoint + "/$memberId");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      final List<TargetModel> targets =
          data["items"].map<TargetModel>((target) {
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
}

final targetServiceProvider = Provider((ref) => TargetService());
