import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/dashed_divider.dart';
import 'package:dart_date/dart_date.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TimelineHead extends StatefulWidget {
  final TaskModel task;
  const TimelineHead({super.key, required this.task});

  @override
  State<TimelineHead> createState() => _TimelineHeadState();
}

class _TimelineHeadState extends State<TimelineHead> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color fontColor = neutral.shade400;
    Color containerColor = Colors.transparent;

    if (widget.task.startTime.isBefore(DateTime.now()) &&
        widget.task.endTime.isAfter(DateTime.now())) {
      fontColor = primary.shade800;
      containerColor = primary.shade200;
    }
    return Container(
      width: 60,
      height: 96,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            widget.task.startTime.format('HH:mm'),
            style: TextStyle(
              color: fontColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: DashedDivider(
              dashWidth: 1,
              dashHeight: 3,
              direction: DashedDirection.vertical,
              color: fontColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.task.endTime.format('HH:mm'),
            style: TextStyle(
              color: fontColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
