import 'dart:convert';

import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/enum/todo.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/response_model.dart';
import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/target_store.dart';
import 'package:chatkid_mobile/services/target_service.dart';
import 'package:chatkid_mobile/services/todo_service.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/utils/toast.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';
import 'package:logger/web.dart';

class TodoHomeStore extends GetxController {
  static TodoHomeStore get to => Get.find();
  Rx<double> itemWidth = 0.0.obs;
  Rx<int> listContainerWidth = 0.obs;
  RxList<UserModel> members = <UserModel>[].obs;
  Rx<int> currentUserIndex = 0.obs;
  Rx<bool> isTaskLoading = false.obs;
  Rx<bool> isTargetLoading = false.obs;
  Rx<String> currentTask = "".obs;
  Rx<TargetModel> selectedTarget = TargetModel(
    id: "",
    message: "",
    endTime: DateTime.now(),
    startTime: DateTime.now(),
    currentProgress: 0,
    totalProgress: 0,
    memberId: "",
    missions: [],
    reward: "",
    rewardImageUrl: "",
  ).obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  Rx<PagingModelWithFilter<TodoFilter>> pagingRequest =
      PagingModelWithFilter<TodoFilter>(
    pageNumber: 0,
    pageSize: 100,
    filter: TodoFilter(
      date: DateTime.now(),
    ),
  ).obs;

  // Rx<TaskListModel> tasks = TaskListModel(
  //   availableTasks: <TaskModel>[].obs,
  //   inprogressTasks: <TaskModel>[].obs,
  //   pendingTasks: <TaskModel>[].obs,
  //   completedTasks: <TaskModel>[].obs,
  //   canceledTasks: <TaskModel>[].obs,
  //   expiredTasks: <TaskModel>[].obs,
  //   notCompletedTasks: <TaskModel>[].obs,
  // ).obs;
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxList<TargetModel> targets = <TargetModel>[].obs;

  RxList<String> favoritedTaskTypes = <String>[].obs;
  Rx<UserModel> get currentUser {
    if (currentUserIndex.value == -1) {
      return UserModel().obs;
    }
    return members[currentUserIndex.value].obs;
  }

  Rx<bool> get isOverall {
    if (currentUserIndex.value == -1) {
      return true.obs;
    }
    return false.obs;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchData();
  }

  fetchOverall() async {
    final tasksData = TodoService().fetchTaskByDate(TodoFilter(
      date: selectedDate.value,
    ));
    final targetsData = TargetService().getTargets(
      TargetListRequestModel(
        date: selectedDate.value,
      ),
    );

    final [taskList as List<TaskModel>, targetList as List<TargetModel>] =
        await Future.wait([tasksData, targetsData]).catchError((e) {
      throw e;
    });

    if (targetList.isNotEmpty) {
      setTargets(targetList);
    }

    if (taskList.isNotEmpty) {
      setTasks(taskList);
    }
  }

  fetchMemberTask() async {
    final tasksData = TodoService().getMemberTasks(
        members[currentUserIndex.value].id!, pagingRequest.value);
    final targetsData = TargetService().getTargetByMember(
      TargetListRequestModel(
        memberId: members[currentUserIndex.value].id!,
        date: selectedDate.value,
      ),
    );

    final [
      taskList as PagingResponseModel<TaskModel>,
      targetList as List<TargetModel>
    ] = await Future.wait([tasksData, targetsData]).catchError((e) {
      throw e;
    });

    if (targetList.isNotEmpty) {
      setTargets(targetList);
    }

    if (taskList.items.isNotEmpty) {
      setTasks(taskList.items);
    }
  }

