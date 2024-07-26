import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/services/target_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getTargetByMember = FutureProvider.autoDispose
    .family<List<TargetModel>, TargetListRequestModel>((ref, member) async {
  final response = await ref.read(targetServiceProvider).getTargetByMember(
      TargetListRequestModel(memberId: member.memberId, date: member.date));
  return response;
});
