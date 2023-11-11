import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class FamilyService {
  Future<ResponseModel<dynamic>> createFamily({required String name}) async {
    final body = FamilyRequestModel(name: name);
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.familiesEndPoint,
      body: body.toJson(),
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      return ResponseModel.fromJson(jsonDecode(response.body));
    }
    switch (response.statusCode) {
      case 401:
        LocalStorage.instance.clear();
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        LocalStorage.instance.clear();
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      default:
        throw Exception('Lỗi tạo gia đình, vui lòng thử lại sau!');
    }
  }

  Future<List<UserModel>> getFamilyAccounts(
    FamilyRequestModel? familyRequestModel,
  ) async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.infoEndpoint,
      param: {
        'id': familyRequestModel?.id,
        'email': familyRequestModel?.email,
      },
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      final family = FamilyModel.fromJson(data);
      return family.users;
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
        throw Exception('Không tìm thấy gia đình, vui lòng thử lại!');
      default:
        throw Exception('Không thể lấy thông tin gia đình, vui lòng thử lại!');
    }
  }
}

final familyServiceProvider = Provider<FamilyService>((ref) {
  return FamilyService();
});

class FamilyServiceNotifier extends StateNotifier<FamilyModel> {
  final FamilyService _familyService = FamilyService();

  FamilyServiceNotifier()
      : super(FamilyModel(
          id: "",
          name: "",
          ownerMail: "",
          status: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          users: [],
        ));

  Future<List<UserModel>> getFamilyAccounts(
    FamilyRequestModel? familyRequestModel,
  ) async {
    try {
      final data = await _familyService.getFamilyAccounts(familyRequestModel);
      state = FamilyModel(
        id: familyRequestModel?.id ?? "",
        name: familyRequestModel?.name ?? "",
        ownerMail: familyRequestModel?.email ?? "",
        status: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        users: data,
      );
      return data;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }
}
