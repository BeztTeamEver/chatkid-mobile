import 'dart:convert';

import 'package:chatkid_mobile/constants/local_storage.dart';
import 'package:chatkid_mobile/models/auth_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/user_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _instance;
  SharedPreferences preferences;

  LocalStorage._(this.preferences);

  static Future<LocalStorage> getInstance() async {
    if (_instance == null) {
      final prefs = await SharedPreferences.getInstance();
      _instance = LocalStorage._(prefs);
    }
    return _instance!;
  }

  static LocalStorage get instance => _instance!;

  Future<bool> clear() async {
    return await _instance!.preferences.clear();
  }

  Future<void> saveToken(String token, String refreshToken) async {
    await _instance!.preferences.setString(LocalStorageKey.ACCESS_TOKEN, token);
    await _instance!.preferences
        .setString(LocalStorageKey.REFRESH_TOKEN, refreshToken);
  }

  Future<void> removeToken() async {
    await _instance!.preferences.remove(LocalStorageKey.ACCESS_TOKEN);
    await _instance!.preferences.remove(LocalStorageKey.REFRESH_TOKEN);
  }

  AuthModel? getToken({bool? isUseFamilyToken = false}) {
    String? accessToken =
        _instance!.preferences.getString(LocalStorageKey.ACCESS_TOKEN);
    String? refreshToken =
        _instance!.preferences.getString(LocalStorageKey.REFRESH_TOKEN);
    UserModel user = getUser();

    if (isUseFamilyToken != null && isUseFamilyToken) {
      return AuthModel(
          accessToken: accessToken ?? "", refreshToken: refreshToken ?? "");
    }

    if (user.accessToken != null) {
      return AuthModel(accessToken: user.accessToken!, refreshToken: "");
    }

    if (accessToken == null || refreshToken == null) {
      return null;
    }
    Logger().i("accessToken: $accessToken, refreshToken: $refreshToken");
    return AuthModel(accessToken: accessToken, refreshToken: refreshToken);
  }

  String get(String key) {
    return jsonEncode(_instance!.preferences.getString(key)) ?? "";
  }

  String getString(String key) {
    return _instance!.preferences.getString(key) ?? "";
  }

  void setString(String key, String value) {
    _instance!.preferences.setString(key, value);
  }

  Future<void> saveUser(UserModel user) async {
    MeController meController = Get.find();
    await _instance!.preferences.setString(LocalStorageKey.USER, user.toJson());
    meController.refetch();
  }

  UserModel getUser() {
    String user =
        _instance!.preferences.getString(LocalStorageKey.USER) ?? "{}";
    return UserModel.fromJson(jsonDecode(user));
  }

  Future<void> removeUser() async {
    await _instance!.preferences.remove(LocalStorageKey.USER);
  }
}
