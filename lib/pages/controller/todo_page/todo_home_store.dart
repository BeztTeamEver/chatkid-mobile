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
import 'package:logger/logger.dart';

class TodoHomeStore extends GetxController {
  static TodoHomeStore get to => Get.find();
  Rx<double> itemWidth = 0.0.obs;
  Rx<int> listContainerWidth = 0.obs;
  RxList<UserModel> members = <UserModel>[].obs;
  Rx<int> currentUser = 0.obs;
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
      pendingTasks: [],
      completedTasks: [],
      canceledTasks: [],
      expiredTasks: []).obs;

  RxList<String> favoritedTaskTypes = <String>[].obs;

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
      final data = await TodoService()
          .getMemberTasks(members[currentUser.value].id!, pagingRequest.value);

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
    currentUser.value = index;
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
}

class TodoFormCreateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormBuilderState>();

  final Rxn<AnimationController> stepController = Rxn<AnimationController>();
  RxList<TaskCategoryModel> taskCategories = <TaskCategoryModel>[].obs;

  Rx<bool> isEdit = false.obs;
  RxInt step = 1.obs;

  Rx<TodoCreateType> todoCreateType = TodoCreateType.TASK.obs;

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
    super.onClose();
  }

  updateProgress(step) {
    Logger().i(step);
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
    Logger().i(taskType.id);
    taskCategories[taskCategorisIndex]
            .taskTypes
            .firstWhere(
              (element) => element.id == taskType.id,
            )
            .isFavorited =
        !taskCategories[taskCategorisIndex]
            .taskTypes
            .firstWhere((element) => element.id == taskType.id)
            .isFavorited!;
  }

  increaseStep() {
    step.value++;
  }

  decreaseStep() {
    step.value--;
  }
}
