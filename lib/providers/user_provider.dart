import 'dart:convert';

import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final updateUserProvider =
    FutureProvider.autoDispose.family<UserModel, UserModel>(((ref, arg) async {
  try {
    final response = await ref.watch(userServiceProvider).updateUser(arg);
    return response;
  } catch (err) {
    throw err;
  }
}));

final getcurrentUserProvider = Provider((ref) {
  final user = LocalStorage.instance.preferences.getString('user');
  return UserModel.fromJson(jsonDecode(user ?? ""));
});

final userProvider =
    StateNotifierProvider<UserServiceNotifier, UserModel>((ref) {
  return UserServiceNotifier();
});
