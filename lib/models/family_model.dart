import 'dart:convert';

import 'package:chatkid_mobile/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class FamilyRequestModel {
  final String? name;
  final String? id;
  final String? email;
  final String? avatarUrl;

  const FamilyRequestModel({this.name, this.id, this.email, this.avatarUrl});

  factory FamilyRequestModel.fromJson(Map<String, dynamic> json) {
    return FamilyRequestModel(
      name: json['name'],
      // id: json['id'],
      // email: json['email'],
      avatarUrl: json['avatarUrl'],
    );
  }

  String toJson() {
    return jsonEncode({
      "name": name,
      // "id": id,
      // "avatarUrl": avatarUrl,
      "email": email,
    });
  }
}

class FamilyModel {
  final String id;
  final String name;
  final String email;
  final int? status;
  final List<UserModel> members;

  const FamilyModel({
    required this.id,
    required this.name,
    required this.email,
    this.status,
    required this.members,
  });

  factory FamilyModel.fromJson(Map<String, dynamic> json) {
    final members = json['members'] != null
        ? (json['members'] as List).map((e) => UserModel.fromJson(e)).toList()
        : <UserModel>[];
    return FamilyModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      members: members,
    );
  }
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "status": status,
        "members": members,
      };

  String toJson() {
    return jsonEncode(toMap());
  }
}
