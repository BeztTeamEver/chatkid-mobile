import 'package:chatkid_mobile/models/gpt_modal.dart';
import 'package:chatkid_mobile/services/gpt_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gptProvider = StateNotifierProvider<GptNotifier, GptRequestModal>((ref) {
  return GptNotifier();
});

final sendMessageGpt =
    FutureProvider.family<String, String>((ref, message) async {
  final respondMessage = await ref.watch(gptProvider.notifier).chat(message);
  return respondMessage;
});
