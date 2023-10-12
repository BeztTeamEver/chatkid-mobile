import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final createFamilyProvider =
    FutureProvider.family<List<UserModel>, String>((ref, name) async {
  try {
    final result =
        await ref.watch(familyServiceProvider).createFamily(name: name);
    return result.data;
  } catch (e, s) {
    Logger().e(e, stackTrace: s);
    throw Exception(e);
  }
});
