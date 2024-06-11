import 'dart:ffi';

import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/calendar.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/task_item.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class TodoMainBottomSheet extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> bottomSheetKey;
  final TodoHomeStore todoHomeController;

  const TodoMainBottomSheet({
    super.key,
    required this.bottomSheetKey,
    required this.todoHomeController,
  });

  @override
  State<TodoMainBottomSheet> createState() => _TodoMainBottomSheetState();
}

class _TodoMainBottomSheetState extends State<TodoMainBottomSheet>
    with SingleTickerProviderStateMixin {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  late final TabController _tabController;

  bool isExpanded = false;

  openSheet() {
    Logger().d(_sheetController.size);
    if (_sheetController.size < 1) {
      _sheetController.animateTo(
        1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceIn,
      );
      setState(() {
        isExpanded = true;
      });
    } else {
      _sheetController.animateTo(
        0.7,
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceIn,
      );
      setState(() {
        isExpanded = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: widget.bottomSheetKey,
      maxChildSize: 1,
      initialChildSize: 0.7,
      minChildSize: 0.7,
      shouldCloseOnMinExtent: false,
      // enableDrag: false,
      // constraints: BoxConstraints(
      //   minHeight: MediaQuery.of(context).size.height -
      //       MediaQuery.of(context).size.height / 3 -
      //       22,
      //   maxHeight: MediaQuery.of(context).size.height -
      //       MediaQuery.of(context).size.height / 3 -
      //       22,
      // ),
      // onClosing: () {},
      controller: _sheetController,
      builder: (context, scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: primary.shade100,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            cacheExtent: 0.5,
            slivers: [
              SliverAppBar(
                primary: true,
                titleSpacing: 0,
                pinned: true,
                toolbarHeight: 20,
                expandedHeight: 20,
                leadingWidth: 0,
                centerTitle: true,
                backgroundColor: primary.shade100,
                title: GestureDetector(
                  onTap: openSheet,
                  child: Container(
                    height: 30,
                    width: 1000,
                    decoration: BoxDecoration(
                      color: primary.shade100,
                    ),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: primary.shade300,
                        ),
                        height: 4,
                        width: 70,
                        margin: const EdgeInsets.only(top: 10),
                      ),
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                primary: false,
                centerTitle: true,
                toolbarHeight: 64,
                titleSpacing: 0,
                pinned: true,
                backgroundColor: primary.shade100,
                title: Container(
                  decoration: BoxDecoration(
                    color: primary.shade100,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: Calendar(),
                ),
              ),
              SliverAppBar(
                primary: false,
                pinned: true,
                toolbarHeight: 46,
                titleSpacing: 0,
                title: Container(
                  decoration: BoxDecoration(
                    color: primary.shade100,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 18),
                  child: CustomTabbar(
                    onTabChange: (index) {
                      setState(() => _tabController.animateTo(index));
                    },
                    tabs: const ["Công việc", "Phong trào thi đua"],
                    tabController: _tabController,
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.only(top: 8, bottom: 26),
                      child: Column(
                        children: [
                          SliverList.builder(
                            itemBuilder: (context, index) {
                              return TaskItem();
                            },
                            itemCount: 2,
                          ),
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   itemCount: 2,
                          //   itemBuilder: (context, index) {
                          //     return TaskItem();
                          //   },
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: primary.shade100,
                          //   ),
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 12, vertical: 12),
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         "Đã hoàn thành",
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .bodyMedium!
                          //             .copyWith(
                          //               fontSize: 16,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //       ),
                          //       SizedBox(width: 8),
                          //       Expanded(
                          //         child: Divider(
                          //           height: 2,
                          //           indent: 4,
                          //           endIndent: 10,
                          //           color: neutral.shade300,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ), // TODO: completed task
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   itemCount: 12,
                          //   itemBuilder: (context, index) {
                          //     return TaskItem();
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        );
        // bottomSheet:,
      },
    );
  }
}
