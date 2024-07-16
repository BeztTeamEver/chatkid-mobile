import 'package:chatkid_mobile/models/target_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TargetFormStore extends GetxController {
  static TargetFormStore get to => Get.find();
  final RxList<TargetModel> template = <TargetModel>[].obs;
  final Rxn<AnimationController> stepController = Rxn<AnimationController>();
  final Key navigatorKey = GlobalKey();

  Rx<int> step = 0.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    stepController.value!.dispose();
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

  void NavigatePop() {
    Get.back();
  }
}
