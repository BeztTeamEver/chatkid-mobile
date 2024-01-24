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

final getMessagesProvider =
    FutureProvider.autoDispose<List<ChatModel>>((ref) async {
  final response =
      await ChatService().getMessages(PagingModel(pageSize: 10, pageNumber: 1));
  return response.data;
});

final getChannelMessagesProvider =
    FutureProvider.autoDispose<List<ChatModel>>((ref) async {
  final response = await ChatService().getChannelMessages(
    pagingRequest: PagingModel(pageSize: 10, pageNumber: 1),
    channelId: "60f9b1b0d9b3a1b4e0f0e0b4",
  );
  return response.data;
});

final receiveMessage = StreamProvider.autoDispose((ref) async* {
  StreamController stream = StreamController();
  Logger().d("receiveMessage");

  final socket = SocketService();

  socket.onMessage((data) {
    stream.add(data);
    Logger().d(jsonEncode(data));
  });

  ref.onDispose(() {
    stream.close();
  });

  await for (final value in stream.stream) {
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
