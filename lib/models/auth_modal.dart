import 'dart:convert';

class AuthModal {
  String token;
  String refreshToken;
  AuthModal({required this.token, required this.refreshToken});

  factory AuthModal.fromJson(Map<String, dynamic> json) => AuthModal(
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
