import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/enum/todo.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/family_service.dart';
import 'package:chatkid_mobile/services/todo_service.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';

class TodoHomeStore extends GetxController {
  static TodoHomeStore get to => Get.find();
  Rx<double> itemWidth = 0.0.obs;
  Rx<int> listContainerWidth = 0.obs;
  RxList<UserModel> members = <UserModel>[].obs;
  Rx<int> currentUserIndex = 0.obs;
  Rx<bool> isTaskLoading = false.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  Rx<PagingModelWithFilter<TodoFilter>> pagingRequest =
      PagingModelWithFilter<TodoFilter>(
    pageNumber: 0,
    pageSize: 100,
    filter: TodoFilter(
      date: DateTime.now(),
    ),
  ).obs;

  Rx<TaskListModel> tasks = TaskListModel(
          pendingTasks: <TaskModel>[].obs,
          completedTasks: <TaskModel>[].obs,
          canceledTasks: <TaskModel>[].obs,
          expiredTasks: <TaskModel>[].obs)
      .obs;

  RxList<String> favoritedTaskTypes = <String>[].obs;
  Rx<UserModel> get currentUser => members[currentUserIndex.value].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchData();
  }

  fetchData() async {
    isTaskLoading.value = true;
    try {
      tasks.value.pendingTasks.clear();
      tasks.value.completedTasks.clear();
      pagingRequest.value.pageNumber = 0;
      pagingRequest.value.pageSize = 100;
      if (members.isEmpty) {
        return;
      }
      final data = await TodoService().getMemberTasks(
          members[currentUserIndex.value].id!, pagingRequest.value);

      if (data.items.isNotEmpty) {
        setTasks(data.items);
      }
    } catch (e) {
      Logger().e(e);
    } finally {
      isTaskLoading.value = false;
    }
  }

  nextDate({
    int days = 1,
  }) async {
    selectedDate.value = selectedDate.value.add(Duration(days: days));
    if (members.isEmpty) {
      return;
    }
    pagingRequest.value.filter?.date = selectedDate.value;
    await fetchData();
  }

  prevDate({
    int days = 1,
  }) async {
    selectedDate.value = selectedDate.value.sub(Duration(days: days));
    if (members.isEmpty) {
      return;
    }
    pagingRequest.value.filter?.date = selectedDate.value;
    await fetchData();
  }

  setCurrentUser(int index) {
    currentUserIndex.value = index;
    fetchData();
  }

  setMembers(List<UserModel> members) {
    this.members.assignAll(members);
  }

  setPagingRequest(PagingModelWithFilter<TodoFilter> pagingRequest) {
    this.pagingRequest.value = pagingRequest;
  }

  setTasks(List<TaskModel> tasks) {
    tasks.forEach((element) {
      switch (element.status) {
        case TodoStatus.pending:
          this.tasks.value.pendingTasks.add(element);
          break;
        case TodoStatus.completed:
          this.tasks.value.completedTasks.add(element);
        case TodoStatus.expired:
          this.tasks.value.expiredTasks.add(element);
          break;

        default:
          this.tasks.value.canceledTasks.add(element);
      }
    });
  }

  deleteTask(String id) async {
    try {
      tasks.value.pendingTasks.removeWhere((element) => element.id == id);
      tasks.value.completedTasks.removeWhere((element) => element.id == id);
      tasks.value.expiredTasks.removeWhere((element) => element.id == id);
      tasks.value.canceledTasks.removeWhere((element) => element.id == id);
    } catch (e) {
      Logger().e(e);
    }
  }
}

class TodoFormCreateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormBuilderState>();

  final Rxn<AnimationController> stepController = Rxn<AnimationController>();
  RxList<TaskCategoryModel> taskCategories = <TaskCategoryModel>[].obs;

  Rx<bool> isEdit = false.obs;
  RxInt step = 1.obs;

  Rx<TodoCreateType> todoCreateType = TodoCreateType.TASK.obs;

  RxList<String> pinnedList = <String>[].obs;
  RxList<String> unpinnedList = <String>[].obs;
  @override
  void onInit() {
    super.onInit();
    // stepController.value = AnimationController(
    //   duration: const Duration(milliseconds: 600),
    //   vsync: this,
    // );
  }

  @override
  onClose() {
    stepController.value?.dispose();
    isEdit.close();
    step.close();
    todoCreateType.close();
    stepController.close();
    taskCategories.close();
    pinnedList.close();
    unpinnedList.close();
    super.onClose();
  }

  updateProgress(step) {
    stepController.value?.animateTo(step / 4);
  }

  setTaskType(TodoCreateType type) {
    todoCreateType.value = type;
  }

  setTaskCategories(List<TaskCategoryModel> taskCategories) {
    this.taskCategories.assignAll(taskCategories);
  }

  toggleEdit() {
    isEdit.value = !isEdit.value;
  }

  toggleFavoriteTaskType(int taskCategorisIndex, TaskTypeModel taskType) {
    // taskCategories[taskCategorisIndex].taskTypes[taskTypeIndex].isFavorited =
    //     !taskCategories[taskCategorisIndex]
    //         .taskTypes[taskTypeIndex]
    //         .isFavorited!;
    // taskCategories[taskCategorisIndex].taskTypes
    //     .firstWhere((element) => element.id == taskType.id)
    //     .isFavorited = !taskCategories[taskCategorisIndex]
    //         .taskTypes
    //         .firstWhere((element) => element.id == taskType.id)
    //         .isFavorited!;

    final task = taskCategories[taskCategorisIndex].taskTypes.obs.firstWhere(
          (element) => element.id == taskType.id,
        );
    if (task.isFavorited == false) {
      pinnedList.add(taskType.id);
      if (unpinnedList.contains(taskType.id)) {
        unpinnedList.remove(taskType.id);
      }
    } else {
      unpinnedList.add(taskType.id);
      if (pinnedList.contains(taskType.id)) {
        pinnedList.remove(taskType.id);
      }
    }
    task.isFavorited = !task.isFavorited!;
    taskCategories.refresh();
  }

  Future<bool> saveTask() async {
    final pinnedPromise =
        pinnedList.map((e) => TodoService().pinTask(e)).toList();
    final unpinnedPromise =
        unpinnedList.map((e) => TodoService().unpinTask(e)).toList();

    return await Future.wait([
      // ...pinnedPromise,
      ...unpinnedPromise,
    ]).then((value) {
      pinnedList.clear();
      unpinnedList.clear();
      isEdit.value = false;
      return value.every((element) => element);
    });
  }

  increaseStep() {
    step.value++;
  }

  decreaseStep() {
    step.value--;
  }

  resetStep() {
    step.value = 1;
  }
}
