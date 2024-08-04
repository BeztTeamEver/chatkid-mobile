import 'dart:ui';

import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TaskTypeImageItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final TaskTypeImageModel taskType;
  final Function(String id) onTap;
  final bool isSelected;

  const TaskTypeImageItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.taskType,
    required this.onTap,
    this.isSelected = false,
  });
  @override
  State<TaskTypeImageItem> createState() => _TaskTypeImageItemState();
}

class _TaskTypeImageItemState extends State<TaskTypeImageItem>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  TodoFormCreateController todoFormCreateController = Get.find();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressDown: (details) => _controller
          .forward(from: 0)
          .timeout(Duration(milliseconds: 100), onTimeout: () {
        _controller.reverse(from: 1);
      }),
      onTap: () {
        widget.onTap(widget.taskType.name);
      },
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.10).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.elasticOut,
              )),
              child: Stack(
                children: [
                  Hero(
                    tag: widget.taskType.name,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      width: 72,
                      height: 72,
                      padding: EdgeInsets.all(1),
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: child,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
