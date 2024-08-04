import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';

final Map<String, Color> StatusColorMap = {
  '${TodoStatus.inprogress}': primary.shade500,
  '${TodoStatus.available}': primary.shade500,
  '${TodoStatus.pending}': Colors.blue,
  '${TodoStatus.notCompleted}': Colors.red,
  '${TodoStatus.completed}': green.shade500,
  '${TodoStatus.expired}': neutral.shade800,
};

final Map<String, String> StatusTextMap = {
  '${TodoStatus.inprogress}': 'Đang thực hiện',
  '${TodoStatus.pending}': 'Đã gửi',
  '${TodoStatus.available}': 'Chưa thực hiện',
  '${TodoStatus.completed}': 'Đã hoàn thành',
  '${TodoStatus.notCompleted}': 'Chưa hoàn thành',
  '${TodoStatus.expired}': 'Trễ hạn',
};
