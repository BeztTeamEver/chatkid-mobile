import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TodoFeedbackStore extends GetxController {
  final Rxn<AnimationController> stepController = Rxn<AnimationController>();
  final PageController pageController = PageController();
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Rx<int> step = 1.obs;

  @override
  onInit() {}

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
    stepController.value?.animateTo(step.value / 5);
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
