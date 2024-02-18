import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/channel_model.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class FamilyService {
  LocalStorage _localStorage = LocalStorage.instance;

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
      Logger().d(response.body);
      final family = FamilyModel.fromJson(data);
      return family.members;
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

  Future<List<UserModel>> getKidAccounts(
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
      Logger().d(response.body);
      final data = jsonDecode(response.body);
      final family = FamilyModel.fromJson(data);
      Logger().d(family.members.where((e) => e.role == 'Children').toList());
      return family.members.where((e) => e.role == 'Children').toList();
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

  Future<FamilyModel> getFamily() async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.ownFamilyEndpoint,
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);

      Logger().i(response.body);
      final family = FamilyModel.fromJson(data);

      return family;
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

  Future<ChannelModel> getFamilyChannel() async {
    final familyId = _localStorage.getUser().familyId ?? '';
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.familyChannelsEndPoint.replaceFirst('{id}', familyId),
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      Logger().i(response.body);
      final channel = ChannelModel.fromJson(data);
      return channel;
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
          familyId: "",
          familyName: "",
          familyEmail: "",
          // status: 0,
          // createdAt: DateTime.now(),
          // updatedAt: DateTime.now(),
          members: [],
        ));

  Future<List<UserModel>> getFamilyAccounts(
    FamilyRequestModel? familyRequestModel,
  ) async {
    try {
      final data = await _familyService.getFamilyAccounts(familyRequestModel);
      state = FamilyModel(
        familyId: familyRequestModel?.id ?? "",
        familyName: familyRequestModel?.name ?? "",
        familyEmail: familyRequestModel?.email ?? "",
        // status: 0,
        // createdAt: DateTime.now(),
        // updatedAt: DateTime.now(),
        members: data,
      );
      return data;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }
}
