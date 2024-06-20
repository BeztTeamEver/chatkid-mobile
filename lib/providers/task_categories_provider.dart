import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/services/task_category_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getTaskCategoriesProvider =
    FutureProvider.family<List<TaskCategoryModel>, PagingModel>(
        (ref, args) async {
  try {
    final result = await ref
        .watch<TaskCategoryService>(taskCategoryServiceProvider)
        .getTaskCategories(args);
    return result;
  } catch (e) {
    throw Exception(e);
  }
});
