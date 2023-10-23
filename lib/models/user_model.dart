import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  String? id;
  String? avatarUrl;
  String? password;
  String? name;
  String? gender;
  String? role;
  int? status;
  String? familyId;
  String? deviceToken;

  UserModel(
      {this.id,
      this.avatarUrl,
      this.password,
      this.name,
      this.role,
      this.status,
      this.familyId,
      this.gender,
      this.deviceToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      password: json['password'],
      name: json['name'],
      role: json['role'],
      status: json['status'],
      familyId: json['familyId'],
      gender: json['gender'],
      deviceToken: json['deviceToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (avatarUrl != null) {
      data['avatarUrl'] = avatarUrl;
    }
    if (password != null) {
      data['password'] = password;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (role != null) {
      data['role'] = role;
    }
    if (status != null) {
      data['status'] = status;
    }
    if (familyId != null) {
      data['familyId'] = familyId;
    }
    if (gender != null) {
      data['gender'] = gender;
    }
    if (deviceToken != null) {
      data['deviceToken'] = deviceToken;
    }
    return data;
  }
}
