import 'dart:convert';

class GptRequestModal {
  String message;

  GptRequestModal({required this.message});

  factory GptRequestModal.fromJson(Map<String, dynamic> json) {
    return GptRequestModal(
      message: json['message'],
    );
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }

  String toJson() => jsonEncode(toMap());
}
