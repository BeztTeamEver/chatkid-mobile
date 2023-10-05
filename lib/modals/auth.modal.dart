class AuthModal {
  String token;
  String refreshToken;

  AuthModal({required this.token, required this.refreshToken});

  factory AuthModal.fromJson(Map<String, dynamic> json) => AuthModal(
        refreshToken: json['refreshToken'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refreshtoken": refreshToken,
      };
}
