import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/models/channel_model.dart';
import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/chats/widget/action_button.dart';
import 'package:chatkid_mobile/pages/chats/widget/kid_bottom_bar.dart';
import 'package:chatkid_mobile/pages/chats/widget/parent_bottom_bar.dart';
import 'package:chatkid_mobile/providers/chat_provider.dart';
import 'package:chatkid_mobile/services/file_service.dart';
import 'package:chatkid_mobile/services/socket_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/chat_box.dart';
import 'package:chatkid_mobile/widgets/custom_bottom_sheet.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/loading_indicator.dart';
import 'package:chatkid_mobile/widgets/recorder.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:chatkid_mobile/widgets/voice_chat.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:logger/web.dart';
import 'package:pinput/pinput.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class GroupChatPage extends ConsumerStatefulWidget {
  final String channelId;
  const GroupChatPage({super.key, required this.channelId});

  @override
  ConsumerState<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends ConsumerState<GroupChatPage>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetController _scrollOffsetController =
      ScrollOffsetController();
  final ScrollOffsetListener _scrollOffsetListener =
      ScrollOffsetListener.create();
  final GlobalKey<ExpandableBottomSheetState> bottomSheetKey = new GlobalKey();

  final _chatService = SocketService();
  final _listMessages = <ChatModel>[];
  final user = LocalStorage.instance.getUser();

  int _pageNumber = 0;

  bool isMaxExtended = false;
  bool isActionActive = false;
  bool isExpanded = false;
  bool _loading = true;
  bool _isLoadMore = true;

  Future<void> _sendMessage({
    String? message,
    String? imageUrl,
    String? voiceUrl,
  }) async {
    if (message == null && imageUrl == null && voiceUrl == null) {
      return;
    }
    if (message != null && message.isEmpty) {
      return;
    }
    _chatService.sendMessage(ChatModel(
      content: message,
      imageUrl: imageUrl,
      voiceUrl: voiceUrl,
      userId: user.id!,
      channelId: widget.channelId,
    ));
    Logger().i(voiceUrl);
    setState(() {
      _listMessages.insert(
        0,
        ChatModel(
          content: message,
          sender: UserModel(
            id: user.id,
            name: user.name,
            avatarUrl: user.avatarUrl,
          ),
          imageUrl: imageUrl,
          voiceUrl: voiceUrl,
          sentTime: DateTime.now().toIso8601String(),
          channelId: widget.channelId,
        ),
      );
    });
  }

  void _receiveMessage() {
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

  void expand() => bottomSheetKey.currentState?.expand();

  void contract() => bottomSheetKey.currentState?.contract();

  ExpansionStatus? status() => bottomSheetKey.currentState?.expansionStatus;

  void onChangeBottomSheet(bool isExpand) {
    if (isMaxExtended) {
      contract();
      return;
    }
    if (!isMaxExtended && !isExpanded) {
      setState(() {
        isActionActive = false;
      });
    }
    setState(() {
      isExpanded = isExpand;
    });
  }

  _listMessageBuilder(context, index, List<ChatModel> value) {
    if (index == value.length) {
      return const SizedBox(
        height: 80,
      );
    }
    final sender = value[index].sender ??
        UserModel(
          id: "1",
          name: "Người dùng",
          avatarUrl: "https://i.pravatar.cc/150?img=1",
        );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: ChatTextBox(
          icon: 'animal/bear',
          user: sender,
          voiceUrl: value[index].voiceUrl,
          message: value[index].content,
          isSender: sender.id == user.id!,
        ),
      ),
    );
  }

  void onRecorded(File? file) async {
    if (file == null) {
      return;
    }
    final response = await FileService().sendfile(file).then((value) async {
      return value;
    }).catchError((e) {
      ErrorSnackbar.showError(err: e, context: context);
    });

    _sendMessage(voiceUrl: response.url);
  }

  void onSendMessage(String? value) {
    _sendMessage(message: value);
    _messageController.setText("");
  }

  void onOpenSticker() {
    if (!isActionActive) {
      onChangeBottomSheet(true);
      setState(() {
        isActionActive = true;
      });
    } else {
      Logger().i(isExpanded);
      if (isExpanded) {
        onChangeBottomSheet(true);
      }
      setState(() {
        isActionActive = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _receiveMessage();

    return ExpandableBottomSheet(
      key: bottomSheetKey,
      expandableContent: TapRegion(
        onTapOutside: (event) {
          onChangeBottomSheet(false);
        },
        child: Container(
          height: isExpanded == true ? 400 : 0,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      animationCurveExpand: Curves.easeOut,
      animationDurationContract: const Duration(milliseconds: 200),
      animationDurationExtend: const Duration(milliseconds: 310),
      persistentContentHeight: isExpanded == true ? 200 : 0,
      onIsContractedCallback: () {
        setState(() {
          isMaxExtended = false;
        });
      },
      onIsExtendedCallback: () {
        setState(() {
          isMaxExtended = true;
        });
      },
      enableToggle: true,
      background: body(context),
      persistentHeader: isExpanded
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: isMaxExtended ? 8 : 0,
                        blurStyle: BlurStyle.outer,
                        offset: Offset(0, 8),
                        spreadRadius: 4)
                  ]),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Scaffold body(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 40,
            top: 0,
          ),
          child: Column(
            children: [
              _loading ? const Loading() : Container(),
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemBuilder: (context, index) =>
                      _listMessageBuilder(context, index, _listMessages),
                  itemCount: _listMessages.length,
                  padding: EdgeInsets.only(
                      bottom: user.role == RoleConstant.Child ? 60 : 20),
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
      floatingActionButton: user.role == RoleConstant.Child
          ? Container(
              decoration: const ShapeDecoration(
                  shape: CircleBorder(), color: Colors.white),
              child: Hero(
                tag: 'voiceChat/mic',
                placeholderBuilder: (context, heroSize, child) => Container(
                  height: 20.0,
                  width: 20.0,
                  child: const CircularProgressIndicator(),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      HeroDialogRoute(
                        builder: (context) => VoiceRecorder(
                          onRecorded: onRecorded,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 64,
                    height: 64,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: primary.shade500,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const SvgIcon(
                      color: Colors.white,
                      icon: "voice_on",
                      size: 40,
                    ),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: user.role == RoleConstant.Child
          ? FloatingActionButtonLocation.centerDocked
          : null,
      bottomSheet: user.role == RoleConstant.Parent
          ? ParentBottomBar(
              onOpenSticker: onOpenSticker,
              onRecorded: onRecorded,
              isExpanded: isExpanded,
              messageController: _messageController,
              onChangeBottomSheet: onChangeBottomSheet,
              onSendMessage: onSendMessage,
            )
          : KidBottomBar(context: context),
    );
  }
}
