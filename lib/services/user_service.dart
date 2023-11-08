import 'dart:async';
import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class UserService {
  Future<UserModel> getUser(id, String? password) async {
    final response =
        await BaseHttp.instance.get(endpoint: '${Endpoint.userEndPoint}/$id');
    Logger().d(response.body);

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    final response = await BaseHttp.instance.put(
      endpoint: '${Endpoint.userEndPoint}/${user.id}',
      body: jsonEncode(user.toMap()),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }
}

class UserServiceNotifier extends StateNotifier<UserModel> {
  final UserService _userService = UserService();

  UserServiceNotifier() : super(UserModel());

  Future<UserModel> getUser(id, String? password) async {
    try {
      UserModel result = await _userService.getUser(id, password);
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
      state = result;
      return result;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  void subTractEnergy() {
    int current = state.wallets![0].totalEnergy! - 1;
    state.wallets![0].totalEnergy = current;
  }
}

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});
