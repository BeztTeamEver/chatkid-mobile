import 'package:chatkid_mobile/constants/account_list.dart';
import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/pages/finish_task_page/finish_task_route.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/feedback_card.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/head_card.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/help_card.dart';
import 'package:chatkid_mobile/providers/user_provider.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:chatkid_mobile/utils/local_storage.dart';
import 'package:chatkid_mobile/utils/route.dart';
import 'package:chatkid_mobile/widgets/full_width_button.dart';
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
  TtsService _ttsService = TtsService().instance;

  Future<void> _speak(String message) async {
    await _ttsService.speak(message);
  }

  @override
  Widget build(BuildContext context) {
    final user = LocalStorage.instance.getUser();
    final contentWidgets = [
      widget.task.status != TodoStatus.pending ? HelpCard() : Container(),
      widget.task.status == TodoStatus.pending ||
              widget.task.status == TodoStatus.completed
          ? FeedBackCard()
          : Container(),
    ];
    Logger().i(widget.task.toJson());
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
      floatingActionButton: widget.task.status == TodoStatus.inprogress &&
              user.role == RoleConstant.Child
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: FullWidthButton(
                onPressed: () {
                  Navigator.push(context, createRoute(() => FinishTaskRoute()));
                },
                child: Text(
                  'Hoàn thành công việc',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          : null,
    );
  }
}
