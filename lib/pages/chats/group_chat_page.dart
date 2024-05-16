import 'package:chatkid_mobile/models/channel_model.dart';
import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/providers/chat_provider.dart';
import 'package:chatkid_mobile/services/socket_service.dart';
import 'package:chatkid_mobile/utils/error_snackbar.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/chat_box.dart';
import 'package:chatkid_mobile/widgets/input_field.dart';
import 'package:chatkid_mobile/widgets/loading_indicator.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
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
  final _listMessages = <ChatModel>[];
  final user = LocalStorage.instance.getUser();

  int _pageNumber = 0;

  bool _loading = true;
  bool _isLoadMore = true;

  Future<void> _sendMessage(String? message) async {
    if (message == null || message.isEmpty) {
      return;
    }

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
          content: message,
          sender: UserModel(
            id: user.id,
            name: user.name,
            avatarUrl: user.avatarUrl,
          ),
          // TODO: Import media here
          imageUrl: "",
          voiceUrl: "",
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
          message: value[index].content,
          isSender: sender.id == user.id!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _receiveMessage();

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
      bottomSheet: BottomAppBar(
        height: 80,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionButton(
              icon: const SvgIcon(icon: 'photo'),
              onPressed: () {},
            ),
            ActionButton(
              icon: const SvgIcon(icon: 'sticker'),
              onPressed: () {
                ErrorSnackbar.showError(
                    err: Exception("Chức năng này đang được phát triển"),
                    context: context);
              },
            ),
            ActionButton(
              icon: const SvgIcon(icon: 'microphone_on'),
              onPressed: () {},
            ),
            ActionButton(
              icon: const SvgIcon(icon: 'location'),
              onPressed: () {
                ErrorSnackbar.showError(
                    err: Exception("Chức năng này đang được phát triển"),
                    context: context);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                child: InputField(
                  name: 'message',
                  controller: _messageController,
                  autoFocus: false,
                  height: 32,
                  fontSize: 12,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 0,
                  ),
                  onSubmit: _sendMessage,
                  hint: "Aa",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget icon;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: this.onPressed,
        icon: this.icon,
      ),
    );
  }
}
