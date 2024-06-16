import 'package:chatkid_mobile/enum/todo.dart';
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
}

class TodoFormCreateController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  Rx<TodoCreateType> todoCreateType = TodoCreateType.TASK.obs;

  setTaskType(TodoCreateType type) {
    todoCreateType.value = type;
  }
}
