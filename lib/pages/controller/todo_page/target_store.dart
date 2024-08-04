import 'package:chatkid_mobile/models/target_model.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/services/file_service.dart';
import 'package:chatkid_mobile/services/target_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TargetFormStore extends GetxController {
  static TargetFormStore get to => Get.find();
  final RxList<TargetModel> template = <TargetModel>[].obs;
  final Rxn<AnimationController> stepController = Rxn<AnimationController>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Rx<int> step = 0.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final RxList<TaskCategoryModel> categories = <TaskCategoryModel>[].obs;
  final RxList<String> missions = <String>[].obs;
  final RxList<String> giftImages = <String>[].obs;

  Rx<bool> isLoading = false.obs;
  RxMap<String, dynamic> initForm = TargetFormModel(
    endTime: DateTime.now(),
    startTime: DateTime.now(),
    memberId: '',
    reward: '',
    rewardImageUrl: '',
    message: '',
    missions: [],
  ).toMap().obs;

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
    giftImages.clear();
    super.onClose();
  }

  void initTarget(String id) async {
    try {
      isLoading.value = true;
      final target = await TargetService().getTargetDetail(id);
      final fields = formKey.currentState!.fields;
      // fields['startTime']?.didChange(target.startTime);
      // fields['endTime']?.didChange(target.endTime);
      // fields['message']?.didChange(target.message);
      // fields['missions']?.didChange(target.missions);
      Logger().i(target.startTime);
      formKey.currentState!.patchValue({
        'startTime': target.startTime,
        'endTime': target.endTime,
        'message': target.message,
        'reward': target.reward,
        'rewardImageUrl': target.rewardImageUrl,
      });

      initForm['reward'] = target.reward;
      initForm['id'] = target.id;
      // fields['reward']!.didChange(target.reward);
      // fields['rewardImageUrl']!.didChange(target.rewardImageUrl);

      target.missions.forEach((element) {
        initForm[element.taskTypeId!] = element.quantity.toString();
        addListMission(element.taskTypeId!);
      });

      if (target.rewardImageUrl != null && target.rewardImageUrl!.isNotEmpty) {
        final file =
            await FileService().saveFileToCache(target.rewardImageUrl ?? "");
        if (file?.path != null && file!.path.isNotEmpty) {
          addGiftImage(file.path);
        }
      }
      isLoading.value = false;
    } catch (e, s) {
      Logger().e(e);
    } finally {
      isLoading.value = false;
    }
  }

  void setTarget(TargetModel target) async {
    missions.clear();

    formKey.currentState?.setInternalFieldValue('message', target.message);
    formKey.currentState?.setInternalFieldValue('reward', target.reward);
    formKey.currentState
        ?.setInternalFieldValue('rewardImageUrl', target.rewardImageUrl);
    formKey.currentState?.setInternalFieldValue('startTime', target.startTime);
    formKey.currentState?.setInternalFieldValue('endTime', target.endTime);
    // formKey.currentState?.setInternalFieldValue('missions', target.missions);
    // formKey.currentState!.patchValue({
    //   'startTime': target.startTime,
    //   'endTime': target.endTime,
    //   'message': target.message,
    //   'reward': target.reward,
    //   'rewardImageUrl': target.rewardImageUrl,
    // });

    initForm['reward'] = target.reward;

    target.missions.forEach((element) {
      formKey.currentState?.setInternalFieldValue(
          element.taskTypeId!, element.quantity.toString());
      // initForm[element.taskTypeId!] = element.quantity.toString();
      addListMission(element.taskTypeId!);
    });

    if (target.rewardImageUrl != null && target.rewardImageUrl!.isNotEmpty) {
      final file =
          await FileService().saveFileToCache(target.rewardImageUrl ?? "");
      if (file?.path != null && file!.path.isNotEmpty) {
        addGiftImage(file.path);
      }
    }
  }

  void resetFields() {
    formKey.currentState!.reset();
    missions.clear();
    giftImages.clear();
    initForm = TargetFormModel(
      endTime: DateTime.now(),
      startTime: DateTime.now(),
      memberId: '',
      reward: '',
      rewardImageUrl: '',
      message: '',
      missions: [],
    ).toMap().obs;
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

  void addGiftImage(String image) {
    giftImages.add(image);
  }

  void removeGiftImage(String image) {
    giftImages.remove(image);
  }
}
