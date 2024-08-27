import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/services/chat_service.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatStore extends GetxController {
  RxList<ChatModel> listMessages = <ChatModel>[].obs;
  Rx<String> channelId = ''.obs;

  late ItemScrollController scrollController;

  Rx<PagingModel> paging = PagingModel(pageSize: 10, pageNumber: 0).obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLoadMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    paging.listen((p0) {
      fetchMessages();
    });
    channelId.listen((p0) {
      fetchMessages();
    });
  }

  @override
  void onClose() {
    listMessages.clear();
    listMessages.close();
    paging.close();
    channelId.close();
    isLoading.close();
    isLoadMore.close();
    super.onClose();
  }

  void loadMore() {
    paging.update((val) {
      val!.pageNumber = val.pageNumber + 1;
    });
  }

  void setChannelId(String id) {
    channelId.value = id;
  }

  Future<void> fetchMessages() async {
    if (isLoading.value || !isLoadMore.value) return;
    isLoading.value = true;
    final messages = await ChatService().getPagingChannelMessages(
      request: MessageChannelRequest(
        pageNumber: paging.value.pageNumber,
        pageSize: paging.value.pageSize,
        channelId: channelId.value,
      ),
    );
    addMessages(messages.items);
    isLoadMore.value = messages.items.length == paging.value.pageSize;
    isLoading.value = false;
    // if (paging.value.pageNumber <= 1) {
    //   final length = listMessages.length - 1 >= 0 ? listMessages.length - 1 : 0;
    //   scrollController.jumpTo(
    //     index: length,
    //   );
    // } else {
    //   final length =
    //       messages.items.length - 1 >= 0 ? messages.items.length - 1 : 0;
    //   scrollController.jumpTo(
    //     index: length,
    //   );
    // }
  }

  void addMessage(ChatModel message) {
    listMessages.add(message);
    // listNewMessages.add(message);
  }

  void addMessages(List<ChatModel> messages) {
    final list = listMessages.reversed.toList();
    list.addAll(messages);
    listMessages.assignAll(list.reversed.toList());
  }
}
