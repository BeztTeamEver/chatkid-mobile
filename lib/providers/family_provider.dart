import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final createFamilyProvider =
    FutureProvider.family<ResponseModel<dynamic>, String>((ref, name) async {
  try {
    return await ref.watch(familyServiceProvider).createFamily(name: name);
  } catch (e, s) {
    Logger().e(e, stackTrace: s);
    throw Exception(e);
  }
});

final getFamilyProvider =
    FutureProvider.family<List<UserModel>, FamilyRequestModel?>(
  (ref, arg) async {
    try {
      final result =
          await ref.watch(familyServiceProvider).getFamilyAccounts(arg);
      return result;
    } catch (e, s) {
      throw Exception(e);
    }
  },
);
