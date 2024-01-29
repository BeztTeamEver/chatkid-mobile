import 'dart:convert';
import 'dart:io';

import 'package:chatkid_mobile/models/channel_model.dart';
import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/providers/chat_provider.dart';
import 'package:chatkid_mobile/services/chat_service.dart';
import 'package:chatkid_mobile/services/socket_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:chatkid_mobile/widgets/chat_box.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/speech_to_text.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:chatkid_mobile/widgets/voice_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GroupChatPage extends ConsumerStatefulWidget {
  final String channelId;
  const GroupChatPage({super.key, required this.channelId});

  @override
  ConsumerState<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends ConsumerState<GroupChatPage> {
  final TextEditingController _messageController = TextEditingController();
  // ScrollController _scrollController = ScrollController();
  final _chatService = SocketService();
  final _listMessages = [];
  final user = LocalStorage.instance.getUser();

  Future<void> _sendMessage(String message) async {
    _chatService.sendMessage(ChatModel(
        content: message,
        userId: "91b40aa8-0639-4539-95d3-1ddb5bda21c0",
        channelId: widget.channelId));
    setState(() {
      _listMessages.add(ChatModel(
          content: message,
          userId: "91b40aa8-0639-4539-95d3-1ddb5bda21c0",
          channelId: widget.channelId));
    });

    // _chatService.sendMessage(message);
    // if (message.isNotEmpty) {
    //   Logger().i(message);
    //   try {
    //     final user = LocalStorage.instance.getUser();
    //     final data = await _chatService.sendMessage(
    //       user.id ?? "",
    //       message,
    //     );
    //   } catch (e) {
    //     Logger().e(e);
    //   }
    // }
  }

  void _receiveMessage(ChatModel data) {
    Logger().i(data.content);
    setState(() {
      _listMessages.add(data);
    });
    // if (data.length > 1) {
    //   final message = ChatModel(content: data[1], id: data[0]);
    //   setState(() {
    //     listMessages.add(message);
    //   });
    // }
  }

  void _connect() async {
    _chatService.joinChannel(
      ChannelUserModel(
          channelId: widget.channelId,
          userId: "91b40aa8-0639-4539-95d3-1ddb5bda21c0"),
    );
    // _chatService.joinChannel(
    //     ChatModel(channelId: "d5b2a3d0-17c5-480e-87e1-b23c12438978"));
    // await _chatService.startConnection();
    // final messages = await ChatService().getMessages().then((value) {
    //   setState(() {
    //     listMessages = value.data;
    //   });
    // });

    // _chatService.ReceiveMessage(_receiveMessage);
  }

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _chatService.leaveChannel(
      ChannelUserModel(
          channelId: widget.channelId,
          userId: "91b40aa8-0639-4539-95d3-1ddb5bda21c0"),
    );
    super.dispose();
    // _chatService.stopConnection();
    // _messageController.dispose();
    // _scrollController.dispose();
  }

  _listMessageBuilder(context, index, value) {
    if (index == value.length) {
      return const SizedBox(
        height: 80,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: ChatTextBox(
          icon: 'animal/bear',
          message: value[index].content,
          isSender:
              value[index].userId == "91b40aa8-0639-4539-95d3-1ddb5bda21c0",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ref
    //     .watch(getChannelMessagesProvider(MessageChannelRequest(
    //         pageNumber: 1, pageSize: 1, channelId: widget.channelId)))
    //     .whenData((value) {
    //   setState(() {
    //     listMessages = value;
    //   });
    //   Logger().d(value[0].content);
    // });
    final message = ref.listen(
      receiveMessage,
      (previous, next) {
        next.whenData(
          (value) => {
            setState(() {
              _listMessages.add(value);
            })
          },
        );
      },
      onError: (error, stackTrace) {
        Logger().e(error);
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.info_outline_rounded), onPressed: () {})
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Gia Đình",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 40, top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // switch (message) {
              //   AsyncData(:final value) =>
              //     ListView.builder(itemBuilder: (context, index) {
              //       return _listMessageBuilder(context, index, value);
              //     }),
              //   AsyncError(:final error, :final stackTrace) =>
              //     Text(error.toString()),
              //   _ => Center(
              //       child: Container(
              //         height: 40,
              //         width: 40,
              //         child: CircularProgressIndicator(),
              //       ),
              //     ),
              // },
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _listMessages.length + 1,
                  itemBuilder: (context, index) =>
                      _listMessageBuilder(context, index, _listMessages),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: VoiceChat(color: primary, onResult: _sendMessage),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomSheet: BottomAppBar(
        height: 80,
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _sendMessage("hello");
              },
              icon: const SvgIcon(icon: 'location'),
            ),
            IconButton(
              onPressed: () {},
              icon: const SvgIcon(icon: 'camera'),
            ),
            const SizedBox(
              width: 80,
            ),
            IconButton(
              onPressed: () {},
              icon: const SvgIcon(icon: 'sticker'),
            ),
            IconButton(
              onPressed: () {},
              icon: const SvgIcon(icon: 'photo'),
            )
          ],
        ),
      ),
    );
  }
}
