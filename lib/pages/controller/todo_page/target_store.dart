import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TargetFormStore extends GetxController {
  static TargetFormStore get to => Get.find();
  final RxList<TargetModel> template = <TargetModel>[].obs;
  final Rxn<AnimationController> stepController = Rxn<AnimationController>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Rx<int> step = 0.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final RxList<TaskCategoryModel> categories = <TaskCategoryModel>[].obs;
  final RxList<String> missions = <String>[
    'Mission 1',
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    stepController.close();
    template.clear();
    step.close();
    missions.clear();
    super.onClose();
  }

  void addTemplate(TargetModel target) {
    template.add(target);
  }

  void removeTemplate(TargetModel target) {
    template.remove(target);
  }

  void increaseStep() {
    step.value++;
  }

  void decreaseStep() {
    step.value--;
  }

  void resetStep() {
    step.value = 0;
  }

  void updateProgress() {
    stepController.value!.animateTo(step.value / 3);
  }

  void navigatePop() {
    navigatorKey.currentState!.pop();
  }

  void addListMission(String mission) {
    missions.add(mission);
  }

  void removeListMission(String mission) {
    missions.remove(mission);
  }

  void setCategory(List<TaskCategoryModel> category) {
    categories.clear();
    categories.addAll(category);
  }
}
