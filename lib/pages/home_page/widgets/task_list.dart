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
                  controller.tasks.value.expiredTasks.isEmpty;
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
  TodoHomeStore controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      padding: const EdgeInsets.only(top: 8, bottom: 26),
      child: Column(
        children: [
          controller.tasks.value.pendingTasks.isNotEmpty
              ? StatusDivider(
                  status: 'Chưa thực hiện',
                  color: primary.shade400,
                )
              : Container(), // TODO: pending task
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
                  color: green.shade500,
                )
              : Container(), // TODO: completed task
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
          controller.tasks.value.expiredTasks.isNotEmpty
              ? StatusDivider(
                  status: "Đã quá hạn",
                  color: neutral.shade800,
                )
              : Container(), // TODO: completed task
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
            itemCount: controller.targets.value.length,
            itemBuilder: (context, index) {
              return Obx(
                () => TargetItem(
                  target: controller.targets.value[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
