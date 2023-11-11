import 'package:chatkid_mobile/config.dart';
import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/services/chat_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

final chatProvider = StreamProvider.autoDispose<String>((ref) async* {
  final socket = IOWebSocketChannel.connect(Env.socketUrl);
  ref.onDispose(() => socket.sink.close());

  socket.sink.add("add_something");

  await for (final message in socket.stream) {
    yield message as String;
  }
});

final ChatListProvider =
    StateNotifierProvider<ChatServiceNotifier, List<ChatModel>>((ref) {
  return ChatServiceNotifier();
});
