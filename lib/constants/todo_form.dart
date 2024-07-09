import 'package:chatkid_mobile/constants/calendar.dart';
import 'package:chatkid_mobile/models/option.dart';

class TodoCreateFormOptions {
  static final daysOfWeekOption = List.generate(
    DateTime.daysPerWeek,
    (index) => OptionModel<String>(
        value: weekDayValue[index], label: weekDayShort[index]),
  );
}
