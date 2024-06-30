import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/material.dart';

final StatusColorMap = {
  '${TodoStatus.submitted}': primary.shade500,
  '${TodoStatus.pending}': Colors.blue,
  '${TodoStatus.completed}': green.shade500,
  '${TodoStatus.expired}': neutral.shade500,
};

final StatusTextMap = {
  '${TodoStatus.submitted}': 'Đã gửi',
  '${TodoStatus.pending}': 'Chưa thực hiện',
  '${TodoStatus.completed}': 'Đã hoàn thành',
  '${TodoStatus.expired}': 'Trễ hạn',
};
