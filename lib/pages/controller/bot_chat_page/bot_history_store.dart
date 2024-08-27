import 'package:chatkid_mobile/models/history_model.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/services/history_service.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BotHistoryStore extends GetxController {
  RxList<HistoryBotChatModel> history = <HistoryBotChatModel>[].obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLoadMore = true.obs;

  Rx<HistoryRequestModel> paging = HistoryRequestModel(
          memberId: "", paging: PagingModel(pageNumber: 0, pageSize: 10))
      .obs;
  @override
  void onInit() {
    super.onInit();
    paging.listen((value) {
      fetchHistory();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    history.close();
    super.dispose();
  }

  void getHistory(String memberId) {
    paging.update((val) {
      val!.memberId = memberId;
    });
  }

  void loadMore() async {
    if (!isLoadMore.value) {
      Logger().i("No more data");
      return;
    }
    paging.update((val) {
      val!.paging.pageNumber = val.paging.pageNumber + 1;
    });
  }

  void updateStatus(String id, String status) {
    final index = history.indexWhere((element) => element.id == id);
    Logger().i("Index: ${id}");
    Logger().i("Index: ${history[0].id}");
    if (index != -1) {
      history[index] = HistoryBotChatModel(
        id: history[index].id,
        answer: history[index].answer,
        createdAt: history[index].createdAt,
        content: history[index].content,
        botVoiceUrl: history[index].botVoiceUrl,
        voiceUrl: history[index].voiceUrl,
        reportStatus: status,
      );
      history.refresh();
    }
  }

  Future<void> fetchHistory() async {
    if (paging.value.memberId.isEmpty) return;
    isLoading.value = true;
    final response = await HistoryService.getBotQuestionHistories(paging.value);

    // final tts = TtsServiceWithoutInstance();
    // await tts.initState();
    // final futures = response.items
    //     .map((e) => TtsServiceWithoutInstance()
    //         .convertToAudio(e.answer ?? "", time: e.createdAt))
    //     .toList();
    // await Future.wait(futures).then((value) {
    //   for (var i = 0; i < 2; i++) {
    //     response.items[i].botAudioPath = value[i].path;
    //   }
    // });
    // Logger().i(response.items[0].botAudioPath);
    addHistory(response.items);
    isLoadMore.value = response.totalItem > history.length;
    Logger().i("Total item: ${history.length}");
    isLoading.value = false;
  }

  void addHistory(List<HistoryBotChatModel> list) {
    history.addAll(list);
    history.refresh();
  }
}
