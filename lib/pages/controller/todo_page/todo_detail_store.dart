import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TodoFeedbackStore extends GetxController {
  final Rxn<AnimationController> stepController = Rxn<AnimationController>();
  final PageController pageController = PageController();
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final tts = TtsService().instance;

  Rx<String> imagePath = ''.obs;
  Rx<bool> _isCaptured = false.obs;
  Rx<int> step = 0.obs;

  @override
  onInit() {
    super.onInit();
    // tts.speak(BotFeedBackMessage[step.value]);
  }

  @override
  void onClose() {
    stepController.value?.dispose();
    pageController.dispose();
    step.close();
    _isCaptured.close();
    super.onClose();
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

  void setIsCaptured(bool value) {
    _isCaptured.value = value;
  }

  void updateProgress() {
    stepController.value?.animateTo(step.value == 0 ? 0.1 : step.value / 4);
  }

  void nextPage() {
    // tts.speak(BotFeedBackMessage[step.value]);

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

  bool get isCaptured => _isCaptured.value;
}
