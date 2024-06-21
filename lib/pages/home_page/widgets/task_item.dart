import 'dart:convert';

import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

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
        onLongPressed: () {
          showModalBottomSheet(
            context: context,
            enableDrag: true,
            showDragHandle: true,
            builder: (context) {
              return TaskActions();
            },
          );
        },
        backgroundImage: widget.task.taskType.imageHomeUrl ??
            "https://picsum.photos/200/200",
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

class TaskActionsState extends State<TaskActions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _height = 100;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
          ListTile(
            title: Text("Chỉnh sửa"),
            leading: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
