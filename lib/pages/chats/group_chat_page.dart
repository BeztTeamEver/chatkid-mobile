import 'dart:convert';

import 'package:chatkid_mobile/constants/service.dart';
import 'package:chatkid_mobile/models/channel_model.dart';
import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/providers/chat_provider.dart';
import 'package:chatkid_mobile/services/chat_service.dart';
import 'package:chatkid_mobile/services/socket_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/utils.dart';
import 'package:chatkid_mobile/widgets/bottom_menu.dart';
import 'package:chatkid_mobile/widgets/chat_box.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/loading_indicator.dart';
import 'package:chatkid_mobile/widgets/speech_to_text.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:chatkid_mobile/widgets/voice_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';
import 'package:rive/rive.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class GroupChatPage extends ConsumerStatefulWidget {
  final String channelId;
  const GroupChatPage({super.key, required this.channelId});

  @override
  ConsumerState<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends ConsumerState<GroupChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetController _scrollOffsetController =
      ScrollOffsetController();
  final ScrollOffsetListener _scrollOffsetListener =
      ScrollOffsetListener.create();
  final _chatService = SocketService();
  final _listMessages = [];
  final user = LocalStorage.instance.getUser();

  int _pageNumber = 0;

  bool _loading = true;
  bool _isLoadMore = true;

  Future<void> _sendMessage(String message) async {
    Logger().i(user.toJson());
    _chatService.sendMessage(ChatModel(
      content: message,
      userId: user.id!,
      channelId: widget.channelId,
    ));
    setState(() {
      _listMessages.insert(
          0,
          ChatModel(
              content: message, userId: user.id!, channelId: widget.channelId));
    });
    // Scroll to the new widget when the message is sent.

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

  void fetchMessage() async {
    try {
      if (!_isLoadMore) {
        Logger().i("No more data");
        return;
      }

      setState(() {
        _loading = true;
      });

      final request = MessageChannelRequest(
        pageNumber: _pageNumber,
        pageSize: 10,
        channelId: widget.channelId,
      );

      await ref.read(getChannelMessagesProvider(request).future).then(
        (value) {
          if (value.isEmpty) {
            _isLoadMore = false;
            return;
          }
          setState(() {
            _pageNumber++;
            _listMessages.addAll(value);
          });
        },
      ).whenComplete(
        () => setState(
          () {
            _loading = false;
          },
        ),
      );
      // ref.watch(getChannelMessagesProvider(request)).when(data: (listData) {
      //   _loading = false;
      //   if (listData.isEmpty) {
      //     _isLoadMore = false;
      //     return;
      //   }
      //   setState(() {
      //     _listMessages.addAll(listData);
      //   });
      // }, error: (e, s) {
      //   _isLoadMore = false;
      //   _loading = false;
      //   throw e;
      // }, loading: () {
      //   _loading = true;
      // });
    } catch (e) {
      Logger().e(e);
    }
  }

  void _onConnect() async {
    _chatService.joinChannel(
      ChannelUserModel(channelId: widget.channelId, userId: user.id ?? ""),
    );
    fetchMessage();

    _itemPositionsListener.itemPositions.addListener(() async {
      final positions = _itemPositionsListener.itemPositions.value;
      if (!_isLoadMore) {
        Logger().i("No more data");
        return;
      }
      if (positions.isEmpty) {
        return;
      }

      if (positions.last.index == _listMessages.length - 1 &&
          _listMessages.length >= 10) {
        fetchMessage();
      }
    });
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
    _onConnect();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _chatService.leaveChannel(
      ChannelUserModel(channelId: widget.channelId, userId: user.id ?? ""),
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
          user: value[index].user,
          message: value[index].content,
          isSender: value[index].userId == user.id!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      receiveMessage,
      (previous, next) {
        next.whenData(
          (value) => {
            setState(() {
              _listMessages.insert(0, value);
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
              const EdgeInsets.only(left: 10, right: 10, bottom: 80, top: 0),
          child: Column(
            children: [
              _loading ? const Loading() : Container(),
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemBuilder: (context, index) =>
                      _listMessageBuilder(context, index, _listMessages),
                  itemCount: _listMessages.length,
                  padding: const EdgeInsets.only(bottom: 40),
                  scrollOffsetController: _scrollOffsetController,
                  scrollOffsetListener: _scrollOffsetListener,
                  itemScrollController: _scrollController,
                  itemPositionsListener: _itemPositionsListener,
                  reverse: true,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: ShapeDecoration(shape: CircleBorder(), color: Colors.white),
        child: VoiceChat(color: primary, onResult: _sendMessage),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomSheet: BottomAppBar(
        height: 80,
        notchMargin: 15,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                ErrorSnackbar.showError(
                    err: Exception("Chức năng này đang được phát triển"),
                    context: context);
              },
              icon: const SvgIcon(icon: 'location'),
            ),
            IconButton(
              onPressed: () {
                ErrorSnackbar.showError(
                    err: Exception("Chức năng này đang được phát triển"),
                    context: context);
              },
              icon: const SvgIcon(icon: 'camera'),
            ),
            const SizedBox(
              width: 80,
            ),
            IconButton(
              onPressed: () {
                ErrorSnackbar.showError(
                    err: Exception("Chức năng này đang được phát triển"),
                    context: context);
              },
              icon: const SvgIcon(icon: 'sticker'),
            ),
            IconButton(
              onPressed: () {
                ErrorSnackbar.showError(
                    err: Exception("Chức năng này đang được phát triển"),
                    context: context);
              },
              icon: const SvgIcon(icon: 'photo'),
            )
          ],
        ),
      ),
    );
  }
}
