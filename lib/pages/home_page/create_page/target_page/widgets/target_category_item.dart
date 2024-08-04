import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/target_page/widgets/mission_create_item.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TargetCategoryItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final bool isFavorited;
  final Function(String id) onTap;
  final bool isSelected;
  final String id;
  final TaskTypeModel taskType;
  final int taskCategoriesIndex;
  final int taskTypeIndex;
  final Function() onLongPress;

  const TargetCategoryItem({
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
    required this.onLongPress,
  });
  @override
  State<TargetCategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<TargetCategoryItem>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

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
      onLongPress: widget.onLongPress,
      onLongPressDown: (details) => _controller
          .forward(from: 0)
          .timeout(Duration(milliseconds: 100), onTimeout: () {
        _controller.reverse(from: 1);
      }),
      onTap: () {
        widget.onTap(widget.id);
      },
      child: SizedBox(
        width: 68,
        child: Column(
          children: [
            ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.10).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.elasticOut,
              )),
              child: Badge(
                textColor: green.shade400,
                label: widget.isSelected
                    ? Icon(
                        Icons.check_rounded,
                        size: 14,
                      )
                    : null,
                smallSize: 0,
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
                          fit: BoxFit.contain,
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
