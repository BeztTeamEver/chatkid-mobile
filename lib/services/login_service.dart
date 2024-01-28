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

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final authTokens = AuthModel.fromJson(jsonDecode(response.body));
      Logger().d(authTokens.accessToken);
      _saveToken(authTokens);
      return authTokens;
    }
    FirebaseService.instance.signOut();
    Logger().d(response.body);

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

  static Future<RegisModel> signUp(String token) async {
    final RequestAuthModal requestAuthModal =
        RequestAuthModal(accessToken: token);

    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.regisEndPoint,
      body: requestAuthModal.toJson(),
    );

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final regisToken = RegisModel.fromJson(jsonDecode(response.body));
      _localStorage.preferences
          .setString('accessToken', regisToken.accessToken);
      Logger().d(regisToken.accessToken);
      return RegisModel.fromJson(jsonDecode(response.body));
    } else {
      FirebaseService.instance.signOut();
      Logger().d(response.body);
      switch (response.statusCode) {
        case 400:
          throw Exception('Tài khoản này đã được đăng kí');
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
      Logger().d(response.body);

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
    final response = await BaseHttp.instance.post(
      endpoint: Endpoint.verifyOtpEndPoint,
      body: RequestOtpModel(otp: otp).toJson(),
    );
    Logger().d(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final authTokens = AuthModel.fromJson(jsonDecode(response.body));
      Logger().d(authTokens.accessToken);

      _saveToken(authTokens);
      return true;
    } else {
      Logger().d(response.body);

      switch (response.statusCode) {
        case 400:
          throw Exception('Mã OTP không đúng');
        case 401:
          throw Exception('Mã OTP không đúng');
        case 403:
          throw Exception(
              'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
        default:
          throw Exception('Lỗi xác thực OTP, vui lòng thử lại sau!');
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
      authTokens.accessToken,
      authTokens.refreshToken,
    );
  }

  static Future<String> getAccessToken() async {
    String accessToken = _localStorage.getToken()?.accessToken ?? "";

    if (accessToken.isEmpty) {
      accessToken = _localStorage.preferences.getString("accessToken") ?? "";
      return accessToken;
    }
    if (isTokenExpired()) {
      AuthModel tokens = await refreshToken();
      _localStorage.saveToken(tokens.accessToken, tokens.refreshToken);
      return tokens.accessToken;
    }
    return accessToken;
  }

  static bool isTokenExpired() {
    final token = _localStorage.getToken()?.accessToken;
    if (token == null) {
      return true;
    }
    final parts = token.split('.');
    if (parts.length != 3) {
      return true;
    }
    return false;
    final payload = parts[1];
    Logger().d(payload);
    // final decoded = jsonDecode(base64.decode(base64.normalize(payload)));
    // final exp = decoded['exp'] * 1000;
    // return DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(exp));
  }
}
