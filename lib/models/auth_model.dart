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

  RequestAuthModal({required this.accessToken});

  String toJson() {
    return jsonEncode({
      "accessToken": accessToken,
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
