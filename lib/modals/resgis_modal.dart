class RegisModal {
  bool succeeded;
  String? otp;

  RegisModal({required this.succeeded, required this.otp});

  factory RegisModal.fromJson(Map<String, dynamic> json) => RegisModal(
        succeeded: json['succeeded'],
        otp: json['otp'],
      );
}
