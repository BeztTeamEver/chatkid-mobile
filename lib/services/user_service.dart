import 'dart:async';
import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserService {
  Future<UserModel> getUser(id) async {
    final response =
        await BaseHttp.instance.get(endpoint: '${Endpoint.userEndPoint}/$id');
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<ResponseModel<dynamic>> updateUser(UserModel user) async {
    final response = await BaseHttp.instance.put(
      endpoint: '${Endpoint.userEndPoint}/${user.id}',
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return ResponseModel<dynamic>.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }
}

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});
