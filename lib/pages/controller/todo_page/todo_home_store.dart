import 'package:chatkid_mobile/enum/todo.dart';
import 'package:chatkid_mobile/models/paging_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/services/family_service.dart';
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

  Rx<DateTime> selectedDate = DateTime.now().obs;

  Rx<PagingModelWithFilter<TodoFilter>> pagingRequest =
      PagingModelWithFilter<TodoFilter>(
    pageNumber: 0,
    pageSize: 10,
    filter: TodoFilter(
      date: DateTime.now(),
    ),
  ).obs;

  Rx<TaskListModel> tasks = TaskListModel(pendingTasks: [
    TaskModel(
        id: "1",
        taskTypeId: "1",
        memberId: "1",
        startTime: DateTime.now(),
        note: "Note 1",
        status: "PENDING",
        taskType: TaskTypeModel(id: "1", name: "Task 1"))
  ], completedTasks: []).obs;

  nextDate({
    int days = 1,
  }) {
    selectedDate.value = selectedDate.value.add(Duration(days: days));
  }

  prevDate({
    int days = 1,
  }) {
    selectedDate.value = selectedDate.value.sub(Duration(days: days));
  }

  setCurrentUser(int index) {
    currentUser.value = index;
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
        case "PENDING":
          this.tasks.value.pendingTasks.add(element);
          break;
        case "COMPLETED":
          this.tasks.value.completedTasks.add(element);
          break;
      }
    });
  }
}

class TodoFormCreateController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  Rx<TodoCreateType> todoCreateType = TodoCreateType.TASK.obs;

  setTaskType(TodoCreateType type) {
    todoCreateType.value = type;
  }
}
