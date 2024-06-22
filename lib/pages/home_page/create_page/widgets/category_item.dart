import 'dart:ui';

import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:logger/logger.dart';

class CategoryItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final bool isFavorited;
  final Function(String id) onTap;
  final bool isSelected;
  final String id;
  final TaskTypeModel taskType;
  final int taskCategoriesIndex;
  final int taskTypeIndex;
  const CategoryItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.isFavorited,
    required this.onTap,
    required this.id,
    required this.taskType,
    required this.taskCategoriesIndex,
    required this.taskTypeIndex,
    this.isSelected = false,
  });
  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem>
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
      onLongPress: () {
        todoFormCreateController.toggleEdit();
      },
      onLongPressDown: (details) => _controller
          .forward(from: 0)
          .timeout(Duration(milliseconds: 100), onTimeout: () {
        _controller.reverse(from: 1);
      }),
      // onLongPressEnd: (details) => _controller.reverse(from: 1),
      // onForcePressStart: (details) => _controller.forward(from: 0).timeout(
      //   Duration(milliseconds: 100),
      //   onTimeout: () {
      //     _controller.reverse(from: 1);
      //   },
      // ),
      // onForcePressEnd: (details) => _controller.reverse(from: 1),
      // onSecondaryLongPressMoveUpdate: (details) {},
      // onLongPressUp: () => _controller.reverse(from: 1),
      onTap: () {
        widget.onTap(widget.id);
        // Logger().i('CategoryItem onTap');
        // if (todoFormCreateController.isEdit.value) {
        //   todoFormCreateController.toggleFavoriteTaskType(
        //       widget.taskCategoriesIndex, widget.taskType);
        // }
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
                    tag: widget.id,
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
                  Obx(
                    () => todoFormCreateController.isEdit.value
                        ? Positioned(
                            top: 6,
                            left: 8,
                            child: SvgIcon(
                              icon: todoFormCreateController
                                      .taskCategories[
                                          widget.taskCategoriesIndex]
                                      .taskTypes[widget.taskTypeIndex]
                                      .isFavorited!
                                  ? 'pin_on'
                                  : 'pin_off',
                              size: 18,
                            ),
                          )
                        : Container(),
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
