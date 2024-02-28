import 'package:chatkid_mobile/models/history_model.dart';
import 'package:chatkid_mobile/models/paging_modal.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/services/history_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getHistoryProvider = FutureProvider.family<
    PagingResponseModel<HistoryModel>,
    HistoryRequestModal>((ref, request) async {
  final result = await HistoryService.getHistory(
    paging: request.paging,
    memberId: request.memberId,
  );
  return result;
});
