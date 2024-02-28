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
      id: json['id'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
    );
  }

  String toJson() {
    return jsonEncode({
      "name": name,
      "id": id,
      "avatarUrl": avatarUrl,
      "email": email,
    });
  }
}

class FamilyModel {
  final String familyId;
  final String familyName;
  final String familyEmail;
  // final int status;
  final List<UserModel> members;

  const FamilyModel(
      {required this.familyId,
      required this.familyName,
      required this.familyEmail,
      // required this.status,
      required this.members});

  factory FamilyModel.fromJson(Map<String, dynamic> json) {
    json['members'] = json['members'] != null
        ? (json['members'] as List).map((e) => UserModel.fromJson(e)).toList()
        : [];
    return FamilyModel(
      familyId: json['familyId'],
      familyName: json['familyName'],
      familyEmail: json['familyEmail'],
      // status: json['status'],
      members: json['members'] as List<UserModel>,
    );
  }
  Map<String, dynamic> toMap() => {
        "familyId": familyId,
        "familyName": familyName,
        "familyEmail": familyEmail,
        // "status": status,
        "members": members,
      };

  String toJson() {
    return jsonEncode(toMap());
  }
}
