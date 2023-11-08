import 'dart:convert';

import 'package:chatkid_mobile/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class FamilyRequestModel {
  final String? name;
  final String? id;
  final String? email;

  const FamilyRequestModel({this.name, this.id, this.email});

  factory FamilyRequestModel.fromJson(Map<String, dynamic> json) {
    return FamilyRequestModel(
      name: json['name'],
      id: json['id'],
      email: json['email'],
    );
  }

  String toJson() {
    return jsonEncode({
      "name": name,
      "id": id,
      "email": email,
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
  final List<UserModel> users;

  const FamilyModel(
      {required this.id,
      required this.name,
      required this.ownerMail,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.users});

  factory FamilyModel.fromJson(Map<String, dynamic> json) {
    json['users'] = json['users'] != null
        ? (json['users'] as List).map((e) => UserModel.fromJson(e)).toList()
        : [];
    return FamilyModel(
      id: json['id'],
      name: json['name'],
      ownerMail: json['ownerMail'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      users: json['users'] as List<UserModel>,
    );
  }
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "ownerMail": ownerMail,
        "status": status,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "users": users,
      };

  String toJson() {
    return jsonEncode(toMap());
  }
}
