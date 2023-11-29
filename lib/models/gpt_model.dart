import 'dart:convert';

class GptRequestModal {
  String message;
  String kidServiceId;

  GptRequestModal({required this.message, required this.kidServiceId});

  factory GptRequestModal.fromJson(Map<String, dynamic> json) {
    return GptRequestModal(
      message: json['message'],
      kidServiceId: json['kidServiceId'],
    );
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['kidServiceId'] = kidServiceId;
    return data;
  }

  String toJson() => jsonEncode(toMap());
}
