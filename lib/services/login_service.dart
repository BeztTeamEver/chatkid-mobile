import 'dart:convert';

import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/auth_model.dart';
import 'package:chatkid_mobile/models/resgis_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/services/firebase_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:logger/logger.dart';

class AuthService {
  static final _localStorage = LocalStorage.instance;

  static Future<AuthModel> googleLogin(String token) async {
    RequestAuthModal requestAuthModal = RequestAuthModal(accessToken: token);
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.googleEndPoint,
      body: requestAuthModal.toJson(),
    );

    if (response.statusCode == 200) {
      final authTokens = AuthModel.fromJson(jsonDecode(response.body));
      _saveToken(authTokens);
      return authTokens;
    } else {
      FirebaseService.instance.signOut();
      switch (response.statusCode) {
        case 404:
          throw Exception('Tài khoản này chưa được đăng ký');
        case 403:
          throw Exception(
              'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
        default:
          throw Exception('Lỗi đăng nhập, vui lòng thử lại sau!');
      }
    }
  }

  static Future<RegisModel> signUp(String token) async {
    final RequestAuthModal requestAuthModal =
        RequestAuthModal(accessToken: token);

    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.regisEndPoint,
      body: requestAuthModal.toJson(),
    );

    if (response.statusCode == 200) {
      final regisToken = RegisModel.fromJson(jsonDecode(response.body));
      _localStorage.preferences
          .setString('accessToken', regisToken.verifyToken);
      Logger().d(regisToken.verifyToken);
      return RegisModel.fromJson(jsonDecode(response.body));
    } else {
      FirebaseService.instance.signOut();
      switch (response.statusCode) {
        case 401:
          throw Exception('Tài khoản này đã được đăng kí');
        case 403:
          throw Exception(
              'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
        default:
          throw Exception('Lỗi đăng nhập, vui lòng thử lại sau!');
      }
    }
  }

  static Future<AuthModel> refreshToken() async {
    _localStorage.preferences.remove('accessToken');
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.refreshTokenEndPoint,
    );
    if (response.statusCode == 200) {
      final authTokens = AuthModel.fromJson(jsonDecode(response.body));
      _saveToken(authTokens);
      return authTokens;
    } else {
      switch (response.statusCode) {
        case 401:
          throw Exception('Unauthorized');
        case 403:
          throw Exception(
              'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
        default:
          throw Exception('Lỗi đăng nhập, vui lòng thử lại sau!');
      }
    }
  }

  static Future<bool> signOut() async {
    // TODO: call api sign out here
    await _localStorage.removeToken();
    return true;
  }

  static Future<bool> verifyOtp(String otp) async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.verifyOtpEndPoint,
      param: {'otp': otp},
    );
    if (response.statusCode == 200) {
      final authTokens = AuthModel.fromJson(jsonDecode(response.body));
      Logger().d(authTokens.token);

      _saveToken(authTokens);
      return true;
    } else {
      switch (response.statusCode) {
        case 401:
          throw Exception('Mã OTP không đúng');
        case 403:
          throw Exception(
              'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
        default:
          throw Exception('Lỗi đăng nhập, vui lòng thử lại sau!');
      }
    }
  }

  static Future<bool> resendOtp() async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.resendOtp,
    );
    if (response.statusCode == 200) {
      return true;
    }
    switch (response.statusCode) {
      default:
        throw Exception('Đã xảy ra lỗi, không thể gửi lại OTP');
    }
  }

  static void _saveToken(AuthModel authTokens) async {
    await _localStorage.saveToken(
      authTokens.token,
      authTokens.refreshToken,
    );
  }

  static Future<String> getAccessToken() async {
    String accessToken = _localStorage.getToken()?.token ?? "";

    if (accessToken.isEmpty) {
      accessToken = _localStorage.preferences.getString("accessToken") ?? "";
      return accessToken;
    }
    if (isTokenExpired()) {
      AuthModel tokens = await refreshToken();
      _localStorage.saveToken(tokens.token, tokens.refreshToken);
      return tokens.token;
    }
    return accessToken;
  }

  static bool isTokenExpired() {
    final token = _localStorage.getToken()?.token;
    if (token == null) {
      return true;
    }
    final parts = token.split('.');
    if (parts.length != 3) {
      return true;
    }
    final payload = parts[1];
    final decoded =
        jsonDecode(ascii.decode(base64.decode(base64.normalize(payload))));
    final exp = decoded['exp'] * 1000;
    return DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(exp));
  }
}
