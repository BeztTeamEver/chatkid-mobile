import 'dart:convert';

class FileModel {
  String name;
  String url;

  FileModel({
    required this.name,
    required this.url,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
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

  String toJson() => json.encode(toMap());
}
