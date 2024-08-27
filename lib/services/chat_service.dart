import 'dart:convert';

import 'package:chatkid_mobile/config.dart';
import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:chatkid_mobile/services/socket_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ChatService {
  Future<PagingResponseModel<ChatModel>> getMessages(
      PagingModel pagingModel) async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.messagesEndPoint,
      param: pagingModel.toMap(),
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      final listChat = data['items']
          .map((item) => ChatModel.fromJson(item))
          .toList() as List<ChatModel>;
      final pagingResponseModel = PagingResponseModel<ChatModel>(
        // limit: data['limit'],
        pageSize: data['pageSize'],
        items: listChat,
        pageNumber: data['pageNumber'],
        totalItem: data['totalItem'],
      );
      return pagingResponseModel;
    }
    switch (response.statusCode) {
      case 401:
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      default:
        throw Exception('Lỗi lấy tin nhắn, vui lòng thử lại sau!');
    }
  }

  Future<PagingResponseModel<ChatModel>> getPagingChannelMessages(
      {required MessageChannelRequest request}) async {
    final response = await BaseHttp.instance.get(
      endpoint: "${Endpoint.channelMessagesEndPoint}/${request.channelId}",
      param: request.toMap(),
    );

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      try {
        final data = jsonDecode(response.body);
        final listChat = data['items'].map<ChatModel>((item) {
          return ChatModel.fromJson(item);
        }).toList();

        return PagingResponseModel(
          items: listChat,
          totalItem: data['totalItem'],
          pageSize: data['pageSize'],
          pageNumber: data['pageNumber'],
        );
      } catch (e) {
        Logger().e(e);
        throw Exception('Lỗi lấy tin nhắn, vui lòng thử lại sau!');
      }
    }
    switch (response.statusCode) {
      case 401:
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      default:
        throw Exception('Lỗi lấy tin nhắn, vui lòng thử lại sau!');
    }
  }

  Future<List<ChatModel>> getChannelMessages(
      {required MessageChannelRequest request}) async {
    final response = await BaseHttp.instance.get(
      endpoint: "${Endpoint.channelMessagesEndPoint}/${request.channelId}",
      param: request.toMap(),
    );

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      try {
        final data = jsonDecode(response.body);
        final listChat = data['items'].map<ChatModel>((item) {
          return ChatModel.fromJson(item);
        }).toList();

        return listChat;
      } catch (e) {
        Logger().e(e);
        throw Exception('Lỗi lấy tin nhắn, vui lòng thử lại sau!');
      }
    }
    switch (response.statusCode) {
      case 401:
        throw Exception('Lỗi không thể xác thực người dùng, vui lòng thử lại!');
      case 403:
        throw Exception(
            'Bạn không có quyền truy cập vào ứng dụng, vui lòng liên hệ với quản trị viên!');
      default:
        throw Exception('Lỗi lấy tin nhắn, vui lòng thử lại sau!');
    }
  }
}

class ChatServiceNotifier extends StateNotifier<List<ChatModel>> {
  ChatServiceNotifier() : super(<ChatModel>[]);

  Future<List<ChatModel>> getMessages({
    required PagingModel paging,
  }) async {
    final messages = await ChatService().getMessages(paging);
    state = messages.items;
    return messages.items;
  }

  void addMessage(ChatModel message) {
    state.add(message);
  }

  Future<List<ChatModel>> getChannelMessages({required request}) async {
    final messages = await ChatService().getChannelMessages(request: request);
    state = messages;
    return messages;
  }
}

// class ChatServiceSocket {
//   final hubConnection = HubConnectionBuilder()
//       .withUrl("https://api.kidtalkie.tech/chat-hub",
//           options: HttpConnectionOptions(logger: Logger("Chat")))
//       .build();
//   static final ChatServiceSocket _instance = ChatServiceSocket._internal();

//   factory ChatServiceSocket._internal() {
//     return ChatServiceSocket();
//   }

//   static get instance => _instance;

//   ChatServiceSocket() {
//     Logger.root.level = Level.ALL;
//     print("Connecting to https://api.kidtalkie.tech/chat-hub/");
//     hubConnection.onclose((error) => print("Connection Closed"));
// // When the connection is closed, print out a message to the console.
//   }

//   Future<void> startConnection() async {
//     await hubConnection.start();
//   }

//   Future<void> stopConnection() async {
//     await hubConnection.stop();
//   }

//   Future<void> sendMessage(String userId, String message) async {
//     await hubConnection.invoke("SendMessage", args: <Object>[
//       userId,
//       message,
//     ]);
//   }

//   Future<dynamic> joinGroup(String groupName) async {
//     final result =
//         await hubConnection.invoke("JoinGroup", args: <Object>[groupName]);
//     return result;
//   }

//   void ReceiveMessage(fallback) {
//     hubConnection.on("ReceiveMessage", (arguments) {
//       fallback(arguments);
//     });
//   }
// }


