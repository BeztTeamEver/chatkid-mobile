import 'package:chatkid_mobile/models/paging_modal.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/services/history_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getHistory =
    FutureProvider.family<List<PagingResponseModel>, PagingModel>(
        (ref, PagingModel paging) async {
  try {
    final result = await HistoryService.getHistory(paging);
    return result;
  } catch (e) {
    throw Exception(e);
  }
});
