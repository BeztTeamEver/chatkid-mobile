import 'dart:convert';

import 'package:chatkid_mobile/modals/auth_modal.dart';
import 'package:chatkid_mobile/modals/resgis_modal.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';

class AuthService {
  static const _googleEndPoint = "/api/auth/google-auth";
  static const _regisEndPoint = "/api/auth/register";
  static final _localStorage = LocalStorage.instance;

  static Future<AuthModal> googleLogin(String token) async {
    RequestAuthModal requestAuthModal = RequestAuthModal(accessToken: token);
    final response = await BaseHttp.instance.post(
      endpoint: _googleEndPoint,
      body: requestAuthModal.toJson(),
    );

    if (response.statusCode == 200) {
      final authTokens = AuthModal.fromJson(jsonDecode(response.body));

      await _localStorage.saveToken(
        authTokens.token,
        authTokens.refreshToken,
      );
      return authTokens;
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<RegisModal> signUp(String token) async {
    final RequestAuthModal requestAuthModal =
        RequestAuthModal(accessToken: token);

    final response = await BaseHttp.instance.post(
      endpoint: _regisEndPoint,
      body: requestAuthModal.toJson(),
    );

    if (response.statusCode == 200) {
      return RegisModal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<bool> signOut() async {
    // TODO: call api sign out here
    await _localStorage.removeToken();
    return true;
  }
}
