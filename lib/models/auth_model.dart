import 'dart:convert';

class AuthModel {
  String token;
  String refreshToken;
  AuthModel({required this.token, required this.refreshToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        refreshToken: json['refreshToken'],
        token: json['token'],
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
