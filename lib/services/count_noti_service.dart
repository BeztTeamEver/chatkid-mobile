import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CountNotiController extends GetxController {
  Rx<int> countNoti = 0.obs;
  Rx<int> countChat = 0.obs;
  Rx<int> currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onChangeIndex(int index) {
    currentIndex.value = index;

    // open chat page
    if (index == 2) {
      Logger().d(index);
      countChat.value = 0;
    }
    // open notification page
    if (index == 3) {
      countNoti.value = 0;
    }
  }

  void onCountNoti() {
    if (currentIndex.value != 3) countNoti.value += 1;
  }

  void onCountChat() {
    if (currentIndex.value != 2) countChat.value += 1;
  }
}
