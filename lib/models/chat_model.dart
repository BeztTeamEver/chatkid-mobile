import 'dart:convert';

class ChatModel {
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

  ChatModel({this.content, this.channelId, this.userId});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      content: json['content'],
      channelId: json['channelUserId'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['userId'] = channelId;
    data['channelId'] = channelId;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
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
