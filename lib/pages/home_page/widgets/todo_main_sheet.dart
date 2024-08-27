import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/calendar.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/custom_tab_bar.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/task_list.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class TodoMainBottomSheet extends ConsumerStatefulWidget {
  final GlobalKey<State<StatefulWidget>> bottomSheetKey;
  final TodoHomeStore todoHomeController;

  const TodoMainBottomSheet({
    super.key,
    required this.bottomSheetKey,
    required this.todoHomeController,
  });

  @override
  ConsumerState<TodoMainBottomSheet> createState() =>
      _TodoMainBottomSheetState();
}

class _TodoMainBottomSheetState extends ConsumerState<TodoMainBottomSheet>
    with SingleTickerProviderStateMixin {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  late final TabController _tabController;
  final TodoHomeStore todoHomeController = Get.find();

  bool isExpanded = false;

  openSheet() {
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

  init() {
    if (todoHomeController.members.isNotEmpty) {
      todoHomeController.fetchData();
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
      initialChildSize: 0.72,
      minChildSize: 0.72,
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
            cacheExtent: 0.5,
            physics: NeverScrollableScrollPhysics(),
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
                pinned: true,
                toolbarHeight: 46,
                titleSpacing: 0,
                title: Container(
                  decoration: BoxDecoration(
                    color: primary.shade100,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 18),
                  child: CustomTabBar(
                    onTabChange: (index) {
                      setState(() => _tabController.animateTo(index));
                    },
                    tabs: const ["Công việc", "Mục tiêu"],
                    tabController: _tabController,
                  ),
                ),
              ),
              SliverAppBar(
                primary: false,
                centerTitle: true,
                toolbarHeight: 132,
                titleSpacing: 0,
                pinned: true,
                backgroundColor: primary.shade100,
                title: Container(
                  decoration: BoxDecoration(
                    color: primary.shade100,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: const Calendar(),
                ),
              ),

              // SliverList.builder(
              //   itemBuilder: (context, index) {
              //     return TaskItem();
              //   },r
              //   itemCount: 20,
              // ),

              TaskList(
                tabController: _tabController,
                scrollController: scrollController,
              ),
            ],
          ),
        );
        // bottomSheet:,
      },
    );
  }
}
