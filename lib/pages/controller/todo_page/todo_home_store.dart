import 'package:dart_date/dart_date.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:logger/logger.dart';

class TodoHomeStore extends GetxController {
  static TodoHomeStore get to => Get.find();
  double itemWidth = 0;
  double listContainerWidth = 0;

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
}
