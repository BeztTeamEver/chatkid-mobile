import 'dart:async';
import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class UserService {
  final LocalStorage _localStorage = LocalStorage.instance;
  Future<UserModel> getUser(String id) async {
    final response = await BaseHttp.instance
        .get(endpoint: '${Endpoint.profileUserEndpoint}/${id}');
    Logger().d(response.body);

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    final response = await BaseHttp.instance.patch(
      endpoint: '${Endpoint.memberEnpoint}/${user.id}',
      body: jsonEncode(user.toMap()),
    );
    Logger().d(user.toJson());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<UserModel> createUser(UserModel user) async {
    final response = await BaseHttp.instance.post(
      endpoint: '${Endpoint.memberEnpoint}',
      body: user.toJson(),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final result = UserModel.fromJson(jsonDecode(response.body));
      return result;
    } else {
      switch (response.statusCode) {
        case 400:
          throw Exception('Lỗi dữ liệu không hợp lệ, vui lòng thử lại!');
        case 401:
          throw Exception(
              'Lỗi không thể xác thực người dùng, vui lòng thử lại!');
        case 403:
          throw Exception('Không có quyền tạo người dùng, vui lòng thử lại!');
        case 404:
          throw Exception('Không tìm thấy gia đình, vui lòng thử lại!');
        default:
          throw Exception(
              'Có lỗi xảy ra khi tạo người dùng, vui lòng thử lại!');
      }
    }
  }

  Future<UserModel> login(UserModel user) async {
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.memberLoginEnpoint,
      body: user.toJson(),
    );
    Logger().d(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final result = UserModel.fromJson(jsonDecode(response.body));
      _localStorage.saveUser(result);
      return result;
    } else {
      switch (response.statusCode) {
        case 401:
          throw Exception(
              'Lỗi không thể xác thực người dùng, vui lòng thử lại!');
        case 403:
          throw Exception('Mật khẩu không dúng, vui lòng thử lại!');
        case 404:
          throw Exception('Không tìm thấy gia đình, vui lòng thử lại!');
        default:
          throw Exception(
              'Không thể lấy thông tin gia đình, vui lòng thử lại!');
      }
    }
  }

  void Logout() {
    _localStorage.removeUser();
  }
}

class UserServiceNotifier extends StateNotifier<UserModel> {
  final UserService _userService = UserService();

  UserServiceNotifier() : super(UserModel());

  Future<UserModel> getUser(String id) async {
    try {
      UserModel result = await _userService.getUser(id);
      state = result;
      return result;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    try {
      UserModel result = await _userService.updateUser(user);
      await MeController().refetch();
      state = result;
      return result;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  // void subTractEnergy() {
  //   int current = state.wallets![0].totalEnergy! - 1;
  //   state.wallets![0].totalEnergy = current;
  // }
}

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

class MeController extends GetxController {
  Rx<UserModel> profile = LocalStorage.instance.getUser().obs;

  Rx<String> memberId = (LocalStorage.instance.getUser().id ?? '').obs;

  @override
  void onInit() {
    super.onInit();
    refetch();
  }

  refetch() async {
    await UserService().getUser(memberId.value).then((value) {
      Logger().d(value.toJson());
      profile.value = value;
    });
  }

  void updateProfile(UserModel newProfile) {
    profile.value = newProfile;
  }
}
