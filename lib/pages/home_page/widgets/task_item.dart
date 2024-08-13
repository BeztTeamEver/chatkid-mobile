import 'package:chatkid_mobile/constants/date.dart';
import 'package:chatkid_mobile/constants/task_status.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/todo_detail.dart';
import 'package:chatkid_mobile/pages/home_page/widgets/timeline_head.dart';
import 'package:chatkid_mobile/pages/routes/todo_create_route.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/widgets/button_icon.dart';
import 'package:chatkid_mobile/widgets/confirmation/confirm_modal.dart';
import 'package:chatkid_mobile/widgets/custom_card.dart';
import 'package:chatkid_mobile/widgets/label.dart';
import 'package:chatkid_mobile/widgets/svg_icon.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TtsService _ttsService = TtsService().instance;

  Future<void> _speak(String message) async {
    await _ttsService.speak(message);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          TimelineHead(task: widget.task),
          Expanded(
            child: CustomCard(
              onLongPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  enableDrag: true,
                  showDragHandle: true,
                  builder: (context) {
                    return TaskActions(
                      id: widget.task.id,
                      task: widget.task,
                    );
                  },
                );
              },
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return TodoDetail(
                        id: widget.task.id,
                        task: widget.task,
                      );
                    },
                  ),
                );
              },
              heroTag: widget.task.id,
              padding: const EdgeInsets.all(14),
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Hero(
                          tag: widget.task.id,
                          child: Image.network(
                            widget.task.taskType.imageHomeUrl!,
                            fit: BoxFit.fill,
                            width: 110,
                          ),
                        ),
                        Label(
                            width: 118,
                            type: StatusLabelTypeMap[widget.task.status]!,
                            label: StatusTextMap[widget.task.status]!),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 24,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.task.taskType.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       // TODO: use task time
                          //       "${widget.task.startTime.format(DateConstants.timeFormatWithoutSecond)} ${widget.task.finishTime != null ? widget.task.finishTime?.format(DateConstants.timeFormatWithoutSecond) : ""}",
                          //       style:
                          //           Theme.of(context).textTheme.bodyMedium!.copyWith(
                          //                 fontSize: 14,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SvgIcon(
                                icon: 'coin',
                                size: 24,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "X ${widget.task.numberOfCoin ?? 0}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: neutral.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 12,
                                color: neutral.shade400,
                                margin: const EdgeInsets.only(left: 8),
                              ),
                              ButtonIcon(
                                padding: 0,
                                onPressed: () {
                                  _speak(widget.task.note ?? "");
                                },
                                icon: "volumn",
                                iconSize: 24,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskActions extends StatefulWidget {
  final String id;
  final TaskModel task;
  const TaskActions({super.key, required this.id, required this.task});

  @override
  State<TaskActions> createState() => TaskActionsState();
}

class TaskActionsState extends State<TaskActions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final TodoHomeStore todoHomeStore = Get.find();
  double _height = 100;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: neutral.shade400, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            onTap: () {
              todoHomeStore.setTask(widget.id);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return TodoCreateRoute(id: widget.id);
                  },
                ),
              );
            },
            title: const Text("Chỉnh sửa công việc"),
            leading: SvgIcon(
              icon: 'edit',
              size: 24,
              color: primary.shade500,
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: neutral.shade400, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => ConfirmModal(
                  content: "Công việc sau khi xóa sẽ không thể hoàn tác lại ",
                  title:
                      "Bạn xác nhận xóa công việc \n ${widget.task.taskType.name} từ ${widget.task.startTime.format(DateConstants.timeFormatWithoutSecond)} đến ${widget.task.endTime.format(DateConstants.timeFormatWithoutSecond)} không?",
                  imageUrl: widget.task.taskType.imageHomeUrl,
                  onConfirm: () async {
                    await todoHomeStore.deleteTask(widget.id);
                  },
                ),
              ).then((value) {
                if (value != null && value) {
                  Navigator.of(context).pop();
                }
              });
              // Navigator.of(context).pop();
            },
            title: const Text("Xóa công việc"),
            leading: SvgIcon(
              icon: 'trash',
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
