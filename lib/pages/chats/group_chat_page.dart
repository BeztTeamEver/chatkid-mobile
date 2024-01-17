import 'dart:convert';

import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/providers/chat_provider.dart';
import 'package:chatkid_mobile/services/chat_service.dart';
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
import 'package:logger/logger.dart';

class GroupChatPage extends ConsumerStatefulWidget {
  const GroupChatPage({super.key});

  @override
  ConsumerState<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends ConsumerState<GroupChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatServiceSocket _chatService = ChatServiceSocket.instance;
  ScrollController _scrollController = ScrollController();
  List<ChatModel> listMessages = [];
  final user = LocalStorage.instance.getUser();

  Future<void> _sendMessage(String message) async {
    if (message.isNotEmpty) {
      Logger().i(message);
      try {
        final user = LocalStorage.instance.getUser();
        final data = await _chatService.sendMessage(
          user.id ?? "",
          message,
        );
      } catch (e) {
        Logger().e(e);
      }
    }
  }

  void _receiveMessage(List<dynamic> data) {
    Logger().i(data);
    if (data.length > 1) {
      final message = ChatModel(content: data[1], id: data[0]);
      setState(() {
        listMessages.add(message);
      });
    }
  }

  void _connect() async {
    await _chatService.startConnection();
    final messages = await ChatService().getMessages().then((value) {
      setState(() {
        listMessages = value;
      });
    });

    _chatService.ReceiveMessage(_receiveMessage);
  }

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _chatService.stopConnection();
    // _messageController.dispose();
    // _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listMessages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == listMessages.length) {
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
                          message: listMessages[index].content,
                          isSender: listMessages[index].id == user.id,
                        ),
                      ),
                    );
                  },
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
        notchMargin: 10,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
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
