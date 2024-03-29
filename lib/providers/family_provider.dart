import 'package:chatkid_mobile/models/channel_model.dart';
import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final createFamilyProvider =
    FutureProvider.family<ResponseModel<dynamic>, String>((ref, name) async {
  try {
    final result =
        await ref.watch(familyServiceProvider).createFamily(name: name);
    return result;
  } catch (e, s) {
    Logger().e(e, stackTrace: s);
    throw Exception(e);
  }
});

final getFamilyProvider = FutureProvider<FamilyModel>(
  (ref) async {
    try {
      final result = await ref.watch(familyServiceProvider).getFamily();
      return result;
    } catch (e) {
      throw Exception(e);
    }
  },
);

final getFamilyChannel = FutureProvider<ChannelModel>((ref) {
  try {
    final result = ref.watch(familyServiceProvider).getFamilyChannel();
    return result;
  } catch (e) {
    throw Exception(e);
  }
});
