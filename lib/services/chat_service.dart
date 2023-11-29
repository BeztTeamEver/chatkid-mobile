import 'dart:convert';

import 'package:chatkid_mobile/config.dart';
import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/services/base_http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ChatService {
  Future<List<ChatModel>> getMessages() async {
    final response = await BaseHttp.instance.get(
      endpoint: Endpoint.messagesEndPoint,
    );
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      final data = jsonDecode(response.body);
      final messages =
          data['items'].map<ChatModel>((e) => ChatModel.fromJson(e)).toList();
      return messages ?? [];
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

  Future<List<ChatModel>> getMessages() async {
    final messages = await ChatService().getMessages();
    state = messages;
    return messages;
  }

  void addMessage(ChatModel message) {
    state.add(message);
  }
}

class ChatServiceSocket {
  final hubConnection = HubConnectionBuilder()
      .withUrl("https://api.kidtalkie.tech/chat-hub",
          options: HttpConnectionOptions(logger: Logger("Chat")))
      .build();
  static final ChatServiceSocket _instance = ChatServiceSocket._internal();

  factory ChatServiceSocket._internal() {
    return ChatServiceSocket();
  }

  static get instance => _instance;

  ChatServiceSocket() {
    Logger.root.level = Level.ALL;
    print("Connecting to https://api.kidtalkie.tech/chat-hub/");
    hubConnection.onclose((error) => print("Connection Closed"));
// When the connection is closed, print out a message to the console.
  }

  Future<void> startConnection() async {
    await hubConnection.start();
  }

  Future<void> stopConnection() async {
    await hubConnection.stop();
  }

  Future<void> sendMessage(String userId, String message) async {
    await hubConnection.invoke("SendMessage", args: <Object>[
      userId,
      message,
    ]);
  }

  Future<dynamic> joinGroup(String groupName) async {
    final result =
        await hubConnection.invoke("JoinGroup", args: <Object>[groupName]);
    return result;
  }

  void ReceiveMessage(fallback) {
    hubConnection.on("ReceiveMessage", (arguments) {
      fallback(arguments);
    });
  }
}
