import 'package:chatkid_mobile/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userFormProvider =
    Provider.autoDispose.family<UserFormNotifier, UserModel>((ref, user) {
  return UserFormNotifier(user);
});
