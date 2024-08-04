import 'dart:convert';

import 'package:chatkid_mobile/models/base_model.dart';
import 'package:chatkid_mobile/models/channel_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class ChatModel implements IBaseModel {
  // String? id;
  // String? content;
  // String? sentTime;
  // String? channelUserId;
  // int? status;

  // ChatModel(
  //     {this.id, this.content, this.sentTime, this.channelUserId, this.status});

  // factory ChatModel.fromJson(Map<String, dynamic> json) {
  //   return ChatModel(
  //       id: json['id'],
  //       content: json['content'],
  //       sentTime: json['sentTime'],
  //       channelUserId: json['channelUserId'],
  //       status: json['status']);
  // }

  // Map<String, dynamic> toMap() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['content'] = content;
  //   data['sentTime'] = sentTime;
  //   data['channelUserId'] = channelUserId;
  //   data['status'] = status;
  //   return data;
  // }

  // String toJson() {
  //   return jsonEncode(toMap());
  // }
  String? content;
  String? channelId;
  String? userId;
  String? imageUrl;
  String? voiceUrl;
  String? sentTime;
  UserModel? sender;

  ChatModel(
      {this.content,
      this.channelId,
      this.userId,
      this.sentTime,
      this.sender,
      this.imageUrl,
      this.voiceUrl});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      content: json['content'],
      channelId: json['channelId'],
      userId: json['userId'],
      voiceUrl: json['voiceUrl'],
      imageUrl: json['imageUrl'],
      sentTime: json['sentTime'],
      sender: UserModel.fromJson(json['sender']),
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) data['content'] = content;
    if (channelId != null) data['channelId'] = channelId;
    if (userId != null) data['userId'] = userId;
    if (voiceUrl != null) data['voiceUrl'] = voiceUrl;
    if (imageUrl != null) data['imageUrl'] = imageUrl;
    if (sentTime != null) data['sentTime'] = sentTime;
    if (sender != null) data['sender'] = sender!.toMap();

    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class MessageChannelRequest extends PagingModel {
  String channelId;

  MessageChannelRequest(
      {required super.pageNumber,
      required super.pageSize,
      required this.channelId});

  factory MessageChannelRequest.fromJson(Map<String, dynamic> json) {
    return MessageChannelRequest(
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      channelId: json['channelId'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    super.toMap().forEach((key, value) {
      data[key] = value;
    });
    data['channelId'] = channelId;
    return data;
  }
}

class MessageRequest {
  String? content;
  String? channelId;
  String? userId;

  MessageRequest({this.content, this.channelId, this.userId});

  factory MessageRequest.fromJson(Map<String, dynamic> json) {
    return MessageRequest(
      content: json['content'],
      channelId: json['channelUserId'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['userId'] = channelId;
    data['channelUserId'] = channelId;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

// class ListResponseModel<ChatModel> {
//   int? pageNumber;
//   int? pageSize;
//   int? totalItem;
//   List<ChatModel>? items;

//   ListResponseModel(
//       {this.pageNumber, this.pageSize, this.totalItem, this.items});

//   ListResponseModel.fromJson(Map<String, dynamic> json) {
//     pageNumber = json['pageNumber'];
//     pageSize = json['pageSize'];
//     totalItem = json['totalItem'];
//     if (json['items'] != null) {
//       items = <ChatModel>[];
//       json['items'].forEach((v) {
//         final item = ChatModel.fromJson(v);
//         items!.add(item);
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['pageNumber'] = this.pageNumber;
//     data['pageSize'] = this.pageSize;
//     data['totalItem'] = this.totalItem;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => jsonEncode(v)).toList();
//     }
//     return data;
//   }
// }
