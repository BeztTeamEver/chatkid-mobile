import 'package:chatkid_mobile/models/gpt_model.dart';
import 'package:chatkid_mobile/services/gpt_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gptProvider = StateNotifierProvider<GptNotifier, GptRequestModal>((ref) {
  return GptNotifier();
});

final sendMessageGpt = FutureProvider.family<String, Map<String, String>>((
  ref,
  data,
) async {
  final respondMessage = await ref
      .watch(gptProvider.notifier)
      .chat(data['message']!, data['kidServiceId']!);
  return respondMessage;
});
