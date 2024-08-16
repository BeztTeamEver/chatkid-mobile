import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/label.dart';
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
  '${TodoStatus.pending}': 'Chờ kiểm tra',
  '${TodoStatus.available}': 'Chưa thực hiện',
  '${TodoStatus.completed}': 'Đã hoàn thành',
  '${TodoStatus.notCompleted}': 'Làm lại nhé :(',
  '${TodoStatus.expired}': 'Không hoàn thành',
};

final Map<String, LabelType> StatusLabelTypeMap = {
  '${TodoStatus.inprogress}': LabelType.INFO,
  '${TodoStatus.pending}': LabelType.WARNING,
  '${TodoStatus.available}': LabelType.NEUTRAL,
  '${TodoStatus.completed}': LabelType.POSITIVE,
  '${TodoStatus.notCompleted}': LabelType.PRIMARY,
  '${TodoStatus.expired}': LabelType.NEGATIVE,
};
