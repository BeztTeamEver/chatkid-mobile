class RegisModal {
  String verifyToken;

  RegisModal({required this.verifyToken});

  factory RegisModal.fromJson(Map<String, dynamic> json) => RegisModal(
        verifyToken: json['verifyToken'],
      );
}
