import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/services/target_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getTargetByMember = FutureProvider.autoDispose
    .family<List<TargetModel>, String>((ref, memberId) async {
  final response =
      await ref.read(targetServiceProvider).getTargetByMember(memberId);
  return response;
});
