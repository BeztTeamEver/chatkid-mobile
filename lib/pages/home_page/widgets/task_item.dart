import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key});

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
            height: 26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task 1',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ButtonIcon(
                  onPressed: () {},
                  icon: "dots",
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                // TODO: use task time
                "${DateTime.now().format("H:m")} - ${DateTime.now().format("H:m")}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.volume_up,
                size: 24,
              ),
            ],
          ),
          SizedBox(height: 14),
        ],
      ),
    );
  }
}
