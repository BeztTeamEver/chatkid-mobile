import 'dart:convert';

import 'package:chatkid_mobile/models/auth_model.dart';
import 'package:chatkid_mobile/models/resgis_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:logger/logger.dart';

class AuthService {
  static const _googleEndPoint = "/api/auth/google-auth";
  static const _regisEndPoint = "/api/auth/register";
  static const _verifyOtpEndPoint = "/api/auth/otp-verify";
  static const _resendOtp = "/api/auth/otp";
  static final _localStorage = LocalStorage.instance;

  static Future<AuthModel> googleLogin(String token) async {
    RequestAuthModal requestAuthModal = RequestAuthModal(accessToken: token);
    final response = await BaseHttp.instance.post(
      endpoint: _googleEndPoint,
      body: requestAuthModal.toJson(),
    );

    if (response.statusCode == 200) {
      final authTokens = AuthModel.fromJson(jsonDecode(response.body));
      _saveToken(authTokens);
      return authTokens;
    } else {
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
      endpoint: _regisEndPoint,
      body: requestAuthModal.toJson(),
    );

    if (response.statusCode == 200) {
      final regisToken = RegisModel.fromJson(jsonDecode(response.body));
      _localStorage.preferences
          .setString('accessToken', regisToken.verifyToken);
      return RegisModel.fromJson(jsonDecode(response.body));
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
      endpoint: '$_verifyOtpEndPoint/$otp',
    );

    if (response.statusCode == 200) {
      final authTokens = AuthModel.fromJson(jsonDecode(response.body));
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
      endpoint: _resendOtp,
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
}
