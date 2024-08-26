import 'package:chatkid_mobile/models/chat_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/services/chat_service.dart';
import 'package:get/get.dart';

class ChatStore extends GetxController {
  RxList<ChatModel> listMessages = <ChatModel>[].obs;
  RxList<ChatModel> listNewMessages = <ChatModel>[].obs;
  Rx<String> channelId = ''.obs;

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
    isLoadMore.value = messages.items.isNotEmpty;
    isLoading.value = false;
  }

  void addMessage(ChatModel message) {
    listMessages.insert(0, message);
    // listNewMessages.add(message);
  }

  void addMessages(List<ChatModel> messages) {
    listMessages.addAll(messages);
  }
}
