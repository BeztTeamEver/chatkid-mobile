import 'dart:convert';

class ChannelModel {
  final String name;
  final String id;
  final List<String>? members;
  final int status;
  final String? createdAt;
  final String? updatedAt;
  final String familyId;

  ChannelModel(
      {required this.id,
      required this.name,
      this.members,
      required this.status,
      this.createdAt,
      this.updatedAt,
      required this.familyId});

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'],
      name: json['name'],
      members: json['members'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      familyId: json['familyId'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['members'] = members;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['familyId'] = familyId;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class ChannelUserModel {
  final String channelId;
  final String userId;

  ChannelUserModel({required this.channelId, required this.userId});

  factory ChannelUserModel.fromJson(Map<String, dynamic> json) {
    return ChannelUserModel(
      channelId: json['channelId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channelId'] = channelId;
    data['userId'] = userId;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