  fetchData() async {
    isTaskLoading.value = true;
    isTargetLoading.value = true;
    try {
      tasks.value.clear();
      targets.clear();

      pagingRequest.value.pageNumber = 0;
      pagingRequest.value.pageSize = 100;
      if (members.isEmpty) {
        return;
      }

      if (currentUserIndex.value == -1) {
        await fetchOverall();
      } else {
        await fetchMemberTask();
      }
    } catch (e, stack) {
      Logger().e(e);
      Logger().e(stack);
      ShowToast.error(msg: e.toString());
    } finally {
      isTaskLoading.value = false;
      isTargetLoading.value = false;
    }
  }

  setDate(DateTime date) async {
    selectedDate.value = date;
    pagingRequest.value.filter?.date = date;
    await fetchData();
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
    // tasks.forEach((element) {
    // switch (element.status) {
    //   case TodoStatus.inprogress:
    //     this.tasks.value.inprogressTasks.add(element);
    //     break;
    //   case TodoStatus.available:
    //     this.tasks.value.availableTasks.add(element);
    //     break;
    //   case TodoStatus.pending:
    //     this.tasks.value.pendingTasks.add(element);
    //     break;
    //   case TodoStatus.completed:
    //     this.tasks.value.completedTasks.add(element);
    //     break;
    //   case TodoStatus.notCompleted:
    //     this.tasks.value.notCompletedTasks.add(element);
    //     break;
    //   case TodoStatus.expired:
    //     this.tasks.value.expiredTasks.add(element);
    //     break;

    //   default:
    //     this.tasks.value.canceledTasks.add(element);
    // }
    // });
    List<TaskModel> newTask = [];
    tasks.sort((a, b) => a.startTime.compareTo(b.startTime));
    tasks.forEach((element) {
      if (element.status != TodoStatus.canceled) {
        newTask.add(element);
      }
    });
    this.tasks.assignAll(newTask);
  }

  setSelectedTarget(TargetModel target) {
    selectedTarget.value = target;
  }

  Future<void> deleteTask(String id) async {
    try {
      await TodoService().deleteTask(id);
      // tasks.value.availableTasks.removeWhere((element) => element.id == id);
      // tasks.value.inprogressTasks.removeWhere((element) => element.id == id);
      // tasks.value.pendingTasks.removeWhere((element) => element.id == id);
      // tasks.value.completedTasks.removeWhere((element) => element.id == id);
      // tasks.value.expiredTasks.removeWhere((element) => element.id == id);
      // tasks.value.canceledTasks.removeWhere((element) => element.id == id);
      // tasks.value.notCompletedTasks.removeWhere((element) => element.id == id);
      tasks.removeWhere((element) => element.id == id);
      tasks.refresh();
    } catch (e) {
      Logger().e(e);
      ShowToast.error(msg: e.toString());
    }
  }

  setTargets(List<TargetModel> targets) {
    final filteredTargets = targets
        .where((element) => element.status != TodoStatus.canceled)
        .toList();
    this.targets.assignAll(filteredTargets);
  }

  updateTarget(TargetModel target) {
    final index = targets.indexWhere((element) => element.id == target.id);
    if (index != -1) {
      targets[index] = target;
    }
    targets.refresh();
  }

  updateTask(TaskModel task) {
    // final index = tasks.value.availableTasks.indexWhere((element) {
    //   return element.id == task.id;
    // });
    // if (index != -1) {
    //   tasks.value.availableTasks[index] = task;
    // }
    final index = tasks.indexWhere((element) => element.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }
    tasks.refresh();
  }

  removeTarget(TargetModel target) {
    targets.removeWhere((element) => element.id == target.id);
  }

  setTask(String id) {
    currentTask.value = id;
  }

