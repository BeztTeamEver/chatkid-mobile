import 'package:chatkid_mobile/constants/todo.dart';
import 'package:chatkid_mobile/models/todo_model.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/feedback_card.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/head_card.dart';
import 'package:chatkid_mobile/pages/home_page/todo_detail/widgets/help_card.dart';
import 'package:chatkid_mobile/services/tts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    final contentWidgets = [
      widget.task.status != TodoStatus.submitted ? HelpCard() : Container(),
      widget.task.status == TodoStatus.submitted ||
              widget.task.status == TodoStatus.completed
          ? FeedBackCard()
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
    );
  }
}
