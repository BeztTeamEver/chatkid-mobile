class AuthModal {
  String token;
  String refreshtoken;

  AuthModal({required this.token, required this.refreshtoken});

  factory AuthModal.fromJson(Map<String, dynamic> json) => AuthModal(
        refreshtoken: json['refreshtoken'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refreshtoken": refreshtoken,
      };
}
