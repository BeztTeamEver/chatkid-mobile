import 'dart:convert';

class ChannelModel {
  final String name;
  final List<String> members;

  ChannelModel({required this.name, required this.members});

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      name: json['name'],
      members: json['members'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['members'] = members;
    return data;
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

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channelId'] = channelId;
    data['userId'] = userId;
    return jsonEncode(data);
  }
}
