import 'dart:convert';

class AuthModel {
  String accessToken;
  String refreshToken;
  AuthModel({required this.accessToken, required this.refreshToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        refreshToken: json['refreshToken'],
        accessToken: json['accessToken'],
      );
}

class RequestAuthModal {
  String accessToken;
  String? deviceToken;

  RequestAuthModal({required this.accessToken, this.deviceToken});

  String toJson() {
    return jsonEncode({
      "accessToken": accessToken,
      "deviceToken": deviceToken,
    });
  }
}

class RequestOtpModel {
  String otp;

  RequestOtpModel({required this.otp});

  String toJson() {
    return jsonEncode({
      "OTP": otp,
    });
  }
}
