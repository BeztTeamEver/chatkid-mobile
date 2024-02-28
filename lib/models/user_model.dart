import 'dart:convert';

import 'package:chatkid_mobile/models/kid_service_model.dart';
import 'package:chatkid_mobile/models/wallet_model.dart';
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
  String? accessToken;
  String? refreshToken;
  String? notSeenActivities;
  String? doing;
  List<KidServiceModel>? kidServices;
  List<WalletModel>? wallets;

  UserModel(
      {this.id,
      this.avatarUrl,
      this.password,
      this.name,
      this.role,
      this.status,
      this.familyId,
      this.gender,
      this.deviceToken,
      this.kidServices,
      this.accessToken,
      this.refreshToken,
      this.doing,
      this.notSeenActivities,
      this.wallets});

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
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      deviceToken: json['deviceToken'],
      notSeenActivities: json['notSeenActivities'],
      doing: json['doing'],
      kidServices: json['kidServices'] != null
          ? (json['kidServices'] as List)
              .map((e) => KidServiceModel.fromJson(e))
              .toList()
          : null,
      wallets: json['wallets'] != null
          ? (json['wallets'] as List)
              .map((e) => WalletModel.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
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
    if (kidServices != null) {
      data['kidServices'] = kidServices!.map((v) => v.toMap()).toList();
    }
    if (accessToken != null) {
      data['accessToken'] = accessToken;
    }
    if (refreshToken != null) {
      data['refreshToken'] = refreshToken;
    }
    if (wallets != null) {
      data['wallets'] = wallets!.map((v) => v.toMap()).toList();
    }
    return data;
  }

  String toJson() => jsonEncode(toMap());
}
