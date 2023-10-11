import 'package:chatkid_mobile/models/family_model.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createFamilyProvider =
    FutureProvider.family<FamilyModel, String>((ref, name) async {
  try {
    return await ref.watch(familyServiceProvider).createFamily(name: name);
  } catch (e) {
    throw Exception(e);
  }
});
