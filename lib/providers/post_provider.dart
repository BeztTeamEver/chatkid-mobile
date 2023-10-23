import 'package:chatkid_mobile/models/post_model.dart';
import 'package:chatkid_mobile/services/post_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postDataProvider = FutureProvider<List<PostModel>>((ref) async {
  return await ref.watch(postServiceProvider).get();
});
