import 'dart:convert';

import 'package:chatkid_mobile/config.dart';
import 'package:chatkid_mobile/constants/endpoint.dart';
import 'package:chatkid_mobile/models/channel_model.dart';
import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late Socket socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal() {
    socket = io(
        Env.socketUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders({
              "authorization": "1f2aad5f-4f7c-4153-9a7b-15d2fef30527",
            })
            .setReconnectionDelay(1000)
            .enableForceNew()
            .build());
    initSocket();
  }

  void dispose() {
    socket.dispose();
  }

  void initSocket() {
    socket.onConnect((_) {
      Logger().i('Connected');
    });
    socket.onDisconnect((_) => Logger().i('Disconnected'));
    socket.onConnectError((err) => ErrorHandler(err));
    socket.onError((err) => ErrorHandler(err));
    socket.onReconnect((data) => Logger().i('Reconnected'));
    socket.connect();
  }

  void ErrorHandler(error) {
    Logger().e(error);
    throw Exception(error);
  }

  // Chat service
  void sendMessage(ChatModel message) {
    Logger().i('send message');
    socket.emit(Endpoint.sendMessageEndPoint, message.toMap());
  }

  void joinChannel(ChannelUserModel channelUser) {
    Logger().i('join channel');
    socket.emit(Endpoint.joinChannelEndPoint, channelUser.toMap());
  }

  void leaveChannel(ChannelUserModel channelUser) {
    Logger().i('leave channel');
    socket.emit(Endpoint.leaveChannelEndPoint, channelUser.toMap());
  }

  void onMessage(Function(ChatModel) callback) {
    socket.on(Endpoint.onMessageEndPoint, (data) {
      callback(ChatModel.fromJson(data));
    });
  }

  void onGroupCreated(Function(ChannelModel) callback) {
    socket.on(Endpoint.onGroupCreateEndPoint, (data) {
      callback(data);
    });
  }

  void onGroupJoined(Function(ChannelUserModel) callback) {
    socket.on(Endpoint.onGroupJoinEndPoint, (data) {
      callback(data);
    });
  }

  void onGroudLeave(Function(ChannelUserModel) callback) {
    socket.on(Endpoint.onGroupLeaveEndPoint, (data) {
      callback(data);
    });
  }
}
