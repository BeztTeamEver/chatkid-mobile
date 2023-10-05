import 'dart:convert';

import 'package:chatkid_mobile/config.dart';
import 'package:chatkid_mobile/modals/auth.modal.dart';
import 'package:chatkid_mobile/services/base_http.dart';

class AuthService {
  static const _googleEndPoint = "/api/auth/google-auth";
  static const _regisEndPoint = "/api/auth/register";

  static Future<AuthModal> googleLogin(String token) async {
    final response = await BaseHttp.instance.post(
      endpoint: _googleEndPoint,
      body: jsonEncode(
        {
          "accessToken": token,
        },
      ),
    );
    if (response.statusCode == 200) {
      return AuthModal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<AuthModal> signUp(String token) async {
    final response = await BaseHttp.instance.post(
      endpoint: _regisEndPoint,
      body: jsonEncode(
        {
          "accessToken": token,
        },
      ),
    );
    if (response.statusCode == 200) {
      return AuthModal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}
