import 'dart:convert';

import 'package:chatkid_mobile/models/auth_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
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
    await _instance!.preferences.setString('accessToken', token);
    await _instance!.preferences.setString('refreshToken', refreshToken);
  }

  Future<void> removeToken() async {
    await _instance!.preferences.remove('accessToken');
    await _instance!.preferences.remove('refreshToken');
  }

  AuthModel? getToken() {
    String? accessToken = _instance!.preferences.getString('accessToken');
    String? refreshToken = _instance!.preferences.getString('refreshToken');
    if (accessToken == null || refreshToken == null) {
      return null;
    }
    return AuthModel(token: accessToken!, refreshToken: refreshToken!);
  }

  String get(String key) {
    return jsonEncode(_instance!.preferences.getString(key)) ?? "";
  }

  UserModel getUser() {
    String user = _instance!.preferences.getString('user') ?? "{}";
    return UserModel.fromJson(jsonDecode(user));
  }
}
