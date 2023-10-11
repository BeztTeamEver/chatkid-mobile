import 'dart:convert';

class FamilyRequestModel {
  final String name;

  FamilyRequestModel({required this.name});

  String toJson() {
    return jsonEncode({
      "name": name,
    });
  }
}

class FamilyModel {
  final String id;
  final String name;
  final String ownerMail;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FamilyModel(
      {required this.id,
      required this.name,
      required this.ownerMail,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

  factory FamilyModel.fromJson(Map<String, dynamic> json) {
    return FamilyModel(
      id: json['id'],
      name: json['name'],
      ownerMail: json['ownerMail'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  String toJson() {
    return jsonEncode({
      "id": id,
      "name": name,
      "ownerMail": ownerMail,
      "status": status,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    });
  }
}
