import 'package:chatkid_mobile/constants/task_status.dart';
import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/target_item.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/target_item.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/status_divider.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/task_item.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required TabController tabController,
    required this.scrollController,
  }) : _tabController = tabController;

  final ScrollController scrollController;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          GetX<TodoHomeStore>(
            builder: (controller) {
              final isEmpty = controller.tasks.value.pendingTasks.isEmpty &&
                  controller.tasks.value.completedTasks.isEmpty &&
                  controller.tasks.value.expiredTasks.isEmpty &&
                  controller.tasks.value.inprogressTasks.isEmpty &&
                  controller.tasks.value.availableTasks.isEmpty &&
                  controller.tasks.value.notCompletedTasks.isEmpty;
              if (controller.isTaskLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (isEmpty) {
                return const Center(
                  child: Text("Không có công việc nào"),
                );
              }
              return TodoList(scrollController: scrollController);
            },
          ),
          GetX<TodoHomeStore>(
            builder: (controller) {
              final isEmpty = controller.targets.value.isEmpty;
              if (controller.isTargetLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (isEmpty) {
                return const Center(
                  child: Text("Không có chiến dịch nào"),
                );
              }
              return TargetList(scrollController: scrollController);
            },
          ),
        ],
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TodoHomeStore controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        controller: widget.scrollController,
        padding: const EdgeInsets.only(top: 4, bottom: 26),
        child: Column(
          children: [
            controller.tasks.value.availableTasks.isNotEmpty
                ? StatusDivider(
                    status: 'Sắp diễn ra',
                    color: StatusColorMap[TodoStatus.available]!,
                  )
                : Container(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.tasks.value.availableTasks.length,
              itemBuilder: (context, index) {
                return Obx(() => TaskItem(
                      task: controller.tasks.value.availableTasks[index],
                    ));
              },
            ),
            controller.tasks.value.inprogressTasks.isNotEmpty
                ? StatusDivider(
                    status: 'Đang diễn ra',
                    color: StatusColorMap[TodoStatus.inprogress]!,
                  )
                : Container(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.tasks.value.inprogressTasks.length,
              itemBuilder: (context, index) {
                return Obx(() => TaskItem(
                      task: controller.tasks.value.inprogressTasks[index],
                    ));
              },
            ),
            controller.tasks.value.pendingTasks.isNotEmpty
                ? StatusDivider(
                    status: 'Chờ xác nhận',
                    color: StatusColorMap[TodoStatus.pending]!,
                  )
                : Container(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.tasks.value.pendingTasks.length,
              itemBuilder: (context, index) {
                return Obx(() => TaskItem(
                      task: controller.tasks.value.pendingTasks[index],
                    ));
              },
            ),
            controller.tasks.value.completedTasks.isNotEmpty
                ? StatusDivider(
                    status: "Đã hoàn thành",
                    color: StatusColorMap[TodoStatus.completed]!,
                  )
                : Container(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.tasks.value.completedTasks.length,
              itemBuilder: (context, index) {
                return Obx(() => TaskItem(
                      task: controller.tasks.value.completedTasks[index],
                    ));
              },
            ),
            controller.tasks.value.notCompletedTasks.isNotEmpty
                ? StatusDivider(
                    status: "Chưa hoàn thành",
                    color: StatusColorMap[TodoStatus.notCompleted]!,
                  )
                : Container(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.tasks.value.notCompletedTasks.length,
              itemBuilder: (context, index) {
                return Obx(() => TaskItem(
                      task: controller.tasks.value.notCompletedTasks[index],
                    ));
              },
            ),
            controller.tasks.value.expiredTasks.isNotEmpty
                ? StatusDivider(
                    status: "Đã quá hạn",
                    color: StatusColorMap[TodoStatus.expired]!,
                  )
                : Container(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.tasks.value.expiredTasks.length,
              itemBuilder: (context, index) {
                return Obx(() => TaskItem(
                      task: controller.tasks.value.expiredTasks[index],
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TargetList extends StatefulWidget {
  final ScrollController scrollController;
  const TargetList({super.key, required this.scrollController});

  @override
  State<TargetList> createState() => _TargetListState();
}

class _TargetListState extends State<TargetList> {
  TodoHomeStore controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      padding: const EdgeInsets.only(top: 8, bottom: 26),
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.targets.length,
            itemBuilder: (context, index) {
              return Obx(
                () => TargetItem(
                  target: controller.targets[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
