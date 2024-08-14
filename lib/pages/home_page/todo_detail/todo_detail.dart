import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/controller/todo_page/todo_home_store.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/pages/finish_task_page/finish_task_route.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/feedback_card.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/head_card.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/help_card.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/services/todo_service.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/themes/color_scheme.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/confirmation/confirm_modal.dart';
import 'package:chatkid_mobile/widgets/custom_progress_indicator.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
import 'package:chatkid_mobile/widgets/secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TodoDetail extends StatefulWidget {
  final String id;
  final TaskModel task;
  const TodoDetail({super.key, required this.id, required this.task});

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  final TodoHomeStore store = Get.find();
  TtsService _ttsService = TtsService().instance;

  Future<void> _speak(String message) async {
    await _ttsService.speak(message);
  }

  @override
  Widget build(BuildContext context) {
    final user = LocalStorage.instance.getUser();
    final contentWidgets = [
      widget.task.status != TodoStatus.pending
          ? HelpCard(
              task: widget.task,
            )
          : Container(),
      widget.task.feedbackEmoji != null ||
              widget.task.feedbackVoice != null ||
              widget.task.evidence != null
          ? FeedBackCard(
              task: widget.task,
            )
          : Container(),
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeadCard(id: widget.id, task: widget.task),
                ...contentWidgets,
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: widget.task.status == TodoStatus.pending
      //     ? ActionButtons(
      //         onCancel: onReject,
      //         onConfirm: onAccept,
      //       )
      //     : null,
    );
  }
}

class ActionButtons extends StatefulWidget {
  final Function? onConfirm;
  final Function? onCancel;

  const ActionButtons({super.key, this.onConfirm, this.onCancel});

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool isLoading = false;
  bool isCancelLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                if (isCancelLoading) {
                  return;
                }
                await showDialog(
                  context: context,
                  builder: (context) => ConfirmModal(
                    title: "Xác nhận trẻ không hoàn thành?",
                    content:
                        "Bạn có chắc muốn xác nhận trẻ chưa hoàn thành không?",
                    confirmText: "Xác nhận",
                    isLoading: isCancelLoading,
                    onConfirm: () async {
                      setState(() {
                        isCancelLoading = true;
                      });
                      if (widget.onCancel != null) {
                        await widget.onCancel?.call();
                        setState(() {
                          isCancelLoading = false;
                        });
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                );
              },
              style: ElevatedButtonTheme.of(context).style!.copyWith(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.transparent,
                    ),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: isLoading || isCancelLoading
                              ? neutral.shade500
                              : primary.shade500,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    shadowColor: MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isCancelLoading != true
                      ? Container()
                      : Container(
                          width: 32,
                          height: 32,
                          child: CustomCircleProgressIndicator(
                            color: neutral.shade500,
                          )),
                  Text(
                    "Từ chối",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: isLoading || isCancelLoading
                              ? neutral.shade500
                              : primary.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                if (isLoading) {
                  return;
                }
                await showDialog(
                  context: context,
                  builder: (context) => ConfirmModal(
                    title: "Xác nhận trẻ đã hoàn thành?",
                    content:
                        "Bạn có chắc muốn xác nhận trẻ đã hoàn thành không?",
                    confirmText: "Xác nhận",
                    isLoading: isLoading,
                    onConfirm: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        if (widget.onConfirm != null) {
                          await widget.onConfirm!();
                        }
                        Navigator.of(context).pop();
                      } catch (e) {
                        Logger().e(e);
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                );
              },
              style: ElevatedButtonTheme.of(context).style!.copyWith(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      isLoading || isCancelLoading
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
                          child: CustomCircleProgressIndicator()),
                  Text(
                    "Xác nhận",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
