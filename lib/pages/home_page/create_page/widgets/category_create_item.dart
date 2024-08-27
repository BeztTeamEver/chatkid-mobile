import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/create_task_type_page/create_task_type_page.dart';
import 'package:chatkid_mobile/pages/home_page/create_page/create_task_type_page/task_type_icon.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CategoryCreateItem extends StatefulWidget {
  final Function(bool id) onTap;
  const CategoryCreateItem({super.key, required this.onTap});

  @override
  State<CategoryCreateItem> createState() => _CategoryCreateItemState();
}

class _CategoryCreateItemState extends State<CategoryCreateItem>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final TodoFormCreateController todoFormCreateController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return !todoFormCreateController.isDelete.value &&
            !todoFormCreateController.isEdit.value
        ? GestureDetector(
            onLongPress: () {},
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
            onTap: () async {
              // widget.onTap();
              // Logger().i('CategoryItem onTap');
              // if (todoFormCreateController.isEdit.value) {
              //   todoFormCreateController.toggleFavoriteTaskType(
              //       widget.taskCategoriesIndex, widget.taskType);
              // }
              // Navigator.push(context, createRoute(() => CreateTaskTypePage()));
              await Get.to(() => TaskTypeIcon())?.then((value) {
                Logger().i(value);
                if (value) {
                  widget.onTap(value);
                }
              });
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
                          tag: "category_create_item",
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: primary.shade500,
                            borderPadding: EdgeInsets.all(4),
                            radius: Radius.circular(16),
                            strokeWidth: 1,
                            dashPattern: const [4, 4],
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: 72,
                              height: 72,
                              child: Icon(
                                Icons.add,
                                size: 32,
                                color: primary.shade500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Tạo mới",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