  updateTaskStatus(String id, String? fromStatus, String toStatus) async {
    try {
      int index = tasks.indexWhere((element) => element.id == id);
      if (index != -1) {
        tasks[index].status = toStatus;
        tasks.refresh();
      }

      // TaskModel? task = tasks.firstWhereOrNull((element) => element.id == id);

      // switch (fromStatus) {
      //   case TodoStatus.available:
      //     if (tasks.value.availableTasks.isEmpty) {
      //       return;
      //     }
      //     task = tasks.value.availableTasks
      //         .firstWhere((element) => element.id == id);
      //     tasks.value.availableTasks.remove(task);
      //     break;
      //   case TodoStatus.inprogress:
      //     if (tasks.value.inprogressTasks.isEmpty) {
      //       return;
      //     }
      //     task = tasks.value.inprogressTasks
      //         .firstWhere((element) => element.id == id);
      //     tasks.value.inprogressTasks.remove(task);
      //     break;
      //   case TodoStatus.pending:
      //     if (tasks.value.pendingTasks.isEmpty) {
      //       return;
      //     }
      //     task = tasks.value.pendingTasks
      //         .firstWhere((element) => element.id == id);
      //     tasks.value.pendingTasks.remove(task);
      //     break;
      // }
      // if (task == null) {
      //   return;
      // }
      // switch (toStatus) {
      //   case TodoStatus.inprogress:
      //     tasks.value.inprogressTasks.add(task);
      //     break;
      //   case TodoStatus.pending:
      //     tasks.value.pendingTasks.add(task);
      //     break;
      //   case TodoStatus.completed:
      //     tasks.value.completedTasks.add(task);
      //     break;
      //   case TodoStatus.notCompleted:
      //     tasks.value.notCompletedTasks.add(task);
      //     break;
      //   case TodoStatus.expired:
      //     tasks.value.expiredTasks.add(task);
      //     break;
      // }
    } catch (e, s) {
      Logger().e(e, stackTrace: s);
      ShowToast.error(msg: e.toString());
    }
  }

  removeTask() {
    currentTask = "".obs;
  }
}

class TodoFormCreateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static final tag = 'todoFormCreateController';
  final formKey = GlobalKey<FormBuilderState>();
  final navigatorKey = GlobalKey<NavigatorState>();
  final taskTypeNavigatorKey = GlobalKey<NavigatorState>();

  final Rxn<AnimationController> stepController = Rxn<AnimationController>();
  RxList<TaskCategoryModel> taskCategories = <TaskCategoryModel>[].obs;

  Rx<bool> isEdit = false.obs;
  Rx<bool> isDelete = false.obs;
  RxInt step = 1.obs;

  Rx<String> selectedDeletingTaskTypeId = "".obs;

  Rx<TodoCreateType> todoCreateType = TodoCreateType.TASK.obs;

  Rx<String> selectedTaskType = "".obs;
  RxList<String> pinnedList = <String>[].obs;
  RxList<String> unpinnedList = <String>[].obs;
  RxMap<String, dynamic> initForm = {
    "id": "",
    "startTime": DateTime.now(),
    "endTime": DateTime.now(),
    "frequency": <String>[],
    "numberOfCoin": '0',
    "memberIds": [],
    "duration": DateTime.now(),
    "note": "",
    "assignees": <String>[],
  }.obs;

  @override
  void onInit() {
    super.onInit();
    // stepController.value = AnimationController(
    //   duration: const Duration(milliseconds: 600),
    //   vsync: this,
    // );
  }

  initTask(String id) async {
    try {
      final taskDetail = await TodoService().getTaskDetail(id);
      final endTime = taskDetail.endTime;

      selectedTaskType.value = taskDetail.taskType.id;
      initForm['id'] = taskDetail.id;
      initForm['startTime'] = taskDetail.startTime;
      initForm['endTime'] = taskDetail.endTime;
      initForm['frequency'] = taskDetail.frequency;
      initForm['numberOfCoin'] = "${taskDetail.numberOfCoin}";
      initForm['note'] = taskDetail.note;

      final hour = endTime.diff(taskDetail.startTime).inHours;
      final minute = endTime.diff(taskDetail.startTime).inMinutes % 60;
      initForm['duration.hour1'] = '${(hour / 10).floor()}';
      initForm['duration.hour2'] = '${hour % 10}';
      initForm['duration.minute1'] = '${(minute / 10).floor()}';
      initForm['duration.minute2'] = '${minute % 10}';
      initForm['frequency'] = taskDetail.frequency;

      // if (todoHomeStore.currentTask.value != null) {
      //   final task = todoHomeStore.currentTask.value!;
      //   formKey.currentState. = {
      //     "startTime": DateTime.now(),
      //     "endTime": DateTime.now(),
      //     "frequency": <String>[],
      //     "numberOfCoin": '0',
      //     "memberIds": [],
      //     "duration": DateTime.now(),
      //     "note": "",
      //     "assignees": <String>[],
      //   };
      // }
    } catch (e, stack) {
      Logger().e(e, stackTrace: stack);
      ShowToast.error(
          msg: "Không thể lấy thông tin công viêc, vui lòng thử lại");
    }
  }

  @override
  onClose() {
    stepController.value?.dispose();
    isEdit.close();
    step.close();
    todoCreateType.close();
    stepController.close();
    taskCategories.close();
    selectedTaskType.close();
    pinnedList.close();
    unpinnedList.close();
    super.onClose();
  }

  updateProgress() {
    stepController.value?.animateTo(step / 4);
  }

  setSelectedDeletingTaskTypeId(String id) {
    selectedDeletingTaskTypeId.value = id;
  }

  setSelectedTaskType(String taskType) {
    selectedTaskType.value = taskType;
  }

  setTaskType(TodoCreateType type) {
    todoCreateType.value = type;
  }

  setTaskCategories(List<TaskCategoryModel> taskCategories) {
    final newCategories = taskCategories.map((e) {
      final newTaskTypes =
          e.taskTypes.fold(<TaskTypeModel>[], (previousValue, task) {
        if (task.status != TodoStatus.unavailable) {
          previousValue.add(task);
        }
        return previousValue;
      });
      e.taskTypes = newTaskTypes;
      return e;
    });
    this.taskCategories.assignAll(newCategories);
  }

  toggleDelete() {
    setSelectedDeletingTaskTypeId("");
    isDelete.value = !isDelete.value;
  }

  deleteTaskType() async {
    await TodoService().deleteTaskType(selectedDeletingTaskTypeId.value);
    taskCategories.forEach((category) {
      category.taskTypes.removeWhere(
          (element) => element.id == selectedDeletingTaskTypeId.value);
    });
    selectedDeletingTaskTypeId.value = "";
  }

  toggleEdit() {
    isEdit.value = !isEdit.value;

    if (isEdit.value == false) {
      taskCategories.forEach((category) {
        category.taskTypes.forEach((taskType) {
          if (taskType.isFavorited == true) {
            if (pinnedList.firstWhereOrNull(
                    (element) => element.contains(taskType.id)) !=
                null) {
              taskType.isFavorited = false;
            }
          } else {
            if (unpinnedList.firstWhereOrNull(
                    (element) => element.contains(taskType.id)) !=
                null) {
              taskType.isFavorited = true;
            }
          }
        });
      });
      pinnedList.clear();
      unpinnedList.clear();
      taskCategories.refresh();
    }
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
    final pinnedPromise = TodoService().pinTask(pinnedList);
    final unpinnedPromise =
        unpinnedList.map((e) => TodoService().unpinTask(e)).toList();

    return await Future.wait([
      pinnedPromise,
      ...unpinnedPromise,
    ]).then((value) {
      return value.every((element) => element);
    }).catchError((e) {
      throw e;
    }).whenComplete(() {
      pinnedList.clear();
      unpinnedList.clear();
      isEdit.value = false;
    });
  }

  void NavigateTo(BuildContext context, Widget page) {
    navigatorKey.currentState!.push(createRoute(() => page));
  }

  void NavigatePop() {
    navigatorKey.currentState!.pop();
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
