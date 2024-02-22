import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:chatkid_mobile/config.dart';
import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/models/paging_modal.dart';
import 'package:chatkid_mobile/services/chat_service.dart';
import 'package:chatkid_mobile/services/socket_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/io.dart';

// final chatProvider = StreamProvider.autoDispose<String>((ref) async* {
//   final socket = await SocketService();
//   ref.onDispose(() {
//     socket.dispose();
//   });

//   var allMessages =
//       await ChatService().getMessages(PagingModel(pageSize: 10, pageNumber: 1));
// });

// final ChatListProvider =
//     StateNotifierProvider<ChatServiceNotifier, List<ChatModel>>((ref) {
//   return ChatServiceNotifier();
// });

final getMessagesProvider = FutureProvider<List<ChatModel>>((ref) async {
  final response =
      await ChatService().getMessages(PagingModel(pageSize: 10, pageNumber: 1));
  return response.items;
});

final getChannelMessagesProvider =
    FutureProvider.family<List<ChatModel>, MessageChannelRequest>(
        (ref, request) async {
  final response =
      await ChatServiceNotifier().getChannelMessages(request: request);
  return response;
});

final receiveMessage = StreamProvider<ChatModel>((ref) async* {
  StreamController<ChatModel> stream = StreamController();
  final socket = SocketService();

  List<ChatModel> listMessages = const <ChatModel>[];

  socket.onMessage((data) {
    stream.add(data);
  });

  await for (final value in stream.stream) {
    Logger().i("Message from id: ${value.userId} \n Content: ${value.content}");

    yield value;
  }
});

final onGroupJoin = StreamProvider.autoDispose((ref) async* {
  StreamController stream = StreamController();

  final socket = SocketService().socket;

  socket.on(Endpoint.onGroupJoinEndPoint, (data) {
    stream.add(data);
    Logger().d(data.toString());
  });

  ref.onDispose(() {
    stream.close();
  });

  await for (final value in stream.stream) {
    Logger().d(value.toString());
    yield value;
  }
});
