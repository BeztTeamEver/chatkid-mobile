import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomCard(
        backgroundImage: 'assets/todoPage/todoItem/taskBackground.svg',
        padding: EdgeInsets.only(left: 12, top: 6, bottom: 10),
        children: [
          Container(
            height: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.task.taskType.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.volume_up,
                      size: 24,
                    )
                  ],
                ),
                TaskActions(),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                // TODO: use task time
                "${widget.task.startTime.format("H:m")} ${widget.task.finishTime != null ? widget.task.finishTime?.format("H:m") : ""}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Thưởng 1000",
                style: TextStyle(
                  fontSize: 14,
                  color: neutral.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              SvgIcon(icon: 'coin')
            ],
          ),
        ],
      ),
    );
  }
}

class TaskActions extends StatefulWidget {
  const TaskActions({super.key});

  @override
  State<TaskActions> createState() => TaskActionsState();
}

class TaskActionsState extends State<TaskActions> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text(
              'Edit',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
          PopupMenuItem(
            child: Text(
              'Delete',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
        ];
      },
      iconSize: 18,
      padding: EdgeInsets.zero,
      icon: const SvgIcon(
        icon: 'dots',
        size: 18,
      ),
    );
  }
}
