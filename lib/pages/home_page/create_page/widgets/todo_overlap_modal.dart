import 'package:chatkid_mobile/constants/task_status.dart';
import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/models/user_model.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/timeline_head.dart';
import 'package:chatkid_mobile/providers/todo_provider.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/widgets/avatar_png.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/custom_progress_indicator.dart';
import 'package:chatkid_mobile/widgets/label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TodoOverlapModal extends ConsumerStatefulWidget {
  final List<UserModel> users;
  final DateTime startTime;
  final DateTime endTime;
  final bool isFull;
  final Function? onConfirm;
  const TodoOverlapModal({
    required this.endTime,
    super.key,
    this.isFull = false,
    this.onConfirm,
    required this.users,
    required this.startTime,
  });

  @override
  ConsumerState<TodoOverlapModal> createState() => _TodoOverlapModalState();
}

class _TodoOverlapModalState extends ConsumerState<TodoOverlapModal> {
  bool isLoading = false;
  double height = 0;
  @override
  void initState() {
    super.initState();
  }

  List<TaskModel> filterTask(List<TaskModel> tasks) {
    final newTask = tasks.fold(<TaskModel>[], (previousValue, element) {
      if (element.startTime.isBefore(widget.endTime) &&
          element.endTime.isAfter(widget.startTime) &&
          element.status != TodoStatus.canceled &&
          element.status != TodoStatus.completed) {
        previousValue.add(element);
      }
      return previousValue;
    });
    newTask.sort((a, b) => a.startTime.compareTo(b.startTime));

    return newTask;
  }

  @override
  Widget build(BuildContext context) {
    final taskFuture =
        ref.watch(fetchTaskByDate(TodoFilter(date: widget.startTime)).future);
    String userNames = widget.users
        .fold(
            '',
            (previousValue, element) =>
                previousValue + ", " + (element.name ?? ""))
        .replaceFirst(", ", "")
        .trim();
    final lastComma = userNames.lastIndexOf(", ");
    if (lastComma != -1) {
      userNames = userNames.replaceRange(lastComma, lastComma + 2, " và ");
    }
    return BottomSheet(
      onClosing: () {},
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thời gian trùng với công việc của ${userNames}. ${widget.isFull ? 'Bạn hãy quay lại tạo thời gian khác hoặc giao cho bé khác nhé!' : 'Bạn vẫn muốn tạo việc với những thành viên còn lại không?'}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 16,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: taskFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error'),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final data = snapshot.data;
                    if (data == null) {
                      return const Center(
                        child: Text('Không có dữ liệu'),
                      );
                    }
                    try {
                      final task = filterTask(data);
                      final members = LocalStorage.instance.getMembers();
                      return ListView.builder(
                        itemCount: task.length,
                        itemBuilder: (context, index) {
                          final currentMember = members.firstWhereOrNull(
                              (element) => element.id == task[index].memberId);
                          if (currentMember == null) {
                            return Container();
                          }
                          return Container(
                            padding: const EdgeInsets.all(4),
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TaskItemCard(
                                task: task[index], user: currentMember),
                          );
                        },
                      );
                    } catch (e, s) {
                      Logger().e(e, stackTrace: s);
                    }
                    return Container();
                  },
                ),
              ),
            ),
            Container(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final buttonWidth = constraints.maxWidth / 2 - 5;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width:
                            !widget.isFull ? buttonWidth : constraints.maxWidth,
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLoading) {
                              return;
                            }

                            Navigator.of(context).pop();
                          },
                          style:
                              ElevatedButtonTheme.of(context).style!.copyWith(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.transparent,
                                    ),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: isLoading
                                              ? neutral.shade500
                                              : primary.shade500,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                    shadowColor: const MaterialStatePropertyAll(
                                      Colors.transparent,
                                    ),
                                  ),
                          child: Text(
                            "Quay lại",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: isLoading
                                      ? neutral.shade500
                                      : primary.shade500,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                          ),
                        ),
                      ), // Ca
                      !widget.isFull
                          ? Container(
                              width: buttonWidth,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (isLoading) {
                                    return;
                                  }
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    if (widget.onConfirm != null) {
                                      await widget.onConfirm!();
                                    }
                                    Navigator.of(context).pop(true);
                                  } catch (e) {
                                    Logger().e(e);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.of(context).pop(false);
                                  } finally {}
                                },
                                style: ElevatedButtonTheme.of(context)
                                    .style!
                                    .copyWith(
                                      padding: const MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 4,
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        isLoading
                                            ? neutral.shade500
                                            : primary.shade500,
                                      ),
                                    ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isLoading != true
                                        ? Container()
                                        : Container(
                                            width: 32,
                                            height: 32,
                                            child:
                                                const CustomCircleProgressIndicator()),
                                    Text(
                                      "Xác nhận",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(), //
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TaskItemCard extends StatefulWidget {
  final TaskModel task;
  final UserModel user;
  const TaskItemCard({super.key, required this.task, required this.user});

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TimelineHead(task: widget.task),
        Expanded(
          child: CustomCard(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            height: 110,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: AvatarPng(
                      imageUrl: widget.user.avatarUrl,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.user.name ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: neutral.shade500,
                        ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Label(
                    type: StatusLabelTypeMap[widget.task.status]!,
                    label: StatusTextMap[widget.task.status]!,
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.task.taskType.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      color: neutral.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.task.note,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      color: neutral.shade600,
                    ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
