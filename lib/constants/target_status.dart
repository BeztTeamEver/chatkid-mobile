import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/widgets/label.dart';

final TargetStatusLabelMap = {
  "${TargetStatus.AWARDED}": LabelType.POSITIVE,
  "${TargetStatus.CANCELLED}": LabelType.NEGATIVE,
  "${TargetStatus.COMPLETED}": LabelType.NEUTRAL,
  "${TargetStatus.IN_PROGRESS}": LabelType.INFO,
  "${TargetStatus.PENDING}": LabelType.WARNING,
  "${TargetStatus.EXPIRED}": LabelType.NEGATIVE,
  "${TargetStatus.NA}": LabelType.NEUTRAL,
};

final Map<String, String> TargetTextMap = {
  '${TargetStatus.AWARDED}': 'Đã nhận quà',
  '${TargetStatus.CANCELLED}': 'Đã hủy',
  '${TargetStatus.COMPLETED}': 'Chưa nhận quà',
  '${TargetStatus.IN_PROGRESS}': 'Đang thực hiện',
  '${TargetStatus.PENDING}': 'Chưa thực hiện',
  '${TargetStatus.EXPIRED}': 'Không hoàn thành',
};
