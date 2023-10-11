import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class FamilyService {
  Future<FamilyModel> createFamily({required String name}) async {
    final body = FamilyRequestModel(name: name);
    Logger().d(LocalStorage.instance.getToken()!.token);
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.createFamilyEndPoint,
      body: body.toJson(),
    );

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      return FamilyModel.fromJson(jsonDecode(response.body));
    }
    switch (response.statusCode) {
      case 401:
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      default:
        throw Exception('Lỗi tạo tài khoản, vui lòng thử lại sau!');
    }
  }
}

final familyServiceProvider = Provider<FamilyService>((ref) {
  return FamilyService();
});
