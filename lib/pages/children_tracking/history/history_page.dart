import 'package:chatkid_mobile/models/history_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/children_tracking/history/bot_card.dart';
import 'package:chatkid_mobile/pages/controller/bot_chat_page/bot_history_store.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HistoryPage extends ConsumerStatefulWidget {
  final UserModel user;
  const HistoryPage({super.key, required this.user});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final BotHistoryStore botHistoryStore = Get.put(BotHistoryStore());

  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetController _scrollOffsetController =
      ScrollOffsetController();
  final ScrollOffsetListener _scrollOffsetListener =
      ScrollOffsetListener.create();

  void getHistories() async {}

  void _init() async {
    botHistoryStore.getHistory(widget.user.id!);

    _itemPositionsListener.itemPositions.addListener(() {
      final positions = _itemPositionsListener.itemPositions.value;
      final last = positions.last.index;
      if (last == botHistoryStore.history.length - 1) {
        if (!botHistoryStore.isLoadMore.value ||
            botHistoryStore.isLoading.value) return;

        botHistoryStore.loadMore();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<BotHistoryStore>();
    super.dispose();
  }

  Builder _listHistoryBuilder(
      BuildContext context, int index, List<HistoryBotChatModel> histories) {
    final history = histories[index];
    return Builder(
      builder: (context) {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: HistoryCard(
              user: widget.user,
              history: history,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(primary.shade100),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: primary.shade400,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'Lịch sử hỏi đáp chatbot',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              botHistoryStore.history.isNotEmpty
                  ? Expanded(
                      child: ScrollablePositionedList.builder(
                        itemBuilder: (context, index) => _listHistoryBuilder(
                            context, index, botHistoryStore.history),
                        itemCount: botHistoryStore.history.length,
                        padding: const EdgeInsets.only(bottom: 40),
                        scrollOffsetController: _scrollOffsetController,
                        scrollOffsetListener: _scrollOffsetListener,
                        itemScrollController: _scrollController,
                        itemPositionsListener: _itemPositionsListener,
                      ),
                    )
                  : Container(),
              botHistoryStore.isLoading.value
                  ? const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
