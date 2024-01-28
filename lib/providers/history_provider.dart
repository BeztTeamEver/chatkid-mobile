import 'package:chatkid_mobile/services/history_tracking_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyServiceProvider = Provider((ref) => HistoryTrackingService());

final getHistoryProvider = FutureProvider.autoDispose((ref) async {
  return await ref.watch(historyServiceProvider).getHistory();
});