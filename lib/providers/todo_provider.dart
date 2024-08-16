import 'package:chatkid_mobile/models/emoji_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/services/todo_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final getTaskByMember = FutureProvider.autoDispose
    .family<PagingResponseModel<TaskModel>, TodoRequestModel>(
  (ref, params) async {
    try {
      final result = await ref
          .watch(todoServiceProvider)
          .getMemberTasks(params.memberId, params.paging);
      return result;
    } catch (e, s) {
      Logger().e(e);
      throw Exception(e);
    }
  },
);

final getTaskEmoji = FutureProvider.autoDispose<List<EmojiModel>>(
  (ref) async {
    try {
      final result = await ref.watch(todoServiceProvider).getTaskEmoji();
      return result;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  },
);

final fetchTaskByDate =
    FutureProvider.autoDispose.family<List<TaskModel>, TodoFilter>(
  (ref, filter) async {
    try {
      final result =
          await ref.watch(todoServiceProvider).fetchTaskByDate(filter);
      return result;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  },
);
