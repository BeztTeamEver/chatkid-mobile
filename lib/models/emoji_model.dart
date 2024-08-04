import 'dart:convert';

class EmojiModel {
  String name;
  String url;

  EmojiModel({
    required this.name,
    required this.url,
  });

  factory EmojiModel.fromJson(Map<String, dynamic> json) {
    return EmojiModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  String toJson() => jsonEncode(toMap());
}
